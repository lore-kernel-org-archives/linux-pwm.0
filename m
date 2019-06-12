From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 2/2] pwm: pwm-fsl-ftm: Use write protection for prescaler & polarity
Date: Wed, 12 Jun 2019 16:12:46 +0200
Message-ID: <20190612141246.7366-2-patrick.havelange@essensium.com>
References: <20190612141246.7366-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612141246.7366-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

Modifying the prescaler or polarity value must be done with the
write protection disabled. Currently this is working by chance as
the write protection is in a disabled state by default.
This patch makes sure that we enable/disable the write protection
when needed.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index cd5fe39ab95d..e955b1cdfd2f 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -59,6 +59,21 @@ static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 	return container_of(chip, struct fsl_pwm_chip, chip);
 }
 
+static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
+{
+	u32 val;
+
+	regmap_read(fpc->regmap, FTM_FMS, &val);
+	if (val & FTM_FMS_WPEN)
+		regmap_update_bits(fpc->regmap, FTM_MODE, FTM_MODE_WPDIS,
+				   FTM_MODE_WPDIS);
+}
+
+static void ftm_set_write_protection(struct fsl_pwm_chip *fpc)
+{
+	regmap_update_bits(fpc->regmap, FTM_FMS, FTM_FMS_WPEN, FTM_FMS_WPEN);
+}
+
 static bool fsl_pwm_periodcfg_are_equal(const struct fsl_pwm_periodcfg *a,
 					const struct fsl_pwm_periodcfg *b)
 {
@@ -253,6 +268,8 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 		do_write_period = true;
 	}
 
+	ftm_clear_write_protection(fpc);
+
 	if (do_write_period) {
 		regmap_update_bits(fpc->regmap, FTM_SC, FTM_SC_CLK_MASK,
 				   FTM_SC_CLK(periodcfg.clk_select));
@@ -279,6 +296,8 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 					       fpc->period.mod_period + 1);
 	newstate->duty_cycle = fsl_pwm_ticks_to_ns(fpc, duty);
 
+	ftm_set_write_protection(fpc);
+
 	return 0;
 }
 
@@ -359,6 +378,8 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case FTM_FMS:
+	case FTM_MODE:
 	case FTM_CNT:
 		return true;
 	}
-- 
2.19.1
