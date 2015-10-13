From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 0/4] pwm: lpc32xx: fixes in the LPC32xx PWM driver
Date: Tue, 13 Oct 2015 03:20:49 +0300
Message-ID: <1444695653-23491-1-git-send-email-vz@mleia.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:39537 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbJMAVB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 Oct 2015 20:21:01 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Cc: linux-pwm@vger.kernel.org

The changeset fixes a number of issues within current implementation
of LPC32xx PWM controller driver, namely
- the SoC has two independent PWM controllers with one channel each,
- runtime warnings from common clock framework,
- overflow in duty cycle calculation may result in disabled PWM,
- unsupported period values are silently accepted.

Vladimir Zapolskiy (4):
  pwm: lpc32xx: correct number of PWM channels from 2 to 1
  pwm: lpc32xx: fix warnings from common clock framework
  pwm: lpc32xx: fix and simplify duty cycle and period calculations
  pwm: lpc32xx: return ERANGE, if requested period is not supported

 drivers/pwm/pwm-lpc32xx.c | 59 ++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

-- 
2.1.4
