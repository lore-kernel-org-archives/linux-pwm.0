From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/3] pwm: bcm2835: improve clock handling
Date: Tue,  1 Dec 2015 22:55:38 +0000
Message-ID: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54564 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbbLAW4o (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2015 17:56:44 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

With the upcoming PWM clock support the pwm-bcm2835 should take
more care about the clock handling. But this patch series doesn't
depend on these clock driver changes.

Stefan Wahren (3):
  pwm: bcm2835: calculate scaler in pwm_config
  pwm: bcm2835: prevent division by zero
  pwm: bcm2835: fix email address specifiction

 drivers/pwm/pwm-bcm2835.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
1.7.9.5
