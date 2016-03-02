From: Lee Jones <lee.jones@linaro.org>
Subject: [RESEND 10/11] pwm: sti: Enable PWM Capture
Date: Wed,  2 Mar 2016 15:32:08 +0000
Message-ID: <1456932729-9667-11-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Once all functionality is in place, we provide the means to
enable PWM Capture.  Here we are simply obtaining the
associated regmap and twiddling the relevant enable register
bits.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 8de9b4a..93cf20e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -279,6 +279,13 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 				pwm->hwpwm);
 			goto out;
 		}
+
+		ret = regmap_field_write(pc->pwm_cpt_en, 1);
+		if (ret) {
+			dev_err(dev, "failed to enable PWM capture:%d\n",
+				pwm->hwpwm);
+			goto out;
+		}
 	}
 	pc->en_count++;
 out:
@@ -296,6 +303,7 @@ static void sti_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return;
 	}
 	regmap_field_write(pc->pwm_out_en, 0);
+	regmap_field_write(pc->pwm_cpt_en, 0);
 
 	clk_disable(pc->pwm_clk);
 	clk_disable(pc->cpt_clk);
@@ -492,6 +500,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (IS_ERR(pc->pwm_out_en))
 		return PTR_ERR(pc->pwm_out_en);
 
+	pc->pwm_cpt_en = devm_regmap_field_alloc(dev, pc->regmap,
+						 reg_fields[PWM_CPT_EN]);
+	if (IS_ERR(pc->pwm_cpt_en))
+		return PTR_ERR(pc->pwm_cpt_en);
+
 	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
 						 reg_fields[PWM_CPT_INT_EN]);
 	if (IS_ERR(pc->pwm_cpt_int_en))
-- 
1.9.1
