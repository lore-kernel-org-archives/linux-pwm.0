From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] pwm: core: Use devm_kzalloc instead of kzalloc
Date: Tue, 7 Jan 2014 14:05:00 +0800
Message-ID: <1389074700-1825-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:7164 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751929AbaAGHAy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2014 02:00:54 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

Use devm_kzalloc instead of kzalloc to free automatically and make
the cleanup paths simpler and the code slightly shorter.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 2ca9504..74c9f9a 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -80,7 +80,6 @@ static void free_pwms(struct pwm_chip *chip)
 
 	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
 
-	kfree(chip->pwms);
 	chip->pwms = NULL;
 }
 
@@ -245,7 +244,9 @@ int pwmchip_add(struct pwm_chip *chip)
 	if (ret < 0)
 		goto out;
 
-	chip->pwms = kzalloc(chip->npwm * sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = devm_kzalloc(chip->dev,
+				  chip->npwm * sizeof(*pwm),
+				  GFP_KERNEL);
 	if (!chip->pwms) {
 		ret = -ENOMEM;
 		goto out;
-- 
1.8.4


