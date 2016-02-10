From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Wed, 10 Feb 2016 13:02:24 +0000
Message-ID: <1455109348-32767-8-git-send-email-lee.jones@linaro.org>
References: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455109348-32767-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com
Cc: kernel@stlinux.com, maxime.coquelin@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Each PWM Capture channel is allocated a structure to hold its own
state.  During a capture the channel may be partaking in one of 3
phases.  Initial (rising) phase change, a subsequent (falling)
phase change indicating end of the duty-cycle phase and finally
a final (rising) phase change indicating the end of the period.
The timer value snapshot each event is held in a variable of the
same name, and the phase number (0, 1, 2) is contained in the
index variable.  Other channel specific information, such as GPIO
pin, the IRQ wait queue and locking is also contained in the
structure.  This patch initialises this structure for each of
the available channels.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 9e6b1c8..fca692a 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -11,15 +11,19 @@
  */
 
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/math64.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/wait.h>
 
 #define PWM_OUT_VAL(x)	(0x00 + (4 * (x))) /* Channel's Duty Cycle register */
 #define PWM_CPT_VAL(x)	(0x10 + (4 * (x))) /* Capture value */
@@ -64,9 +68,18 @@ enum sti_cpt_edge {
 	CPT_EDGE_BOTH,
 };
 
+struct sti_cpt_data {
+	u32 snapshot[3];
+	int index;
+	int gpio;
+	struct mutex lock;
+	wait_queue_head_t wait;
+};
+
 struct sti_pwm_compat_data {
 	const struct reg_field *reg_fields;
-	unsigned int num_chan;
+	unsigned int pwm_num_chan;
+	unsigned int cpt_num_chan;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
 };
@@ -77,6 +90,7 @@ struct sti_pwm_chip {
 	struct clk *cpt_clk;
 	struct regmap *regmap;
 	struct sti_pwm_compat_data *cdata;
+	struct sti_cpt_data *cpt_data[STI_MAX_CPT_CHANS];
 	struct regmap_field *prescale_low;
 	struct regmap_field *prescale_high;
 	struct regmap_field *pwm_out_en;
@@ -307,10 +321,15 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	struct device_node *np = dev->of_node;
 	struct sti_pwm_compat_data *cdata = pc->cdata;
 	u32 num_chan;
+	int ret;
 
-	of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
-	if (num_chan)
-		cdata->num_chan = num_chan;
+	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_chan);
+	if (!ret)
+		cdata->pwm_num_chan = num_chan;
+
+	ret = of_property_read_u32(np, "st,capture-num-chan", &num_chan);
+	if (!ret)
+		cdata->cpt_num_chan = num_chan;
 
 	reg_fields = cdata->reg_fields;
 
@@ -347,9 +366,11 @@ static const struct regmap_config sti_pwm_regmap_config = {
 static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct sti_pwm_compat_data *cdata;
 	struct sti_pwm_chip *pc;
 	struct resource *res;
+	unsigned int chan;
 	int ret;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
@@ -378,7 +399,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields   = &sti_pwm_regfields[0];
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt  = 255;
-	cdata->num_chan     = 1;
+	cdata->pwm_num_chan     = 1;
+	cdata->cpt_num_chan	= 0;
 
 	pc->cdata = cdata;
 	pc->dev = dev;
@@ -389,6 +411,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	for (chan = 0; chan < cdata->cpt_num_chan; chan++) {
+		struct sti_cpt_data *data;
+
+		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		init_waitqueue_head(&data->wait);
+		mutex_init(&data->lock);
+		data->gpio = of_get_named_gpio(np, "capture-gpios", chan);
+		pc->cpt_data[chan] = data;
+	}
+
 	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
 	if (IS_ERR(pc->pwm_clk)) {
 		dev_err(dev, "failed to get PWM clock\n");
@@ -416,7 +451,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
-	pc->chip.npwm = pc->cdata->num_chan;
+	pc->chip.npwm = pc->cdata->pwm_num_chan;
 	pc->chip.can_sleep = true;
 
 	ret = pwmchip_add(&pc->chip);
@@ -436,7 +471,7 @@ static int sti_pwm_remove(struct platform_device *pdev)
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < pc->cdata->num_chan; i++)
+	for (i = 0; i < pc->cdata->pwm_num_chan; i++)
 		pwm_disable(&pc->chip.pwms[i]);
 
 	clk_unprepare(pc->pwm_clk);
-- 
1.9.1
