From: Gaetan Hug <ghug@induct.be>
Subject: [PATCH 1/1] fixing pwm-mxs period divider computation
Date: Wed, 18 Feb 2015 09:18:56 +0100
Message-ID: <1424247536-16476-2-git-send-email-ghug@induct.be>
References: <1424247536-16476-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424247536-16476-1-git-send-email-ghug@induct.be>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Gaetan Hug <ghug@induct.be>
List-Id: linux-pwm@vger.kernel.org

---
 drivers/pwm/pwm-mxs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index f75ecb0..bbb2f8a 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -52,15 +52,18 @@ static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long rate;
 	unsigned long long c;
 
+    unsigned const int cdiv[PERIOD_CDIV_MAX] = {1, 2, 4, 8, 16, 64, 256, 1024};
+
 	rate = clk_get_rate(mxs->clk);
+
 	while (1) {
-		c = rate / (1 << div);
+		c = rate / cdiv[div];
 		c = c * period_ns;
 		do_div(c, 1000000000);
 		if (c < PERIOD_PERIOD_MAX)
 			break;
 		div++;
-		if (div > PERIOD_CDIV_MAX)
+		if (div >= PERIOD_CDIV_MAX)
 			return -EINVAL;
 	}
 
-- 
1.7.10.4
