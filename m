From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH v3] pwm: i.MX: Avoid sample FIFO overflow for i.MX PWM version2
Date: Fri, 16 May 2014 13:11:08 +0800
Message-ID: <1400217068-22642-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:45145
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752725AbaEPFIr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 16 May 2014 01:08:47 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thierry.reding@gmail.com, s.hauer@pengutronix.de, shawn.guo@freescale.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

The i.MX PWM version2 is embedded in several i.MX SoCs,
such as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit
sample FIFOs in this IP, each of which determines the duty
period of a PWM waveform in one full cycle.  The IP spec
mentions that we should not write a fourth sample because
the FIFOs will become full and trigger a FIFO write error
(FWE) which will prevent the PWM from starting once it is
enabled.  In order to avoid any sample FIFO overflow issue,
this patch clears all sample FIFOs or waits for a rollover
event to consume a FIFO slot when necessary.  In this way,
only the first FIFO slot will be loaded at most.

Note that the PWM controller will not generate any rollover
event if the duty period is zero.  This makes the logic a
bit complicated to determine if we clear the sample FIFOs
or wait for a rollover event.

The FIFO overflow issue can be reproduced by the following
commands on the i.MX6SL EVK platform, assuming we use PWM2
for the debug LED which is driven by the pin HSIC_STROBE
and the maximal brightness is 255.
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 255 > /sys/class/leds/user/brightness
Here, FWE happens(PWMSR register reads 0x58) and the LED
can not be lighten.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v2->v3:
* Wait for a rollover event before configuration when PWM
  is active with non-zero duty period.  And, update commit
  message for that.
* Fix some typos in commit head and message(fifo -> FIFO,
  pwm -> PWM, etc).
* Cc linux-kernel@vger.kernel.org.

v1->v2:
* To address Lothar Wa=C3=9Fmann's comment, add a timeout mechanism
  instead of endless polling the SWR bit to be cleared by the
  hardware.

 drivers/pwm/pwm-imx.c |   89 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index d797c7b..204f4a9 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,7 +14,9 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -30,6 +32,7 @@
 /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
=20
 #define MX3_PWMCR                 0x00    /* PWM Control Register */
+#define MX3_PWMIR                 0x08    /* PWM Interrupt Register */
 #define MX3_PWMSAR                0x0C    /* PWM Sample Register */
 #define MX3_PWMPR                 0x10    /* PWM Period Register */
 #define MX3_PWMCR_PRESCALER(x)    (((x - 1) & 0xFFF) << 4)
@@ -38,7 +41,12 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
+#define MX3_PWMCR_SWR		  (1 << 3)
 #define MX3_PWMCR_EN              (1 << 0)
+#define MX3_PWMSR_ROV             (1 << 4)
+#define MX3_PWMIR_RIE             (1 << 1)
+
+#define MX3_PWM_SWR_LOOP	  5
=20
 struct imx_chip {
 	struct clk	*clk_per;
@@ -48,6 +56,9 @@ struct imx_chip {
=20
 	struct pwm_chip	chip;
=20
+	unsigned int	irq;
+	struct completion rov_complete;
+
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
@@ -99,12 +110,33 @@ static void imx_pwm_set_enable_v1(struct pwm_chip =
*chip, bool enable)
 	writel(val, imx->mmio_base + MX1_PWMC);
 }
=20
+/* Software reset clears all sample FIFOs. */
+static void imx_pwm_software_reset_v2(struct pwm_chip *chip)
+{
+	struct imx_chip *imx =3D to_imx_chip(chip);
+	struct device *dev =3D chip->dev;
+	int wait_count =3D 0;
+	u32 cr;
+
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr =3D readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+}
+
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx =3D to_imx_chip(chip);
+	struct device *dev =3D chip->dev;
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
+	bool enable =3D test_bit(PWMF_ENABLED, &pwm->flags);
 	u32 cr;
=20
 	c =3D clk_get_rate(imx->clk_per);
@@ -128,6 +160,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip=
,
 	else
 		period_cycles =3D 0;
=20
+	if (!enable || duty_cycles =3D=3D 0)
+		imx_pwm_software_reset_v2(chip);
+	else if (readl(imx->mmio_base + MX3_PWMSAR))
+		/* No rollover irq generated if duty peroid is zero. */
+		if (!wait_for_completion_timeout(&imx->rov_complete, HZ))
+			dev_warn(dev, "timeout when waiting for rollover irq\n");
+
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
=20
@@ -135,27 +174,55 @@ static int imx_pwm_config_v2(struct pwm_chip *chi=
p,
 		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
 		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
=20
-	if (test_bit(PWMF_ENABLED, &pwm->flags))
+	if (enable)
 		cr |=3D MX3_PWMCR_EN;
=20
 	writel(cr, imx->mmio_base + MX3_PWMCR);
=20
+	if (enable && duty_cycles)
+		/* No rollover irq generated if duty peroid is zero. */
+		writel(MX3_PWMIR_RIE, imx->mmio_base + MX3_PWMIR);
+
 	return 0;
 }
=20
 static void imx_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
 {
 	struct imx_chip *imx =3D to_imx_chip(chip);
+	bool enabled;
 	u32 val;
=20
 	val =3D readl(imx->mmio_base + MX3_PWMCR);
=20
+	enabled =3D val & MX3_PWMCR_EN;
+
 	if (enable)
 		val |=3D MX3_PWMCR_EN;
 	else
 		val &=3D ~MX3_PWMCR_EN;
=20
 	writel(val, imx->mmio_base + MX3_PWMCR);
+
+	if (!enable)
+		imx_pwm_software_reset_v2(chip);
+	else if (!enabled && readl(imx->mmio_base + MX3_PWMSAR))
+		/* No rollover irq generated if duty period is zero. */
+		writel(MX3_PWMIR_RIE, imx->mmio_base + MX3_PWMIR);
+}
+
+static irqreturn_t imx_pwm_irq_handler_v2(int irq, void *data)
+{
+	struct imx_chip *imx =3D data;
+	u32 val;
+
+	/* disable rollover interrupt */
+	val =3D readl(imx->mmio_base + MX3_PWMIR);
+	val &=3D ~MX3_PWMIR_RIE;
+	writel(val, imx->mmio_base + MX3_PWMIR);
+
+	complete(&imx->rov_complete);
+
+	return IRQ_HANDLED;
 }
=20
 static int imx_pwm_config(struct pwm_chip *chip,
@@ -209,16 +276,19 @@ struct imx_pwm_data {
 	int (*config)(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns);
 	void (*set_enable)(struct pwm_chip *chip, bool enable);
+	irqreturn_t (*irq_handler)(int irq, void *data);
 };
=20
 static struct imx_pwm_data imx_pwm_data_v1 =3D {
 	.config =3D imx_pwm_config_v1,
 	.set_enable =3D imx_pwm_set_enable_v1,
+	.irq_handler =3D NULL,
 };
=20
 static struct imx_pwm_data imx_pwm_data_v2 =3D {
 	.config =3D imx_pwm_config_v2,
 	.set_enable =3D imx_pwm_set_enable_v2,
+	.irq_handler =3D imx_pwm_irq_handler_v2,
 };
=20
 static const struct of_device_id imx_pwm_dt_ids[] =3D {
@@ -272,6 +342,23 @@ static int imx_pwm_probe(struct platform_device *p=
dev)
 	imx->config =3D data->config;
 	imx->set_enable =3D data->set_enable;
=20
+	init_completion(&imx->rov_complete);
+
+	imx->irq =3D platform_get_irq(pdev, 0);
+	if (imx->irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq\n");
+		return imx->irq;
+	}
+
+	if (data->irq_handler) {
+		ret =3D devm_request_irq(&pdev->dev, imx->irq, data->irq_handler,
+				       0, "imx-pwm", imx);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request irq\n");
+			return ret;
+		}
+	}
+
 	ret =3D pwmchip_add(&imx->chip);
 	if (ret < 0)
 		return ret;
--=20
1.7.9.5

