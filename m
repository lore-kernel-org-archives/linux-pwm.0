From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH 6/6] pwm: imx: Introduce "polarity_supported" flag to PWMv2 driver
Date: Sun, 23 Oct 2016 23:45:46 +0200
Message-ID: <1477259146-19167-7-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:42129 "EHLO
        14.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754750AbcJWV45 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Oct 2016 17:56:57 -0400
Received: from player734.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 81A3B3E6E4
        for <linux-pwm@vger.kernel.org>; Sun, 23 Oct 2016 23:47:22 +0200 (CEST)
In-Reply-To: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Lothar Wassmann <LW@karo-electronics.de>, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, kernel@pengutronix.de, Lukasz Majewski <l.majewski@majess.pl>

The need for set_polarity() function has been removed by implementing
PWM atomic support (apply() callback).

To indicate that the PWMv2 supports polarity inversion, new flag -
"polarity_supported" has been introduced.

Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
 drivers/pwm/pwm-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 02d3dfd..be3034d 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -258,6 +258,7 @@ static struct pwm_ops imx_pwm_ops_v2 = {
 };
 
 struct imx_pwm_data {
+	bool polarity_supported;
 	struct pwm_ops *pwm_ops;
 };
 
@@ -266,6 +267,7 @@ static struct imx_pwm_data imx_pwm_data_v1 = {
 };
 
 static struct imx_pwm_data imx_pwm_data_v2 = {
+	.polarity_supported = true,
 	.pwm_ops = &imx_pwm_ops_v2,
 };
 
@@ -313,7 +315,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 	imx->chip.can_sleep = true;
-	if (data->pwm_ops->set_polarity) {
+	if (data->polarity_supported) {
 		dev_dbg(&pdev->dev, "PWM supports output inversion\n");
 		imx->chip.of_xlate = of_pwm_xlate_with_flags;
 		imx->chip.of_pwm_n_cells = 3;
-- 
2.1.4
