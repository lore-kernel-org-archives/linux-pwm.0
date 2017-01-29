From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 09/11] pwm: core: make the PWM_POLARITY flag in DTB optional
Date: Sun, 29 Jan 2017 22:54:13 +0100
Message-ID: <1485726855-16236-10-git-send-email-lukma@denx.de>
References: <1485726855-16236-1-git-send-email-lukma@denx.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41916 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdA2VzN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Jan 2017 16:55:13 -0500
In-Reply-To: <1485726855-16236-1-git-send-email-lukma@denx.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@KARO-electronics.de>, Lukasz Majewski <l.majewski@majess.pl>

From: Lothar Wassmann <LW@KARO-electronics.de>

Change the pwm chip driver registration, so that a chip driver that
supports polarity inversion can still be used with DTBs that don't
provide the 'PWM_POLARITY' flag.

This is done to provide polarity inversion support for the pwm-imx
driver without having to modify all existing DTS files.

Signed-off-by: Lothar Wassmann <LW@KARO-electronics.de>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
Changes for v5:
- None

Changes for v4:
- None

Changes for v3:
- None

Changes for v2:
- None
---
 drivers/pwm/core.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ec7179f..d80e5c5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -137,9 +137,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* check, whether the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
 		return ERR_PTR(-EINVAL);
 
+	/* flags in the third cell are optional */
+	if (args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -148,11 +153,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args[2] & PWM_POLARITY_INVERTED)
+	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
-	else
-		pwm->args.polarity = PWM_POLARITY_NORMAL;
 
 	return pwm;
 }
@@ -163,9 +167,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
 
+	/* sanity check driver support */
 	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
 
+	/* all cells are required */
+	if (args->args_count != pc->of_pwm_n_cells)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
 
@@ -674,13 +683,6 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	if (args.args_count != pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm = ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm = pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
-- 
2.1.4
