From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/3] pwm: bcm2835: prevent division by zero
Date: Tue,  1 Dec 2015 22:55:40 +0000
Message-ID: <1449010541-3767-3-git-send-email-stefan.wahren@i2se.com>
References: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:65314 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757285AbbLAW4n (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Dec 2015 17:56:43 -0500
In-Reply-To: <1449010541-3767-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Remi Pommarel <repk@triplefau.lt>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Stefan Wahren <stefan.wahren@i2se.com>

It's possible that the pwm clock become an orphan. So better
check the result of clk_get_rate in order to prevent a division
by zero.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/pwm/pwm-bcm2835.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 174cca9..31a6992 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -65,7 +65,15 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
 {
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
-	unsigned long scaler = NSEC_PER_SEC / clk_get_rate(pc->clk);
+	unsigned long rate = clk_get_rate(pc->clk);
+	unsigned long scaler;
+
+	if (!rate) {
+		dev_err(pc->dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	scaler = NSEC_PER_SEC / rate;
 
 	if (period_ns <= MIN_PERIOD) {
 		dev_err(pc->dev, "period %d not supported, minimum %d\n",
-- 
1.7.9.5
