From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 2/4] pwm: kona: Fix incorrect enable after channel polarity change
Date: Fri, 14 Nov 2014 10:29:58 -0800
Message-ID: <1415989800-7515-3-git-send-email-sbranden@broadcom.com>
References: <Scott Branden <sbranden@broadcom.com>
 <1415989800-7515-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415989800-7515-1-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>, Arun Ramamurthy <arunrama@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

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
