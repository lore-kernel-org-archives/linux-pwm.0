From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] pwm-backlight:
Date: Fri,  6 Jun 2014 13:02:09 +0200
Message-ID: <1402052529-22761-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:57649 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaFFLCn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Jun 2014 07:02:43 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>

commit 257462dbf3ed pwm-backlight: switch to gpiod interface
introduced a regression leading to acquiring a bogus GPIO-0 when
configured from DT without an 'enable-gpios' property.
The driver will happily accept the 0 initialized 'enable_gpio' member
of the struct platform_pwm_backlight_data as valid gpio number, and
request this GPIO as enable pin. In case of multiple driver instances,
the second will fail to register with the error message:
pwm-backlight backlight1.23: failed to request GPIO#0: -16

=46ix this by setting enable_gpio in the pdata struct to -EINVAL.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/video/backlight/pwm_bl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight=
/pwm_bl.c
index 38ca88b..3d265c4 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *de=
v,
 		data->dft_brightness =3D value;
 		data->max_brightness--;
 	}
-
+	data->enable_gpio =3D -EINVAL;
 	return 0;
 }
=20
--=20
1.7.10.4

