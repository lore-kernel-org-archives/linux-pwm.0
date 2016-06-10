From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] pwm: lpss: Prevent on_time_div overflow on lower frequencies
Date: Fri, 10 Jun 2016 15:43:21 +0300
Message-ID: <1465562601-44876-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64288 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbcFJMn1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 10 Jun 2016 08:43:27 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Dan O'Donovan <dan@emutex.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org

If duty_ns is large enough multiplying it by 255 overflows and results
wrong duty cycle value being programmed. For example with 10ms duty when
period is 20ms (50%) we get

  255 * 10000000 / 20000000 = -87

because 255 * 10000000 overlows int. Whereas correct value should be

  255 * 10000000 / 20000000 = 127

Fix this by using unsigned long long as type for on_time_div and changing
integer literals to use proper type annotation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Resending with linux-pwm address corrected.

This is on top of Dan's patch:

  https://patchwork.ozlabs.org/patch/628683/

 drivers/pwm/pwm-lpss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 98dc8b80b79d..be4658b42882 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -91,7 +91,7 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			   int duty_ns, int period_ns)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
-	u8 on_time_div;
+	unsigned long long on_time_div;
 	unsigned long c, base_unit_range;
 	unsigned long long base_unit, freq = NSEC_PER_SEC;
 	u32 ctrl;
@@ -113,7 +113,9 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (duty_ns <= 0)
 		duty_ns = 1;
-	on_time_div = 255 - (255 * duty_ns / period_ns);
+	on_time_div = 255ULL * duty_ns;
+	do_div(on_time_div, period_ns);
+	on_time_div = 255ULL - on_time_div;
 
 	pm_runtime_get_sync(chip->dev);
 
-- 
2.8.1
