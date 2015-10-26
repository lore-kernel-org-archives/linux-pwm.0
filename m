From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: [PATCH 10/10] pwm: sunxi: Add possibility to pulse the sunxi pwm output
Date: Mon, 26 Oct 2015 22:32:41 +0100
Message-ID: <1445895161-2317-11-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

With the new pulse mode addition to the PWM framework, we can make use
of this for the sunxi PWM.

WARNING: Do not merge yet, currently, we can only pulse once and a
manual disable is required to 'reset' the PWM framework. I haven't
thought through how to automatically 'disable' the PWM after the pulse
is finished and need some guidance here.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/pwm/pwm-sun4i.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6347ca8..8370cca 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -32,7 +32,7 @@
 #define PWM_EN			BIT(4)
 #define PWM_ACT_STATE		BIT(5)
 #define PWM_CLK_GATING		BIT(6)
-#define PWM_MODE		BIT(7)
+#define PWM_MODE_PULSE		BIT(7)
 #define PWM_PULSE		BIT(8)
 #define PWM_BYPASS		BIT(9)
 
@@ -166,6 +166,8 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	if (pulse_count)
+		val |= BIT_CH(PWM_MODE_PULSE, pwm->hwpwm);
 	if (sun4i_pwm->data->has_rdy && (val & PWM_RDY(pwm->hwpwm))) {
 		ret = -EBUSY;
 		goto out;
@@ -237,7 +239,10 @@ static int sun4i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	val |= BIT_CH(PWM_EN, pwm->hwpwm);
+	if (pwm->pulse_count)
+		val |= BIT_CH(PWM_PULSE, pwm->hwpwm);
+	else
+		val |= BIT_CH(PWM_EN, pwm->hwpwm);
 	val |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -350,9 +355,12 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	}
 
 	val = sun4i_pwm_readl(pwm, PWM_CTRL_REG);
-	for (i = 0; i < pwm->chip.npwm; i++)
+	for (i = 0; i < pwm->chip.npwm; i++) {
 		if (!(val & BIT_CH(PWM_ACT_STATE, i)))
 			pwm->chip.pwms[i].polarity = PWM_POLARITY_INVERSED;
+
+		pwm_set_pulse_count_max(&pwm->chip.pwms[i], 1);
+	}
 	clk_disable_unprepare(pwm->clk);
 
 	return 0;
-- 
2.6.1
