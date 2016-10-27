From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v2 06/10] pwm: imx: Provide atomic PWM support for i.MX PWMv2
Date: Thu, 27 Oct 2016 08:29:42 +0200
Message-ID: <1477549785-4972-7-git-send-email-l.majewski@majess.pl>
References: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477549785-4972-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>
List-Id: linux-pwm@vger.kernel.org

This commit provides apply() callback implementation for i.MX's PWMv2.

Suggested-by: Stefan Agner <stefan@agner.ch>
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes for v2:
- None
---
 drivers/pwm/pwm-imx.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index f7c7534..6b7d2f1 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -174,6 +174,81 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip *chip,
 	}
 }
 
+static int imx_pwm_apply_v2(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
+{
+	unsigned long period_cycles, duty_cycles, prescale;
+	struct imx_chip *imx = to_imx_chip(chip);
+	struct pwm_state cstate;
+	unsigned long long c;
+	u32 cr = 0;
+	int ret;
+
+	ret = clk_prepare_enable(imx->clk_ipg);
+	if (ret)
+		return ret;
+
+	pwm_get_state(pwm, &cstate);
+
+	c = clk_get_rate(imx->clk_per);
+	c *= state->period;
+
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	prescale = period_cycles / 0x10000 + 1;
+
+	period_cycles /= prescale;
+	c = (unsigned long long)period_cycles * state->duty_cycle;
+	do_div(c, state->period);
+	duty_cycles = c;
+
+	/*
+	 * according to imx pwm RM, the real period value should be
+	 * PERIOD value in PWMPR plus 2.
+	 */
+	if (period_cycles > 2)
+		period_cycles -= 2;
+	else
+		period_cycles = 0;
+
+	/* Enable the clock if the PWM is being enabled. */
+	if (state->enabled && !cstate.enabled) {
+		ret = clk_prepare_enable(imx->clk_per);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
+	 * the FIFO if the PWM was disabled and is about to be enabled.
+	 */
+	if (cstate.enabled)
+		imx_pwm_wait_fifo_slot(chip, pwm);
+	else if (state->enabled)
+		imx_pwm_sw_reset(chip);
+
+	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
+
+	cr |= MX3_PWMCR_PRESCALER(prescale) |
+	      MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
+	      MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH;
+
+	if (state->enabled)
+		cr |= MX3_PWMCR_EN;
+
+	writel(cr, imx->mmio_base + MX3_PWMCR);
+
+	/* Disable the clock if the PWM is being disabled. */
+	if (!state->enabled && cstate.enabled)
+		clk_disable_unprepare(imx->clk_per);
+
+	clk_disable_unprepare(imx->clk_ipg);
+
+	return 0;
+}
+
 static int imx_pwm_config_v2(struct pwm_chip *chip,
 		struct pwm_device *pwm, int duty_ns, int period_ns)
 {
@@ -297,6 +372,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
 	.enable = imx_pwm_enable,
 	.disable = imx_pwm_disable,
 	.config = imx_pwm_config,
+	.apply = imx_pwm_apply_v2,
 	.owner = THIS_MODULE,
 };
 
-- 
2.1.4
