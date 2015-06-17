From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 0/2] pwm-pca9685: Bugfixes and prescaler support
Date: Thu, 18 Jun 2015 01:15:45 +0200
Message-ID: <1434582947-11211-1-git-send-email-clemens.gruber@pqgruber.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([178.189.19.235]:29329 "EHLO
	mail.pqgruber.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbbFQXXF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Jun 2015 19:23:05 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, Clemens Gruber <clemens.gruber@pqgruber.com>

Hi,

the first patch from this series contains bugfixes and the second patch
adds support for changing the PWM output frequency of the PCA9685.

Clemens Gruber (2):
  pwm-pca9685: Fix several driver bugs
  pwm-pca9685: Support changing the output frequency

 drivers/pwm/pwm-pca9685.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

-- 
2.4.3
