From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 09/11] pwm: core: make the PWM_POLARITY flag in DTB optional
Date: Mon, 26 Dec 2016 23:55:59 +0100
Message-ID: <1482792961-12702-10-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:33545 "EHLO
        2.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbcLZW6V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Dec 2016 17:58:21 -0500
Received: from player716.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id B0D647483
        for <linux-pwm@vger.kernel.org>; Mon, 26 Dec 2016 23:58:19 +0100 (CET)
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lothar Wassmann <LW@KARO-electronics.de>, Lukasz Majewski <l.majewski@majess.pl>

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
