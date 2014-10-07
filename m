From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv5 1/3] pwm: print error messages with pr_err() instead of pr_debug()
Date: Tue,  7 Oct 2014 15:55:32 +0200
Message-ID: <1412690134-13712-2-git-send-email-LW@KARO-electronics.de>
References: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:49963 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaJGNzr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 09:55:47 -0400
In-Reply-To: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Tony Prisk <linux@prisktech.co.nz>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

Make the messages that are printed in case of fatal errors actually
visible to the user without having to recompile the driver with
debugging enabled.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pwm/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d..130bbea 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -525,13 +525,13 @@ struct pwm_device *of_pwm_get(struct device_node =
*np, const char *con_id)
 	err =3D of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
 					 &args);
 	if (err) {
-		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
+		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
 	}
=20
 	pc =3D of_node_to_pwmchip(args.np);
 	if (IS_ERR(pc)) {
-		pr_debug("%s(): PWM chip not found\n", __func__);
+		pr_err("%s(): PWM chip not found\n", __func__);
 		pwm =3D ERR_CAST(pc);
 		goto put;
 	}
--=20
1.7.10.4

