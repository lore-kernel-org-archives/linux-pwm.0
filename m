From: Liu Ying <Ying.Liu@freescale.com>
Subject: [PATCH] pwm: i.MX: Avoid sample fifo overflow for i.MX pwm version2
Date: Thu, 10 Apr 2014 16:05:11 +0800
Message-ID: <1397117111-19306-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:1684 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965073AbaDJIDR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Apr 2014 04:03:17 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, shawn.guo@freescale.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
Cc: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
---
 drivers/pwm/pwm-imx.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..efdce53 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -38,6 +38,7 @@
 #define MX3_PWMCR_DBGEN			(1 << 22)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
+#define MX3_PWMCR_SWR		  (1 << 3)
 #define MX3_PWMCR_EN              (1 << 0)
 
 struct imx_chip {
@@ -107,6 +108,12 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long period_cycles, duty_cycles, prescale;
 	u32 cr;
 
+	/* do software reset in case fifo overflows */
+	writel(MX3_PWMCR_SWR, imx->mmio_base + MX3_PWMCR);
+	do {
+		cr = readl(imx->mmio_base + MX3_PWMCR);
+	} while (cr & MX3_PWMCR_SWR);
+
 	c = clk_get_rate(imx->clk_per);
 	c = c * period_ns;
 	do_div(c, 1000000000);
-- 
1.7.9.5


