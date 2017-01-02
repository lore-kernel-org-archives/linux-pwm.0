From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] pwm: lpss: Allow duty cycle to be 0
Date: Mon,  2 Jan 2017 11:16:45 +0200
Message-ID: <20170102091647.86910-3-andriy.shevchenko@linux.intel.com>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:4750 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755228AbdABJRw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 2 Jan 2017 04:17:52 -0500
In-Reply-To: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A duty cycle is represented by values [0..<period>] which reflects [0%..100%].
0% of the duty cycle means always off (logical "0") on output. Allow this in
the driver.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 8642feeb8abd..ffa01ab907a6 100644
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
2.11.0
