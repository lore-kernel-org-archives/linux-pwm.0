From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v2 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Mon, 20 Jul 2015 10:23:49 +0200
Message-ID: <1437380631-7149-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:55908 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbGTIYL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 04:24:11 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Clemens Gruber <clemens.gruber@pqgruber.com>

Hi,

the first patch from this series contains bugfixes and the second patch
adds support for changing the PWM output frequency of the PCA9685.

Cc: Thierry Reding <thierry.reding@gmail.com>

Changes from v1:
- Only put chip into sleep mode if the bounds checking succeeds

Clemens Gruber (2):
  pwm-pca9685: Fix several driver bugs
  pwm-pca9685: Support changing the output frequency

 drivers/pwm/pwm-pca9685.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

-- 
2.4.6
