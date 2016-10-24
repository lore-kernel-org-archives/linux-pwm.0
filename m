From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] pwm: lpss: Allow duty cycle to be 0
Date: Mon, 24 Oct 2016 17:43:23 +0300
Message-ID: <20161024144325.130353-3-andriy.shevchenko@linux.intel.com>
References: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1944 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbcJXOoC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Oct 2016 10:44:02 -0400
In-Reply-To: <20161024144325.130353-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A duty cycle is represented by values [0..<period>] which reflects [0%..100%].
0% of the duty cycle means always off (logical "0") on output. Allow this in
the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 8642fee..ffa01ab 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -107,8 +107,6 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
 
-	if (duty_ns <= 0)
-		duty_ns = 1;
 	on_time_div = 255ULL * duty_ns;
 	do_div(on_time_div, period_ns);
 	on_time_div = 255ULL - on_time_div;
-- 
2.9.3
