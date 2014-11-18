From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH 1/5] pwm: process pwm polarity argument in of_pwm_simple_xlate()
Date: Tue, 18 Nov 2014 21:38:39 +0200
Message-ID: <1416339523-7967-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63311 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaKRTjE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 14:39:04 -0500
In-Reply-To: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

The third optional argument of pwms is well defined as polarity and it
is already used in a number of pwm drivers, so, to minimize changes in
the remaining drivers which are to be updated accordingly set polarity
in default of_xlate() function.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 966497d..681d154 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -174,6 +174,13 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const str=
uct of_phandle_args *args)
=20
 	pwm_set_period(pwm, args->args[1]);
=20
+	if (pc->of_pwm_n_cells > 2) {
+		if (args->args[2] & PWM_POLARITY_INVERTED)
+			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
+		else
+			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
+	}
+
 	return pwm;
 }
=20
--=20
1.7.10.4

