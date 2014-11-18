From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 5/5] pwm: remove of_pwm_xlate_with_flags() function
Date: Tue, 18 Nov 2014 21:38:43 +0200
Message-ID: <1416339523-7967-5-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63339 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbaKRTjH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 14:39:07 -0500
In-Reply-To: <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>

Default of_pwm_simple_xlate() is good enough to replace
of_pwm_xlate_with_flags() function, since the latter has no more
users, remove it from the PWM framework.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c  |   26 --------------------------
 include/linux/pwm.h |    3 ---
 2 files changed, 29 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4d9fc7f..33cc1da 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -131,32 +131,6 @@ static int pwm_device_request(struct pwm_device *p=
wm, const char *label)
 	return 0;
 }
=20
-struct pwm_device *
-of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_a=
rgs *args)
-{
-	struct pwm_device *pwm;
-
-	if (pc->of_pwm_n_cells < 3)
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
-	if (args->args[2] & PWM_POLARITY_INVERTED)
-		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-	else
-		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
-
-	return pwm;
-}
-EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
-
 static struct pwm_device *
 of_pwm_simple_xlate(struct pwm_chip *pc, const struct of_phandle_args =
*args)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e90628c..66f6e7c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -188,9 +188,6 @@ struct pwm_device *pwm_request_from_chip(struct pwm=
_chip *chip,
 					 unsigned int index,
 					 const char *label);
=20
-struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
-		const struct of_phandle_args *args);
-
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
 struct pwm_device *of_pwm_get(struct device_node *np, const char *con_=
id);
 void pwm_put(struct pwm_device *pwm);
--=20
1.7.10.4

