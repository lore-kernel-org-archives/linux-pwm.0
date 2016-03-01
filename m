From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: [PATCH 2/3] pwm: kona: Add support for Broadcom iproc pwm controller
Date: Tue,  1 Mar 2016 12:42:48 -0500
Message-ID: <1456854169-9788-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
List-Id: linux-pwm@vger.kernel.org

Update the kona driver to support Broadcom iproc pwm controller

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 drivers/pwm/Kconfig        |   6 +-
 drivers/pwm/pwm-bcm-kona.c | 183 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 163 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8cf0dae..cdbb4f8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -76,9 +76,11 @@ config PWM_ATMEL_TCB
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_IPROC
+	default ARCH_BCM_IPROC
 	help
-	  Generic PWM framework driver for Broadcom Kona PWM block.
+	  Generic PWM framework driver for Broadcom Kona PWM block. The
+	  same block is also used in Broadcom iProc SoC's.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-bcm-kona.
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index c634183..ef152e3a 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -19,6 +19,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
@@ -47,30 +48,90 @@
 
 #define PWM_CONTROL_OFFSET			(0x00000000)
 #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
-#define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
+#define PWM_CONTROL_TYPE_SHIFT(shift, chan)	(shift + chan)
 #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
 #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
 
 #define PRESCALE_OFFSET				(0x00000004)
-#define PRESCALE_SHIFT(chan)			((chan) << 2)
-#define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
+#define PRESCALE_SHIFT				(0x00000004)
+#define PRESCALE_MASK				(0x00000007)
 #define PRESCALE_MIN				(0x00000000)
 #define PRESCALE_MAX				(0x00000007)
 
-#define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
+#define PERIOD_COUNT_OFFSET(offset, chan)	(offset + (chan << 3))
 #define PERIOD_COUNT_MIN			(0x00000002)
 #define PERIOD_COUNT_MAX			(0x00ffffff)
+#define KONA_PERIOD_COUNT_OFFSET		(0x00000008)
 
-#define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
+#define DUTY_CYCLE_HIGH_OFFSET(offset, chan)	(offset + (chan << 3))
 #define DUTY_CYCLE_HIGH_MIN			(0x00000000)
 #define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
+#define KONA_DUTY_CYCLE_HIGH_OFFSET		(0x0000000c)
+
+#define PWM_CHANNEL_CNT				(0x00000006)
+#define SIGNAL_PUSH_PULL			(0x00000001)
+#define PWMOUT_TYPE_SHIFT			(0x00000010)
+
+#define IPROC_PRESCALE_OFFSET			(0x00000024)
+#define IPROC_PRESCALE_SHIFT			(0x00000006)
+#define IPROC_PRESCALE_MAX			(0x0000003f)
+
+#define IPROC_PERIOD_COUNT_OFFSET		(0x00000004)
+#define IPROC_PERIOD_COUNT_MIN			(0x00000002)
+#define IPROC_PERIOD_COUNT_MAX			(0x0000ffff)
+
+#define IPROC_DUTY_CYCLE_HIGH_OFFSET		(0x00000008)
+#define IPROC_DUTY_CYCLE_HIGH_MIN		(0x00000000)
+#define IPROC_DUTY_CYCLE_HIGH_MAX		(0x0000ffff)
+
+#define IPROC_PWM_CHANNEL_CNT			(0x00000004)
+#define IPROC_SIGNAL_PUSH_PULL			(0x00000000)
+#define IPROC_PWMOUT_TYPE_SHIFT			(0x0000000f)
+
+/*
+ * pwm controller reg structure
+ *
+ * @prescale_offset: prescale register offset
+ * @period_offset: period register offset
+ * @duty_offset: duty register offset
+ * @no_of_channels: number of channels
+ * @out_type_shift: out type shift in the register
+ * @signal_type: push-pull or open drain
+ * @prescale_max: prescale max
+ * @prescale_shift: prescale shift in register
+ * @prescale_ch_ascending: prescale ch order in prescale register
+ * @duty_cycle_max: value of max duty cycle
+ * @duty_cycle_min: value of min duty cycle
+ * @period_count_max: max period count val
+ * @period_count_min: min period count val
+ * @smooth_output_support: pwm smooth output support
+ */
+struct kona_pwmc_reg {
+	u32 prescale_offset;
+	u32 period_offset;
+	u32 duty_offset;
+	u32 no_of_channels;
+	u32 out_type_shift;
+	u32 signal_type;
+	u32 prescale_max;
+	u32 prescale_shift;
+	bool prescale_ch_ascending;
+	u32 duty_cycle_max;
+	u32 duty_cycle_min;
+	u32 period_count_max;
+	u32 period_count_min;
+	bool smooth_output_support;
+};
 
 struct kona_pwmc {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
+	const struct kona_pwmc_reg *reg;
 };
 
+static const struct of_device_id bcm_kona_pwmc_dt[];
+
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *_chip)
 {
 	return container_of(_chip, struct kona_pwmc, chip);
@@ -84,7 +145,9 @@ static void kona_pwmc_prepare_for_settings(struct kona_pwmc *kp,
 {
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
-	value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
+	if (kp->reg->smooth_output_support)
+		value |= 1 << PWM_CONTROL_SMOOTH_SHIFT(chan);
+
 	value &= ~(1 << PWM_CONTROL_TRIGGER_SHIFT(chan));
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
@@ -100,7 +163,9 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	unsigned int value = readl(kp->base + PWM_CONTROL_OFFSET);
 
 	/* Set trigger bit and clear smooth bit to apply new settings */
-	value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
+	if (kp->reg->smooth_output_support)
+		value &= ~(1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
+
 	value |= 1 << PWM_CONTROL_TRIGGER_SHIFT(chan);
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
@@ -138,15 +203,17 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dc = div64_u64(val, div);
 
 		/* If duty_ns or period_ns are not achievable then return */
-		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
+		if (pc < kp->reg->period_count_min ||
+						dc < kp->reg->duty_cycle_min)
 			return -EINVAL;
 
 		/* If pc and dc are in bounds, the calculation is done */
-		if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
+		if (pc <= kp->reg->period_count_max &&
+						dc <= kp->reg->duty_cycle_max)
 			break;
 
 		/* Otherwise, increase prescale and recalculate pc and dc */
-		if (++prescale > PRESCALE_MAX)
+		if (++prescale > kp->reg->prescale_max)
 			return -EINVAL;
 	}
 
@@ -156,16 +223,30 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * validated immediately instead of on enable.
 	 */
 	if (pwm_is_enabled(pwm)) {
+		u32 ch_pre_shift = kp->reg->prescale_shift;
+
 		kona_pwmc_prepare_for_settings(kp, chan);
 
-		value = readl(kp->base + PRESCALE_OFFSET);
-		value &= ~PRESCALE_MASK(chan);
-		value |= prescale << PRESCALE_SHIFT(chan);
-		writel(value, kp->base + PRESCALE_OFFSET);
+		if (kp->reg->prescale_ch_ascending)
+			/*
+			 * The prescale bits mask is in ascending
+			 * order in the register
+			 * "ch(n-2)bits..ch(n-1)bits..ch(n)bits".
+			 */
+			ch_pre_shift *= ((kp->reg->no_of_channels - 1) - chan);
+		else
+			ch_pre_shift *= chan;
 
-		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
+		value = readl(kp->base + kp->reg->prescale_offset);
+		value &= ~(kp->reg->prescale_max << ch_pre_shift);
+		value |= prescale << ch_pre_shift;
+		writel(value, kp->base + kp->reg->prescale_offset);
 
-		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
+		writel(pc, kp->base +
+			PERIOD_COUNT_OFFSET(kp->reg->period_offset, chan));
+
+		writel(dc, kp->base +
+			DUTY_CYCLE_HIGH_OFFSET(kp->reg->duty_offset, chan));
 
 		kona_pwmc_apply_settings(kp, chan);
 	}
@@ -231,17 +312,29 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	unsigned int chan = pwm->hwpwm;
 	unsigned int value;
+	u32 ch_pre_shift = kp->reg->prescale_shift;
+
+	if (kp->reg->prescale_ch_ascending)
+		/*
+		 * The prescale bits mask is in ascending order
+		 * in the register "ch(n-2)bits..ch(n-1)bits..ch(n)bits".
+		 */
+		ch_pre_shift *= ((kp->reg->no_of_channels - 1) - chan);
+	else
+		ch_pre_shift *= chan;
 
 	kona_pwmc_prepare_for_settings(kp, chan);
 
 	/* Simulate a disable by configuring for zero duty */
-	writel(0, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
-	writel(0, kp->base + PERIOD_COUNT_OFFSET(chan));
+	writel(0, kp->base +
+			DUTY_CYCLE_HIGH_OFFSET(kp->reg->duty_offset, chan));
+	writel(0, kp->base +
+			PERIOD_COUNT_OFFSET(kp->reg->period_offset, chan));
 
 	/* Set prescale to 0 for this channel */
-	value = readl(kp->base + PRESCALE_OFFSET);
-	value &= ~PRESCALE_MASK(chan);
-	writel(value, kp->base + PRESCALE_OFFSET);
+	value = readl(kp->base + kp->reg->prescale_offset);
+	value &= ~(kp->reg->prescale_max << ch_pre_shift);
+	writel(value, kp->base + kp->reg->prescale_offset);
 
 	kona_pwmc_apply_settings(kp, chan);
 
@@ -263,17 +356,23 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
+	const struct of_device_id *match;
 
 	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
 	if (kp == NULL)
 		return -ENOMEM;
 
+	match = of_match_device(bcm_kona_pwmc_dt, &pdev->dev);
+	if (!match)
+		return -EINVAL;
+
+	kp->reg = (struct kona_pwmc_reg *)match->data;
 	platform_set_drvdata(pdev, kp);
 
 	kp->chip.dev = &pdev->dev;
 	kp->chip.ops = &kona_pwm_ops;
 	kp->chip.base = -1;
-	kp->chip.npwm = 6;
+	kp->chip.npwm = kp->reg->no_of_channels;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
 	kp->chip.can_sleep = true;
@@ -298,7 +397,8 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	/* Set push/pull for all channels */
 	for (chan = 0; chan < kp->chip.npwm; chan++)
-		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
+		value |= (kp->reg->signal_type <<
+			PWM_CONTROL_TYPE_SHIFT(kp->reg->out_type_shift, chan));
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
@@ -323,8 +423,43 @@ static int kona_pwmc_remove(struct platform_device *pdev)
 	return pwmchip_remove(&kp->chip);
 }
 
+static const struct kona_pwmc_reg kona_pwmc_reg_data = {
+	.prescale_offset = PRESCALE_OFFSET,
+	.period_offset = KONA_PERIOD_COUNT_OFFSET,
+	.duty_offset = KONA_DUTY_CYCLE_HIGH_OFFSET,
+	.no_of_channels = PWM_CHANNEL_CNT,
+	.out_type_shift = PWMOUT_TYPE_SHIFT,
+	.signal_type = SIGNAL_PUSH_PULL,
+	.prescale_max = PRESCALE_MAX,
+	.prescale_shift = PRESCALE_SHIFT,
+	.prescale_ch_ascending = false,
+	.duty_cycle_max = DUTY_CYCLE_HIGH_MAX,
+	.duty_cycle_min = DUTY_CYCLE_HIGH_MIN,
+	.period_count_max = PERIOD_COUNT_MAX,
+	.period_count_min = PERIOD_COUNT_MIN,
+	.smooth_output_support = true,
+};
+
+static const struct kona_pwmc_reg iproc_pwmc_reg_data = {
+	.prescale_offset = IPROC_PRESCALE_OFFSET,
+	.period_offset = IPROC_PERIOD_COUNT_OFFSET,
+	.duty_offset = IPROC_DUTY_CYCLE_HIGH_OFFSET,
+	.no_of_channels = IPROC_PWM_CHANNEL_CNT,
+	.out_type_shift = IPROC_PWMOUT_TYPE_SHIFT,
+	.signal_type = IPROC_SIGNAL_PUSH_PULL,
+	.prescale_max = IPROC_PRESCALE_MAX,
+	.prescale_shift = IPROC_PRESCALE_SHIFT,
+	.prescale_ch_ascending = true,
+	.duty_cycle_max = IPROC_DUTY_CYCLE_HIGH_MAX,
+	.duty_cycle_min = IPROC_DUTY_CYCLE_HIGH_MIN,
+	.period_count_max = IPROC_PERIOD_COUNT_MAX,
+	.period_count_min = IPROC_PERIOD_COUNT_MIN,
+	.smooth_output_support = false,
+};
+
 static const struct of_device_id bcm_kona_pwmc_dt[] = {
-	{ .compatible = "brcm,kona-pwm" },
+	{ .compatible = "brcm,kona-pwm", .data = &kona_pwmc_reg_data},
+	{ .compatible = "brcm,iproc-pwm", .data = &iproc_pwmc_reg_data},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_kona_pwmc_dt);
-- 
2.1.0
