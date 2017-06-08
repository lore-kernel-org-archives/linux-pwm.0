From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 3/3] pwm: meson: improve pwm calculation precision.
Date: Thu,  8 Jun 2017 14:24:16 +0200
Message-ID: <20170608122416.1993-4-jbrunet@baylibre.com>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35720 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdFHMYZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2017 08:24:25 -0400
Received: by mail-wm0-f52.google.com with SMTP id x70so76352502wme.0
        for <linux-pwm@vger.kernel.org>; Thu, 08 Jun 2017 05:24:24 -0700 (PDT)
In-Reply-To: <20170608122416.1993-1-jbrunet@baylibre.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

When using input clocks with high rates, such as clk81 (166MHz), the
fin_ns = NSEC_PER_SEC / fin_freq can introduce a significant error.

Ex: fin_freq = 166666667, NSEC_PER_SEC = 1000000000
    fin_ns = 5,9999999

which is, of course, rounded down to 5. This introduce an error of ~20%
on the period requested from the pwm.

This patch use ps instead of ns (and 64bits integer) to perform the
calculation. This should give a good enough precision.

Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b911a944744a..4cdc66f7f718 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -163,7 +163,8 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 			  unsigned int duty, unsigned int period)
 {
 	unsigned int pre_div, cnt, duty_cnt;
-	unsigned long fin_freq = -1, fin_ns;
+	unsigned long fin_freq = -1;
+	u64 fin_ps;
 
 	if (~(meson->inverter_mask >> id) & 0x1)
 		duty = period - duty;
@@ -179,13 +180,14 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 	}
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
-	fin_ns = NSEC_PER_SEC / fin_freq;
+	fin_ps = ((u64)NSEC_PER_SEC * 1000) / fin_freq;
 
 	/* Calc pre_div with the period */
 	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
-		cnt = DIV_ROUND_CLOSEST(period, fin_ns * (pre_div + 1));
-		dev_dbg(meson->chip.dev, "fin_ns=%lu pre_div=%u cnt=%u\n",
-			fin_ns, pre_div, cnt);
+		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
+					    fin_ps * (pre_div + 1));
+		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
+			fin_ps, pre_div, cnt);
 		if (cnt <= 0xffff)
 			break;
 	}
@@ -208,7 +210,8 @@ static int meson_pwm_calc(struct meson_pwm *meson,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = DIV_ROUND_CLOSEST(duty, fin_ns * (pre_div + 1));
+		duty_cnt = DIV_ROUND_CLOSEST_ULL((u64)duty * 1000,
+						 fin_ps * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
-- 
2.9.4
