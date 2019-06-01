From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 20/74] pwm: meson: Use the spin-lock only to protect register modifications
Date: Sat,  1 Jun 2019 09:24:07 -0400
Message-ID: <20190601132501.27021-20-sashal@kernel.org>
References: <20190601132501.27021-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601132501.27021-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Neil Armstrong <narmstrong@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit f173747fffdf037c791405ab4f1ec0eb392fc48e ]

Holding the spin-lock for all of the code in meson_pwm_apply() can
result in a "BUG: scheduling while atomic". This can happen because
clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
Only hold the spin-lock when modifying registers to solve this.

The reason why we need a spin-lock in the driver is because the
REG_MISC_AB register is shared between the two channels provided by one
PWM controller. The only functions where REG_MISC_AB is modified are
meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
in there need to be protected by the spin-lock.

The original code also used the spin-lock to protect the values in
struct meson_pwm_channel. This could be necessary if two consumers can
use the same PWM channel. However, PWM core doesn't allow this so we
don't need to protect the values in struct meson_pwm_channel with a
lock.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9d5bd7d5c610b..f58a4867b5194 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -110,6 +110,10 @@ struct meson_pwm {
 	const struct meson_pwm_data *data;
 	void __iomem *base;
 	u8 inverter_mask;
+	/*
+	 * Protects register (write) access to the REG_MISC_AB register
+	 * that is shared between the two PWMs.
+	 */
 	spinlock_t lock;
 };
 
@@ -230,6 +234,7 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 {
 	u32 value, clk_shift, clk_enable, enable;
 	unsigned int offset;
+	unsigned long flags;
 
 	switch (id) {
 	case 0:
@@ -250,6 +255,8 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 		return;
 	}
 
+	spin_lock_irqsave(&meson->lock, flags);
+
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
 	value |= channel->pre_div << clk_shift;
@@ -262,11 +269,14 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 	value = readl(meson->base + REG_MISC_AB);
 	value |= enable;
 	writel(value, meson->base + REG_MISC_AB);
+
+	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
 static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 {
 	u32 value, enable;
+	unsigned long flags;
 
 	switch (id) {
 	case 0:
@@ -281,9 +291,13 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 		return;
 	}
 
+	spin_lock_irqsave(&meson->lock, flags);
+
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~enable;
 	writel(value, meson->base + REG_MISC_AB);
+
+	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -291,19 +305,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	unsigned long flags;
 	int err = 0;
 
 	if (!state)
 		return -EINVAL;
 
-	spin_lock_irqsave(&meson->lock, flags);
-
 	if (!state->enabled) {
 		meson_pwm_disable(meson, pwm->hwpwm);
 		channel->state.enabled = false;
 
-		goto unlock;
+		return 0;
 	}
 
 	if (state->period != channel->state.period ||
@@ -324,7 +335,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
 				     state->duty_cycle, state->period);
 		if (err < 0)
-			goto unlock;
+			return err;
 
 		channel->state.polarity = state->polarity;
 		channel->state.period = state->period;
@@ -336,9 +347,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		channel->state.enabled = true;
 	}
 
-unlock:
-	spin_unlock_irqrestore(&meson->lock, flags);
-	return err;
+	return 0;
 }
 
 static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.20.1
