From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH] pwm: lpss: fix base_unit calculation for PWM frequency
Date: Tue, 31 May 2016 15:51:04 +0100
Message-ID: <1464706264-19344-1-git-send-email-dan@emutex.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bert.emutex.com ([91.103.1.109]:60556 "EHLO bert.emutex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbcEaPLb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 31 May 2016 11:11:31 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, mika.westerberg@linux.intel.com, Dan O'Donovan <dan@emutex.com>

The base_unit calculation applies an offset of 0x2 which adds
significant error for lower frequencies and doesn't appear to be
warranted - rounding the division result gives a correct value.

Also, the upper limit check for base_unit is off-by-one; the upper
nibble of base_unit is invalid if >=128 according to the Table 88
in the Z8000 Processor Series Datasheet Volume 1 (Rev. 2).

Verified on UP Board (Cherry Trail) and Minnowboard Max (Bay Trail).

Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/pwm/pwm-lpss.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 295b963..01cc708 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -27,7 +27,6 @@
 #define PWM_SW_UPDATE			BIT(30)
 #define PWM_BASE_UNIT_SHIFT		8
 #define PWM_ON_TIME_DIV_MASK		0x000000ff
-#define PWM_DIVISION_CORRECTION		0x2
 
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
@@ -101,17 +100,16 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * The equation is:
-	 * base_unit = ((freq / c) * base_unit_range) + correction
+	 * base_unit = (round(freq / c) * 65536)
 	 */
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
-	base_unit = freq * base_unit_range;
+	freq *= base_unit_range;
 
 	c = lpwm->info->clk_rate;
 	if (!c)
 		return -EINVAL;
 
-	do_div(base_unit, c);
-	base_unit += PWM_DIVISION_CORRECTION;
+	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
 
 	if (duty_ns <= 0)
 		duty_ns = 1;
-- 
2.1.4
