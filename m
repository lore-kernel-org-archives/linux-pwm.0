From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v6 2/4] drivers: pwm: bcm-kona: Dont set polarity in probe
Date: Fri, 10 Apr 2015 11:58:51 -0700
Message-ID: <1428692333-14400-3-git-send-email-jonathar@broadcom.com>
References: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:7090 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbDJS4l (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2015 14:56:41 -0400
In-Reply-To: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Arun Ramamurthy <arunrama@broadcom.com>

From: Arun Ramamurthy <arunrama@broadcom.com>

Omit setting the polarity to normal during probe and instead use the
new pwmchip_add_inversed function to register a PWM chip with default
polarity of inversed for all channels as this is the actual hardware
default.

Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 02bc048..32b3ec6 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -266,18 +266,15 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Set smooth mode, push/pull, and normal polarity for all channels */
-	for (chan = 0; chan < kp->chip.npwm; chan++) {
-		value |= (1 << PWM_CONTROL_SMOOTH_SHIFT(chan));
+	/* Set push/pull for all channels */
+	for (chan = 0; chan < kp->chip.npwm; chan++)
 		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
-		value |= (1 << PWM_CONTROL_POLARITY_SHIFT(chan));
-	}
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = pwmchip_add(&kp->chip);
+	ret = pwmchip_add_inversed(&kp->chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
1.7.9.5

