From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] pwm: imx: use of_alias_get_id() to get pwm base from DT alias
Date: Wed, 11 Nov 2015 14:24:01 +0100
Message-ID: <1447248241-18352-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49262 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbKKNYE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2015 08:24:04 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

The DT probe uses a dynamically allocated base by pwm core. The actual pwm
device number depends on the probe order of the devices in the DT. This not
intuitive and sometimes hard for users to map the Linux pwm number to the
actual hardware pin. (Especially on the mx25, where pwm4 is probed first.)

Use alias to identify the id of pwm port and pass it as base to the pwm core.
If an alias is not defined in device tree, a base number dynamically allocated
by pwm core will be used.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/pwm/pwm-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 66d6f0c5c421..9a2a46337d82 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -276,11 +276,15 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	const struct imx_pwm_data *data;
 	struct imx_chip *imx;
 	struct resource *r;
-	int ret = 0;
+	int base, ret = 0;
 
 	if (!of_id)
 		return -ENODEV;
 
+	base = of_alias_get_id(pdev->dev.of_node, "pwm");
+	if (base < 0)
+		base = -1;
+
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
@@ -301,7 +305,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 
 	imx->chip.ops = &imx_pwm_ops;
 	imx->chip.dev = &pdev->dev;
-	imx->chip.base = -1;
+	imx->chip.base = base;
 	imx->chip.npwm = 1;
 	imx->chip.can_sleep = true;
 
-- 
2.6.1
