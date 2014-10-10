From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: =?UTF-8?q?=5BPATCH=202/3=5D=20pwm=3A=20push=20up=20dynamic=20printk=20level=20on=20errors=20in=20of=5Fpwm=5Fget=28=29?=
Date: Fri, 10 Oct 2014 18:50:06 +0300
Message-ID: <1412956207-24008-3-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62694 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaJJPvH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Oct 2014 11:51:07 -0400
In-Reply-To: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

The changed three user messages on fault are printed under pr_debug(),
however all of them are unrecoverable and result in failed pwm device
registration, report this to a user.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 681d154..ccf1be7 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -532,19 +532,19 @@ struct pwm_device *of_pwm_get(struct device_node =
*np, const char *con_id)
 	err =3D of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
 					 &args);
 	if (err) {
-		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
+		pr_warn("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
 	}
=20
 	pc =3D of_node_to_pwmchip(args.np);
 	if (IS_ERR(pc)) {
-		pr_debug("%s(): PWM chip not found\n", __func__);
+		pr_warn("%s(): PWM chip not found\n", __func__);
 		pwm =3D ERR_CAST(pc);
 		goto put;
 	}
=20
 	if (args.args_count !=3D pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
+		pr_warn("%s: wrong #pwm-cells for %s\n", np->full_name,
 			 args.np->full_name);
 		pwm =3D ERR_PTR(-EINVAL);
 		goto put;
--=20
1.7.10.4

