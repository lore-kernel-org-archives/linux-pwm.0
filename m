From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/4] pwm: tegra: Increase precision in pwm rate calculation
Date: Wed, 5 Apr 2017 19:43:44 +0530
Message-ID: <1491401626-31303-3-git-send-email-ldewangan@nvidia.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17236 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdDEOc1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Apr 2017 10:32:27 -0400
In-Reply-To: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: jonathanh@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

The rate of the PWM calculated as follows:
	hz = NSEC_PER_SEC / period_ns;
 	rate = (rate + (hz / 2)) / hz;

This has the precision loss in lower PWM rate.
Changing this to have more precision as:
	hz = DIV_ROUND_CLOSE(NSEC_PER_SEC * 100, period_ns);
	rate = DIV_ROUND_CLOSE(rate * 100, hz)

Example:
1. period_ns = 16672000, PWM clock rate is 200KHz.
	Based on old formula
		hz = NSEC_PER_SEC / period_ns
		   = 1000000000ul/16672000
		   = 59 (59.98)
		rate = (200K + 59/2)/59 = 3390

	Based on new method:
		hz = 5998
		rate = DIV_ROUND_CLOSE(200000*100, 5998) = 3334

	If we measure the PWM signal rate, we will get more accurate period
	with rate value of 3334 instead of 3390.

2.  period_ns = 16803898, PWM clock rate is 200KHz.
	Based on old formula:
		hz = 60, rate = 3333
	Based on new formula:
		hz = 5951, rate = 3360

	The rate of 3360 is more near to requested period then the 3333.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 0a688da..e9c4de5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -76,6 +76,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	unsigned long long c = duty_ns;
 	unsigned long rate, hz;
+	unsigned long long ns100 = NSEC_PER_SEC;
+	unsigned long precision = 100; /* Consider 2 digit precision */
 	u32 val = 0;
 	int err;
 
@@ -94,9 +96,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
 	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
-	hz = NSEC_PER_SEC / period_ns;
 
-	rate = (rate + (hz / 2)) / hz;
+	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	ns100 *= precision;
+	hz = DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
+	rate = DIV_ROUND_CLOSEST(rate * precision, hz);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-- 
2.1.4
