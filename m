From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/3] pwm: bcm2835: fix email address specifiction
Date: Tue,  1 Dec 2015 22:55:41 +0000
Message-ID: <1449010541-3767-4-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:64533 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287AbbLAW4q (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2015 17:56:46 -0500
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 31a6992..c5dbf16 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -206,6 +206,6 @@ static struct platform_driver bcm2835_pwm_driver = {
 };
 module_platform_driver(bcm2835_pwm_driver);
 
-MODULE_AUTHOR("Bart Tanghe <bart.tanghe@thomasmore.be");
+MODULE_AUTHOR("Bart Tanghe <bart.tanghe@thomasmore.be>");
 MODULE_DESCRIPTION("Broadcom BCM2835 PWM driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
