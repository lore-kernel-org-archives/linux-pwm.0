From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] pwm: Fill pwm->args before calling pwm_request_from_chip()
Date: Tue, 17 May 2016 12:35:32 +0200
Message-ID: <1463481333-23438-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58155 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754427AbcEQKfi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2016 06:35:38 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>

Commit e39c0df1be5a ("pwm: Introduce the pwm_args concept"), moved the
period and polarity initialization steps into pwm_request_device() (cal=
led
by pwm_request_from_chip()) based on the pwm->args information.
Make sure we fill pwm->args fields before calling pwm_request_from_chip=
().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Mika Penttil=C3=A4 <mika.penttila@nextfour.com>
=46ixes: e39c0df1be5a ("pwm: Introduce the pwm_args concept")
---
Mika,

Can you test after applying this patch and let me know if it fixes your
bug.

Thanks,

Boris

 drivers/pwm/core.c    | 12 ++++++------
 drivers/pwm/pwm-pxa.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 427142d..3d2eeaa 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -143,10 +143,6 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const=
 struct of_phandle_args *args)
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
-	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
-	if (IS_ERR(pwm))
-		return pwm;
-
 	pwm->args.period =3D args->args[1];
=20
 	if (args->args[2] & PWM_POLARITY_INVERTED)
@@ -154,6 +150,10 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const=
 struct of_phandle_args *args)
 	else
 		pwm->args.polarity =3D PWM_POLARITY_NORMAL;
=20
+	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
 	return pwm;
 }
 EXPORT_SYMBOL_GPL(of_pwm_xlate_with_flags);
@@ -169,12 +169,12 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
 	if (args->args[0] >=3D pc->npwm)
 		return ERR_PTR(-EINVAL);
=20
+	pwm->args.period =3D args->args[1];
+
 	pwm =3D pwm_request_from_chip(pc, args->args[0], NULL);
 	if (IS_ERR(pwm))
 		return pwm;
=20
-	pwm->args.period =3D args->args[1];
-
 	return pwm;
 }
=20
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 58b709f..c33bd42 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -156,12 +156,12 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struc=
t of_phandle_args *args)
 {
 	struct pwm_device *pwm;
=20
+	pwm->args.period =3D args->args[0];
+
 	pwm =3D pwm_request_from_chip(pc, 0, NULL);
 	if (IS_ERR(pwm))
 		return pwm;
=20
-	pwm->args.period =3D args->args[0];
-
 	return pwm;
 }
=20
--=20
2.7.4
