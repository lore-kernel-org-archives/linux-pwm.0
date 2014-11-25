From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH v2 2/4] pwm: kona: Fix incorrect enable after channel polarity change
Date: Tue, 25 Nov 2014 11:40:39 -0800
Message-ID: <1416944441-12066-3-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1416944441-12066-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:17061 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaKYTl2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Nov 2014 14:41:28 -0500
In-Reply-To: <1416944441-12066-1-git-send-email-sbranden@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, Tim Kryger <tim.kryger@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arun Ramamurthy <arunrama@broadcom.com>

The pwm core code requires a separate call for enabling the channel
and hence the driver does not need to set pwm_trigger after a
polarity change

Signed-off-by: Arun Ramamurthy <arunrama@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 29eef9e..fa0b5bf 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -173,11 +173,6 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
-	kona_pwmc_apply_settings(kp, chan);
-
-	/* Wait for waveform to settle before gating off the clock */
-	ndelay(400);
-
 	clk_disable_unprepare(kp->clk);
 
 	return 0;
-- 
2.1.3

