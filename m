From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] pwm: imx: Support very long period lengths
Date: Mon, 28 Apr 2014 16:55:31 +0800
Message-ID: <1398675331-10980-2-git-send-email-xobs@kosagi.com>
References: <1398675331-10980-1-git-send-email-xobs@kosagi.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398675331-10980-1-git-send-email-xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The IMX PWM block supports using both the system clock and a 32 kHz
clock for driving PWM events.  For very long period lengths, use the
32 kHz clock instead of the high-speed clock.

Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
---
 drivers/pwm/pwm-imx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index cc47733..8410455 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -36,9 +36,11 @@
 #define MX3_PWMCR_DOZEEN                (1 << 24)
 #define MX3_PWMCR_WAITEN                (1 << 23)
 #define MX3_PWMCR_DBGEN			(1 << 22)
+#define MX3_PWMCR_CLKSRC_IPG_32K  (3 << 16)
 #define MX3_PWMCR_CLKSRC_IPG_HIGH (2 << 16)
 #define MX3_PWMCR_CLKSRC_IPG      (1 << 16)
 #define MX3_PWMCR_EN              (1 << 0)
+#define MX3_SLOW_THRESHOLD_NS	100000
 
 struct imx_chip {
 	struct clk	*clk_per;
@@ -107,7 +109,13 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	unsigned long period_cycles, duty_cycles, prescale;
 	u32 cr;
 
-	c = clk_get_rate(imx->clk_per);
+	if (duty_ns > MX3_SLOW_THRESHOLD_NS) {
+		cr = MX3_PWMCR_CLKSRC_IPG_32K;
+		c = 32768;
+	} else {
+		cr = MX3_PWMCR_CLKSRC_IPG_HIGH;
+		c = clk_get_rate(imx->clk_per);
+	}
 	c = c * period_ns;
 	do_div(c, 1000000000);
 	period_cycles = c;
@@ -131,9 +139,9 @@ static int imx_pwm_config_v2(struct pwm_chip *chip,
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
-	cr = MX3_PWMCR_PRESCALER(prescale) |
+	cr |= MX3_PWMCR_PRESCALER(prescale) |
 		MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
-		MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
+		MX3_PWMCR_DBGEN;
 
 	if (test_bit(PWMF_ENABLED, &pwm->flags))
 		cr |= MX3_PWMCR_EN;
-- 
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
