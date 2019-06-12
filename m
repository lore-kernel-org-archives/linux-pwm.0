From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 08/14] pwm: meson: add the per-channel register offsets and bits in a struct
Date: Wed, 12 Jun 2019 21:59:05 +0200
Message-ID: <20190612195911.4442-9-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

Introduce struct meson_pwm_channel_data which contains the per-channel
offsets for the PWM register and REG_MISC_AB bits. Replace the existing
switch (pwm->hwpwm) statements with an access to the new struct.

This simplifies the code and will make it easier to implement
pwm_ops.get_state() because the switch-case which all per-channel
registers and offsets (as previously implemented in meson_pwm_enable())
doesn't have to be duplicated.

No functional changes intended.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 90 ++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index a4ae3587a3ce..ac7e188155fd 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -39,9 +39,27 @@
 
 #define MESON_NUM_PWMS		2
 
-static const unsigned int mux_reg_shifts[] = {
-	MISC_A_CLK_SEL_SHIFT,
-	MISC_B_CLK_SEL_SHIFT
+static struct meson_pwm_channel_data {
+	u8		reg_offset;
+	u8		clk_sel_shift;
+	u8		clk_div_shift;
+	u32		clk_en_mask;
+	u32		pwm_en_mask;
+} meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
+	{
+		.reg_offset	= REG_PWM_A,
+		.clk_sel_shift	= MISC_A_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_A_CLK_EN,
+		.pwm_en_mask	= MISC_A_EN,
+	},
+	{
+		.reg_offset	= REG_PWM_B,
+		.clk_sel_shift	= MISC_B_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_B_CLK_EN,
+		.pwm_en_mask	= MISC_B_EN,
+	}
 };
 
 struct meson_pwm_channel {
@@ -194,43 +212,26 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
-	u32 value, clk_shift, clk_enable, enable;
-	unsigned int offset;
+	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
+	u32 value;
 
-	switch (pwm->hwpwm) {
-	case 0:
-		clk_shift = MISC_A_CLK_DIV_SHIFT;
-		clk_enable = MISC_A_CLK_EN;
-		enable = MISC_A_EN;
-		offset = REG_PWM_A;
-		break;
-
-	case 1:
-		clk_shift = MISC_B_CLK_DIV_SHIFT;
-		clk_enable = MISC_B_CLK_EN;
-		enable = MISC_B_EN;
-		offset = REG_PWM_B;
-		break;
-
-	default:
-		return;
-	}
+	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
-	value |= channel->pre_div << clk_shift;
-	value |= clk_enable;
+	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
+	value |= channel->pre_div << channel_data->clk_div_shift;
+	value |= channel_data->clk_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
 		FIELD_PREP(PWM_LOW_MASK, channel->lo);
-	writel(value, meson->base + offset);
+	writel(value, meson->base + channel_data->reg_offset);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value |= enable;
+	value |= channel_data->pwm_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -238,26 +239,13 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	u32 value, enable;
 	unsigned long flags;
-
-	switch (pwm->hwpwm) {
-	case 0:
-		enable = MISC_A_EN;
-		break;
-
-	case 1:
-		enable = MISC_B_EN;
-		break;
-
-	default:
-		return;
-	}
+	u32 value;
 
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~enable;
+	value &= ~meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -309,18 +297,7 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state)
 		return;
 
-	switch (pwm->hwpwm) {
-	case 0:
-		mask = MISC_A_EN;
-		break;
-
-	case 1:
-		mask = MISC_B_EN;
-		break;
-
-	default:
-		return;
-	}
+	mask = meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
 
 	value = readl(meson->base + REG_MISC_AB);
 	state->enabled = (value & mask) != 0;
@@ -458,7 +435,8 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		init.num_parents = meson->data->num_parents;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
-		channel->mux.shift = mux_reg_shifts[i];
+		channel->mux.shift =
+				meson_pwm_per_channel_data[i].clk_sel_shift;
 		channel->mux.mask = MISC_CLK_SEL_MASK;
 		channel->mux.flags = 0;
 		channel->mux.lock = &meson->lock;
-- 
2.22.0
