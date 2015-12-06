From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 0/6] pwm: lpc32xx: fixes in the LPC32xx PWM driver
Date: Sun,  6 Dec 2015 13:29:11 +0200
Message-ID: <1449401357-22458-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:51783 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbbLFL3g (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 6 Dec 2015 06:29:36 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Roland Stigge <stigge@antcom.de>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org

The changeset fixes a number of issues within current implementation
of LPC32xx PWM controller driver, namely
- the SoC has two independent PWM controllers with one channel each,
- runtime warnings from common clock framework,
- overflow in duty cycle calculation may result in disabled PWM,
- unsupported period values are not accepted.

Correction of PWM channels requires a correspondent change in
arch/arm/boot/dts/lpc32xx.dtsi, it has been already sent for review.

Changes from v1 to v2:
- corrected style of examples in documentation,
- improved commit messages

Version v1 can be found here:
  http://comments.gmane.org/gmane.linux.pwm/2828
  http://www.spinics.net/lists/devicetree/msg105398.html

Vladimir Zapolskiy (6):
  dt: lpc32xx: pwm: correct LPC32xx PWM device node example
  dt: lpc32xx: pwm: update documentation of LPC32xx PWM device
  pwm: lpc32xx: correct number of PWM channels from 2 to 1
  pwm: lpc32xx: fix warnings from common clock framework
  pwm: lpc32xx: fix and simplify duty cycle and period calculations
  pwm: lpc32xx: return ERANGE, if requested period is not supported

 .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  9 +++-
 drivers/pwm/pwm-lpc32xx.c                          | 59 ++++++++--------------
 2 files changed, 29 insertions(+), 39 deletions(-)

-- 
2.1.4
