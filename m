From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
Date: Wed,  7 Mar 2018 02:07:17 +0000
Message-ID: <20180307020719.6675-4-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBFMU7XKAKGQECF2VSBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180307020719.6675-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

While the PWM IP in the Allwinner H6 SoC is fully compatible to those
used in older SoCs (H3, A64), it features a dedicated reset line which
needs to be de-asserted.
Add support for an optional "resets" DT property in our pwm-sun4i probe
routine, and assert and de-assert the reset line, where needed.
This allows to enable PWM support on the H6.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 078172dee462..4eefb27fe80b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -17,6 +17,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/time.h>
@@ -79,6 +80,7 @@ struct sun4i_pwm_data {
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
+	struct reset_control *reset;
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
@@ -206,7 +208,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
 	u32 ctrl;
-	int ret;
+	int ret = 0;
 	unsigned int delay_us;
 	unsigned long now;
 
@@ -218,6 +220,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			dev_err(chip->dev, "failed to enable PWM clock\n");
 			return ret;
 		}
+
+		/* Deassert reset if we have a reset control */
+		if (sun4i_pwm->reset) {
+			ret = reset_control_deassert(sun4i_pwm->reset);
+			if (ret) {
+				dev_err(chip->dev,
+					"Cannot deassert reset control\n");
+				clk_disable_unprepare(sun4i_pwm->clk);
+
+				return ret;
+			}
+		}
 	}
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
@@ -234,7 +248,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			dev_err(chip->dev, "period exceeds the maximum value\n");
 			spin_unlock(&sun4i_pwm->ctrl_lock);
 			if (!cstate.enabled)
-				clk_disable_unprepare(sun4i_pwm->clk);
+				goto out_disable;
+
 			return ret;
 		}
 
@@ -274,10 +289,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled)
 		return 0;
 
-	if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
-		clk_disable_unprepare(sun4i_pwm->clk);
-		return 0;
-	}
+	if (!sun4i_pwm->needs_delay[pwm->hwpwm])
+		goto out_disable;
 
 	/* We need a full period to elapse before disabling the channel. */
 	now = jiffies;
@@ -299,9 +312,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
+out_disable:
 	clk_disable_unprepare(sun4i_pwm->clk);
+	if (sun4i_pwm->reset)
+		reset_control_assert(sun4i_pwm->reset);
 
-	return 0;
+	return ret;
 }
 
 static const struct pwm_ops sun4i_pwm_ops = {
@@ -370,6 +386,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	pwm->reset = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(pwm->reset))
+		return PTR_ERR(pwm->reset);
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-- 
2.14.1
