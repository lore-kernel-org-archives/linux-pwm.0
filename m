From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v4 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Thu, 23 Jul 2015 17:19:00 +0200
Message-ID: <1437664742-23121-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:34651 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbGWPUd (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2015 11:20:33 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Clemens Gruber <clemens.gruber@pqgruber.com>, Thierry Reding <thierry.reding@gmail.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

Hi,

the first patch from this series contains bugfixes and the second patch
adds support for changing the PWM output frequency of the PCA9685.

Regards,
Clemens

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Changes in v2:
- Only put chip into sleep mode if the bounds checking succeeds

Changes in v3:
- Fix checkpatch style warnings introduced in v2

Changes in v4:
- Set RESTART bit. Now the duty cycle to period ratio stays the same
  after only changing the period.
- Added a comment at the start of the file pointing out that the chip
  has only one prescaler and changing the period affects all outputs.

Clemens Gruber (2):
  pwm-pca9685: Fix several driver bugs
  pwm-pca9685: Support changing the output frequency

 drivers/pwm/pwm-pca9685.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

-- 
2.4.6
