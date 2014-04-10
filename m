From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH v2] pwm: i.MX: Avoid sample fifo overflow for i.MX pwm version2
Date: Thu, 10 Apr 2014 17:23:49 +0800
Message-ID: <1397121829-19331-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:16902
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933057AbaDJJVh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Thu, 10 Apr 2014 05:21:37 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, shawn.guo@freescale.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

The i.MX pwm version2 is embedded in several i.MX SoCs, such
as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit sample
fifos in this IP, each of which determines the duty period
of a PWM waveform in one full cycle.  The IP spec mentions
that we should not write a fourth sample because the fifo
will become full and trigger a fifo write error(FWE) which
will prevent the PWM from starting once it is enabled.  In
order to avoid any sample fifo overflow issue, this patch
does software reset to clear all the sample fifos in the
very beginning of the pwm configuration function.

The fifo overflow issue can be reproduced by the following
commands on the i.MX6SL evk platform, assuming we use pwm2
for the debug LED which is driven by the pin HSIC_STROBE
and the maximal brightness is 255.
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 0   > /sys/class/leds/user/brightness
echo 255 > /sys/class/leds/user/brightness
Here, FWE happens(PWMSR register reads 0x58) and the LED
can not be lighten.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
v1->v2:
* To address Lothar Wa=C3=9Fmann's comment, add a timeout mechanism
  instead of endless polling the SWR bit to be cleared by the
  hardware.

 drivers/pwm/pwm-imx.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..8929b0d 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pwm.h>
 #include <linux/of.h>
@@ -38,8 +39,11 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
+#define MX3_PWMCR_SWR		  (1 << 3)
 #define MX3_PWMCR_EN              (1 << 0)
=20
+#define MX3_PWM_SWR_LOOP	  5
+
 struct imx_chip {
 	struct clk	*clk_per;
 	struct clk	*clk_ipg;
@@ -103,10 +107,23 @@ static int imx_pwm_config_v2(struct pwm_chip *chi=
p,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
 	struct imx_chip *imx =3D to_imx_chip(chip);
+	struct device *dev =3D chip->dev;
 	unsigned long long c;
 	unsigned long period_cycles, duty_cycles, prescale;
+	int wait_count =3D 0;
 	u32 cr;
=20
+	/* do software reset in case fifo overflows */
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		usleep_range(200, 1000);
+		cr =3D readl(imx->mmio_base + MX3_PWMCR);
+	} while ((cr & MX3_PWMCR_SWR) &&
+		 (wait_count++ < MX3_PWM_SWR_LOOP));
+
+	if (cr & MX3_PWMCR_SWR)
+		dev_warn(dev, "software reset timeout\n");
+
 	c =3D clk_get_rate(imx->clk_per);
 	c =3D c * period_ns;
 	do_div(c, 1000000000);
--=20
1.7.9.5


