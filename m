From: slemieux.tyco@gmail.com
Subject: [RESEND PATCH 2/3] pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
Date: Thu, 16 Feb 2017 15:27:48 -0500
Message-ID: <20170216202749.20653-3-slemieux.tyco@gmail.com>
References: <20170216202749.20653-1-slemieux.tyco@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33212 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933101AbdBPU2C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2017 15:28:02 -0500
In-Reply-To: <20170216202749.20653-1-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, vz@mleia.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Vladimir Zapolskiy <vz@mleia.com>

NXP LPC32xx SoCs have two simple independent PWM controllers with a single
output each, in this case there is no need to specify PWM channel argument
on client side, one cell for setting PWM output frequency is sufficient.

The change adds private of_xlate() handling of a single cell value given
with a PWM phandle on client side, the handling is taken from the PXA PWM
driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
---
 drivers/pwm/pwm-lpc32xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index a9b3cff96aac..ce8418101e85 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -92,6 +92,20 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(lpc32xx->clk);
 }
 
+static struct pwm_device *lpc32xx_pwm_of_xlate(struct pwm_chip *pc,
+				       const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	pwm = pwm_request_from_chip(pc, 0, NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	pwm->args.period = args->args[0];
+
+	return pwm;
+}
+
 static const struct pwm_ops lpc32xx_pwm_ops = {
 	.config = lpc32xx_pwm_config,
 	.enable = lpc32xx_pwm_enable,
@@ -123,6 +137,8 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
 	lpc32xx->chip.npwm = 1;
 	lpc32xx->chip.base = -1;
+	lpc32xx->chip.of_xlate = lpc32xx_pwm_of_xlate;
+	lpc32xx->chip.of_pwm_n_cells = 1;
 
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
-- 
2.11.0
