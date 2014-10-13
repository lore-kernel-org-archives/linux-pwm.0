From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCHv2 3/3] pwm: set the actual number of pwms arguments defined in board dts
Date: Mon, 13 Oct 2014 17:21:39 +0300
Message-ID: <1413210099-7862-5-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:58151 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaJMOWY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Oct 2014 10:22:24 -0400
In-Reply-To: <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

=46or backward compatibility board device tree has to define only a
minimal amount of mandatory pwms arguments, which is specified by a
driver. Additional arguments shall be considered as optional, update
pc->of_pwm_n_cells according to the actual data taken from device tree
file.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
Changes from v1 to v2:
- rebased on top of modified patch v2 2/3

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

