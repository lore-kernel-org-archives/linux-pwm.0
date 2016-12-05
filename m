From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/3] pwm: lpc32xx: switch driver to one phandle argument for PWM consumers
Date: Mon,  5 Dec 2016 03:43:07 +0200
Message-ID: <20161205014308.1741-1-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:42361 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbcLEBnM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 4 Dec 2016 20:43:12 -0500
In-Reply-To: <20161205014237.1689-1-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

NXP LPC32xx SoCs have two simple independent PWM controllers with a single
output each, in this case there is no need to specify PWM channel argument
on client side, one cell for setting PWM output frequency is sufficient.

The change adds private of_xlate() handling of a single cell value given
with a PWM phandle on client side, the handling is taken from the PXA PWM
driver.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/pwm/pwm-lpc32xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index a9b3cff..ce84181 100644
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
2.10.2
