From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Fri, 28 Mar 2014 09:48:58 +0100
Message-ID: <1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:54720 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbaC1ItL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Mar 2014 04:49:11 -0400
In-Reply-To: <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>

Change the pwm chip driver registration, so that a chip driver that
supports polarity inversion can still be used with DTBs that don't
provide the 'PWM_POLARITY' flag.

This is done to provide polarity inversion support for the pwm-imx
driver without having to modify all existing DTS files.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/core.c |   46 ++++++++++++++++----------------------------=
--
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a804713..dc15543 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -131,12 +131,12 @@ static int pwm_device_request(struct pwm_device *=
pwm, const char *label)
 	return 0;
 }
=20
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_a=
rgs *args)
+struct pwm_device *of_pwm_xlate(struct pwm_chip *pc,
+				const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
-	if (pc->of_pwm_n_cells < 3)
+	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
=20
 	if (args->args[0] >=3D pc->npwm)
@@ -148,6 +148,9 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const =
struct of_phandle_args *args)
=20
 	pwm_set_period(pwm, args->args[1]);
=20
+	if (pc->of_pwm_n_cells < 3)
+		return pwm;
+
 	if (args->args[2] & PWM_POLARITY_INVERTED)
 		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
 	else
@@ -155,27 +158,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, cons=
t struct of_phandle_args *args)
=20
 	return pwm;
 }
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
=20
-static struct pwm_device *
-of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args =
*args)
+struct pwm_device *
+of_pwm_xlate_with_flags(struct pwm_chip *pc,
+			const struct of_phandle_args *args)
 {
-	struct pwm_device *pwm;
-
-	if (pc->of_pwm_n_cells < 2)
-		return ERR_PTR(-EINVAL);
-
-	if (args->args[0] >=3D pc->npwm)
-		return ERR_PTR(-EINVAL);
-
-	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
-	pwm_set_period(pwm, args->args[1]);
-
-	return pwm;
+	return of_pwm_xlate(pc, args);
 }
+EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
=20
 static void of_pwmchip_add(struct pwm_chip *chip)
 {
@@ -183,8 +173,11 @@ static void of_pwmchip_add(struct pwm_chip *chip)
 		return;
=20
 	if (!chip->of_xlate) {
-		chip->of_xlate =3D of_pwm_simple_xlate;
-		chip->of_pwm_n_cells =3D 2;
+		chip->of_xlate =3D of_pwm_xlate;
+		if (chip->ops->set_polarity)
+			chip->of_pwm_n_cells =3D 3;
+		else
+			chip->of_pwm_n_cells =3D 2;
 	}
=20
 	of_node_get(chip->dev->of_node);
@@ -536,13 +529,6 @@ struct pwm_device *of_pwm_get(struct device_node *=
np, const char *con_id)
 		goto put;
 	}
=20
-	if (args.args_count !=3D pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
-			 args.np->full_name);
-		pwm =3D ERR_PTR(-EINVAL);
-		goto put;
-	}
-
 	pwm =3D pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
 		goto put;
--=20
1.7.10.4

