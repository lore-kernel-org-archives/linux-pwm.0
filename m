From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 10/14] pwm: meson: simplify the calculation of the pre-divider and count
Date: Sat, 25 May 2019 20:11:29 +0200
Message-ID: <20190525181133.4875-11-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

Replace the loop to calculate the pre-divider and count with two
separate div64_u64() calculations. This makes the code easier to read
and improves the precision.

Two example cases:
1) 32.768kHz LPO clock for the SDIO wifi chip on Khadas VIM
   clock input: 500MHz (FCLK_DIV4)
   period: 30518ns
   duty cycle: 15259ns
old algorithm: pre_div=0, cnt=15259
new algorithm: pre_div=0, cnt=15259
(no difference in calculated values)

2) PWM LED on Khadas VIM
   clock input: 24MHz (XTAL)
   period: 7812500ns
   duty cycle: 7812500ns
old algorithm: pre_div=2, cnt=62004
new algorithm: pre_div=2, cnt=62500
Using a scope (24MHz sampling rate) shows the actual difference:
- old: 7753000ns, off by -59500ns (0.7616%)
- new: 7815000ns, off by +2500ns (0.032%)

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 27915d6475e3..9afa1e5aaebf 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -145,7 +146,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
-	u64 fin_ps;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -164,24 +164,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	}
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
-	fin_ps = (u64)NSEC_PER_SEC * 1000;
-	do_div(fin_ps, fin_freq);
-
-	/* Calc pre_div with the period */
-	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
-		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
-					    fin_ps * (pre_div + 1));
-		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
-			fin_ps, pre_div, cnt);
-		if (cnt <= 0xffff)
-			break;
-	}
 
+	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
+	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	if (cnt > 0xffff) {
+		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		return -EINVAL;
+	}
+
 	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
@@ -195,8 +190,8 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = DIV_ROUND_CLOSEST_ULL((u64)duty * 1000,
-						 fin_ps * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * (u64)duty,
+				     NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
-- 
2.21.0
