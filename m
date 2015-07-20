From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v3 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Mon, 20 Jul 2015 10:36:07 +0200
Message-ID: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:57445 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932171AbbGTIgT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 04:36:19 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi,

the first patch from this series contains bugfixes and the second patch
adds support for changing the PWM output frequency of the PCA9685.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Changes from v1:
- Only put chip into sleep mode if the bounds checking succeeds

Changes from v2:
- Fix checkpatch style warnings introduced in v2

Clemens Gruber (2):
  pwm-pca9685: Fix several driver bugs
  pwm-pca9685: Support changing the output frequency

 drivers/pwm/pwm-pca9685.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

-- 
2.4.6
