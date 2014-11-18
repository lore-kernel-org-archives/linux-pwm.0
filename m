From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCH v3 0/5] pwm: support backward compatibility of DTB extending PWM args
Date: Tue, 18 Nov 2014 21:37:18 +0200
Message-ID: <1416339438-7867-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63178 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbaKRThs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 14:37:48 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>, Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Please review this alternative in-house version of supporting backward
compatibility of DTB files (new kernel/PWM driver and old DTS), overcom=
ing
a problem that pwms arguments of existing PWM drivers are to be extende=
d
with polarity field.

Unfortunately I've firstly created the change and only after that
found that Lothar Wa=C3=9Fmann is working on his version, so I won't in=
sist
on formal preference, but still I like to share my variant since it
technically different from Lothar's one.

Changes from v2 to v3:
- improved commit messages
- added two more patches removing of_pwm_xlate_with_flags()

Changes from v1 to v2:
- corrected the proper kernel log level, thanks to Lothar Wa=C3=9Fmann.

Vladimir Zapolskiy (5):
  pwm: process pwm polarity argument in of_pwm_simple_xlate()
  pwm: push up dynamic printk level on errors in of_pwm_get()
  pwm: set the actual number of pwms arguments defined in board dts
  pwm: do not set of_pwm_xlate_with_flags() as a callback
  pwm: remove of_pwm_xlate_with_flags() function

 drivers/pwm/core.c            |   42 ++++++++++++---------------------=
--------
 drivers/pwm/pwm-atmel-hlcdc.c |    2 --
 drivers/pwm/pwm-atmel-tcb.c   |    2 --
 drivers/pwm/pwm-atmel.c       |    6 ------
 drivers/pwm/pwm-bcm-kona.c    |    2 --
 drivers/pwm/pwm-fsl-ftm.c     |    2 --
 drivers/pwm/pwm-renesas-tpu.c |    2 --
 drivers/pwm/pwm-rockchip.c    |    5 -----
 drivers/pwm/pwm-samsung.c     |    3 ---
 drivers/pwm/pwm-tiecap.c      |    2 --
 drivers/pwm/pwm-tiehrpwm.c    |    2 --
 drivers/pwm/pwm-vt8500.c      |    2 --
 include/linux/pwm.h           |    3 ---
 13 files changed, 12 insertions(+), 63 deletions(-)

--=20
1.7.10.4

