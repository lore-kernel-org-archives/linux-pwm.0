From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 12/17] pwm: sti: Initialise PWM Capture device data
Date: Tue, 16 Aug 2016 10:35:03 +0100
Message-ID: <20160816093508.28307-13-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160816093508.28307-1-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Each PWM Capture device is allocated a structure to hold its own
state.  During a capture the device may be partaking in one of 3
phases.  Initial (rising) phase change, a subsequent (falling)
phase change indicating end of the duty-cycle phase and finally
a final (rising) phase change indicating the end of the period.
The timer value snapshot each event is held in a variable of the
same name, and the phase number (0, 1, 2) is contained in the
index variable.  Other device specific information, such as GPIO
pin, the IRQ wait queue and locking is also contained in the
structure.  This patch initialises this structure for each of
the available devices.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/pwm/pwm-sti.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index b596783..16c3f4d 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -18,8 +19,10 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/wait.h>
 
 #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Device's Duty Cycle register */
 #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
@@ -64,9 +67,17 @@ enum sti_cpt_edge {
 	CPT_EDGE_BOTH,
 };
 
+struct sti_cpt_ddata {
+	u32 snapshot[3];
+	int index;
+	struct mutex lock;
+	wait_queue_head_t wait;
+};
+
 struct sti_pwm_compat_data {
 	const struct reg_field *reg_fields;
-	unsigned int num_devs;
+	unsigned int pwm_num_devs;
+	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
 };
@@ -307,10 +318,15 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	struct device_node *np = dev->of_node;
 	struct sti_pwm_compat_data *cdata = pc->cdata;
 	u32 num_devs;
+	int ret;
 
-	of_property_read_u32(np, "st,pwm-num-chans", &num_devs);
-	if (num_devs)
-		cdata->num_devs = num_devs;
+	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
+	if (!ret)
+		cdata->pwm_num_devs = num_devs;
+
+	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
+	if (!ret)
+		cdata->cpt_num_devs = num_devs;
 
 	reg_fields = cdata->reg_fields;
 
@@ -350,6 +366,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	struct sti_pwm_compat_data *cdata;
 	struct sti_pwm_chip *pc;
 	struct resource *res;
+	unsigned int devnum;
 	int ret;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
@@ -378,7 +395,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields   = &sti_pwm_regfields[0];
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt  = 255;
-	cdata->num_devs     = 1;
+	cdata->pwm_num_devs = 1;
+	cdata->cpt_num_devs = 0;
 
 	pc->cdata = cdata;
 	pc->dev = dev;
@@ -416,7 +434,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = pc->cdata->num_devs;
+	pc->chip.npwm = pc->cdata->pwm_num_devs;
 	pc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pc->chip);
@@ -426,6 +444,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	for (devnum = 0; devnum < cdata->cpt_num_devs; devnum++) {
+		struct sti_cpt_ddata *ddata;
+
+		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+		if (!ddata)
+			return -ENOMEM;
+
+		init_waitqueue_head(&ddata->wait);
+		mutex_init(&ddata->lock);
+
+		pwm_set_chip_data(&pc->chip.pwms[devnum], ddata);
+	}
+
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
@@ -436,7 +467,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < pc->cdata->num_devs; i++)
+	for (i = 0; i < pc->cdata->pwm_num_devs; i++)
 		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->pwm_clk);
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
