From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: [PATCHv2 0/3] pwm: support backward compatibility of DTB extending PWM args
Date: Mon, 13 Oct 2014 17:21:36 +0300
Message-ID: <1413210099-7862-2-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:58119 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbaJMOWV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Oct 2014 10:22:21 -0400
In-Reply-To: <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

Please review this alternative in-house version of supporting backward
compatibility of DTB files, if pwms arguments of exisitng PWM drivers
are to be extended with polarity field.

Unfortunately I've firstly created the change and only after that
found that Lothar Wa=C3=9Fmann is working on his version, so I won't in=
sist
on formal preference, but still I like to share my variant since it
technically different from Lothar's one.

One visual benefit of my verison is that if this version is accepted,
then of_pwm_xlate_with_flags() can be removed from all touched PWM
drivers and pwm/core.c as a redundant interface, chip.of_pwm_n_cells
should not be updated also, and generally is looks to be a more simple
change.

The particular changes in iMX PWM driver and other PWM drivers are out
of this change scope.

Changes from v1 to v2:
- corrected the proper kernel log level, thanks to Lothar Wa=C3=9Fmann.

Vladimir Zapolskiy (3):
  pwm: process pwm polarity argument in of_pwm_simple_xlate()
  pwm: push up dynamic printk level on errors in of_pwm_get()
  pwm: set the actual number of pwms arguments defined in board dts

 drivers/pwm/core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--=20
1.7.10.4

