From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 3/5] pwm: set the actual number of pwms arguments defined in board dts
Date: Tue, 18 Nov 2014 21:38:41 +0200
Message-ID: <1416339523-7967-3-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63324 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbaKRTjF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 14:39:05 -0500
In-Reply-To: <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

=46or backward compatibility board device tree may define amount of onl=
y
mandatory pwm properties, which is compared to a pwm driver specific
value, by default it is 2 and may be overwritten by a driver.

Any additional arguments shall be considered as optional and they are
taken into account, only if #pwm-cells is increased accordingly.

As a positive side effect specific pwm-specifier array may have
variable size of #pwm-cells (but not less than amount of mandatory
arguments), which allows to omit optional arguments. The parameters
array of a specific PWM is updated according to the actual data taken
from device tree file.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f6231c6..4d9fc7f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -543,12 +543,13 @@ struct pwm_device *of_pwm_get(struct device_node =
*np, const char *con_id)
 		goto put;
 	}
=20
-	if (args.args_count !=3D pc->of_pwm_n_cells) {
+	if (args.args_count < pc->of_pwm_n_cells) {
 		pr_err("%s: wrong #pwm-cells for %s\n", np->full_name,
 			 args.np->full_name);
 		pwm =3D ERR_PTR(-EINVAL);
 		goto put;
 	}
+	pc->of_pwm_n_cells =3D args.args_count;
=20
 	pwm =3D pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
--=20
1.7.10.4

