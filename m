From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v8 4/5] pwm: kona: Add debug info to config function
Date: Tue, 26 May 2015 13:08:19 -0700
Message-ID: <1432670900-27687-5-git-send-email-jonathar@broadcom.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Scott Branden <sbranden@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Adds debugging info to config function where duty cycle and period
are calculated and verified.

Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index c87621f..0ddf19b 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -138,18 +138,39 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dc = div64_u64(val, div);
 
 		/* If duty_ns or period_ns are not achievable then return */
-		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
+		if (pc < PERIOD_COUNT_MIN) {
+			dev_warn(chip->dev,
+				"%s: pwm[%d]: period=%d is not achievable, pc=%lu, prescale=%lu\n",
+				__func__, chan, period_ns, pc, prescale);
 			return -EINVAL;
+		}
+
+		if (dc < DUTY_CYCLE_HIGH_MIN) {
+			if (0 != duty_ns) {
+				dev_warn(chip->dev,
+					"%s: pwm[%d]: duty cycle=%d is not achievable, dc=%lu, prescale=%lu\n",
+					__func__, chan, duty_ns, dc, prescale);
+			}
+			return -EINVAL;
+		}
 
 		/* If pc and dc are in bounds, the calculation is done */
 		if (pc <= PERIOD_COUNT_MAX && dc <= DUTY_CYCLE_HIGH_MAX)
 			break;
 
 		/* Otherwise, increase prescale and recalculate pc and dc */
-		if (++prescale > PRESCALE_MAX)
+		if (++prescale > PRESCALE_MAX) {
+			dev_warn(chip->dev,
+				"%s: pwm[%d]: Prescale (=%lu) within max (=%d) for period=%d and duty cycle=%d is not achievable\n",
+				__func__, chan, prescale, PRESCALE_MAX,
+				period_ns, duty_ns);
 			return -EINVAL;
+		}
 	}
 
+	dev_dbg(chip->dev, "pwm[%d]: period=%lu, duty_high=%lu, prescale=%lu\n",
+		chan, pc, dc, prescale);
+
 	/*
 	 * Don't apply settings if disabled. The period and duty cycle are
 	 * always calculated above to ensure the new values are
-- 
1.7.9.5
