From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 07/17] pwm: sti: Rename channel => device
Date: Tue, 16 Aug 2016 10:34:58 +0100
Message-ID: <20160816093508.28307-8-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

This is to bring the terminology used in the STi PWM driver more
into line with the PWM subsystem.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 92abbd5..5c7fdd1 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/time.h>
 
-#define STI_DS_REG(ch)	(4 * (ch))	/* Channel's Duty Cycle register */
+#define STI_DS_REG(ch)	(4 * (ch))	/* Device's Duty Cycle register */
 #define STI_PWMCR	0x50		/* Control/Config register */
 #define STI_INTEN	0x54		/* Interrupt Enable/Disable register */
 #define PWM_PRESCALE_LOW_MASK		0x0f
@@ -40,7 +40,7 @@ enum {
 
 struct sti_pwm_compat_data {
 	const struct reg_field *reg_fields;
-	unsigned int num_chan;
+	unsigned int num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
 };
@@ -130,13 +130,13 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Allow configuration changes if one of the
 	 * following conditions satisfy.
-	 * 1. No channels have been configured.
-	 * 2. Only one channel has been configured and the new request
-	 *    is for the same channel.
-	 * 3. Only one channel has been configured and the new request is
-	 *    for a new channel and period of the new channel is same as
+	 * 1. No devices have been configured.
+	 * 2. Only one device has been configured and the new request
+	 *    is for the same device.
+	 * 3. Only one device has been configured and the new request is
+	 *    for a new device and period of the new device is same as
 	 *    the current configured period.
-	 * 4. More than one channels are configured and period of the new
+	 * 4. More than one devices are configured and period of the new
 	 *    requestis the same as the current period.
 	 */
 	if (!ncfg ||
@@ -201,7 +201,7 @@ static int sti_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret = 0;
 
 	/*
-	 * Since we have a common enable for all PWM channels,
+	 * Since we have a common enable for all PWM devices,
 	 * do not enable if already enabled.
 	 */
 	mutex_lock(&pc->sti_pwm_lock);
@@ -259,11 +259,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	const struct reg_field *reg_fields;
 	struct device_node *np = dev->of_node;
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	u32 num_chan;
+	u32 num_devs;
 
-	of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
-	if (num_chan)
-		cdata->num_chan = num_chan;
+	of_property_read_u32(np, "st,pwm-num-chans", &num_devs);
+	if (num_devs)
+		cdata->num_devs = num_devs;
 
 	reg_fields = cdata->reg_fields;
 
@@ -330,7 +330,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields   = &sti_pwm_regfields[0];
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt  = 255;
-	cdata->num_chan     = 1;
+	cdata->num_devs     = 1;
 
 	pc->cdata = cdata;
 	pc->dev = dev;
@@ -362,7 +362,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = pc->cdata->num_chan;
+	pc->chip.npwm = pc->cdata->num_devs;
 	pc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pc->chip);
@@ -381,7 +381,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < pc->cdata->num_chan; i++)
+	for (i = 0; i < pc->cdata->num_devs; i++)
 		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->clk);
-- 
2.9.0
