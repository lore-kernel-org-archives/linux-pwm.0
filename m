From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv6 2/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Fri, 10 Oct 2014 16:22:28 +0200
Message-ID: <1412950949-7505-3-git-send-email-LW@KARO-electronics.de>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:63215 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaJJOWq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Oct 2014 10:22:46 -0400
In-Reply-To: <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

Change the pwm chip driver registration, so that a chip driver that
supports polarity inversion can still be used with DTBs that don't
provide the 'PWM_POLARITY' flag.

This is done to provide polarity inversion support for the pwm-imx
driver without having to modify all existing DTS files.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/pwm/core.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 130bbea..0ff1bb0 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -136,9 +136,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const=
 struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
+	/* check, whether the driver supports a third cell for flags */
 	if (pc->of_pwm_n_cells < 3)
 		return ERR_PTR(-EINVAL);
=20
+	/* flags in the third cell are optional */
+	if (args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
@@ -148,10 +153,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, cons=
t struct of_phandle_args *args)
=20
 	pwm_set_period(pwm, args->args[1]);
=20
-	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	if (args->args_count > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		else
+			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	}
=20
 	return pwm;
 }
@@ -162,9 +169,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const str=
uct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
+	/* sanity check driver support */
 	if (pc->of_pwm_n_cells < 2)
 		return ERR_PTR(-EINVAL);
=20
+	/* all cells are required */
+	if (args->args_count !=3D pc->of_pwm_n_cells)
+		return ERR_PTR(-EINVAL);
+
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
@@ -536,13 +548,6 @@ struct pwm_device *of_pwm_get(struct device_node *=
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

