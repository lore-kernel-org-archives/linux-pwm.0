From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 2/4] pwm: tegra: Increase precision in pwm rate calculation
Date: Fri, 7 Apr 2017 15:04:00 +0530
Message-ID: <1491557642-15940-3-git-send-email-ldewangan@nvidia.com>
References: <1491557642-15940-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491557642-15940-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The rate of the PWM calculated as follows:
	hz = NSEC_PER_SEC / period_ns;
 	rate = (rate + (hz / 2)) / hz;

This has the precision loss in lower PWM rate.

Change this to have more precision as:
	hz = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC * 100, period_ns);
	rate = DIV_ROUND_CLOSEST(rate * 100, hz)

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
		hz = 59, rate = 3390
	Based on new formula:
		hz = 5951, rate = 3360

	The PWM signal rate of 3360 is more near to requested period than 3333.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

---
Changes from v1:
- None

Changes from V2:
- Fix the commit message with exact formula used.
---
 drivers/pwm/pwm-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 0a688da..21518be 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -76,6 +76,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	unsigned long long c = duty_ns;
 	unsigned long rate, hz;
+	unsigned long long ns100 = NSEC_PER_SEC;
 	u32 val = 0;
 	int err;
 
@@ -94,9 +95,11 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
 	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
-	hz = NSEC_PER_SEC / period_ns;
 
-	rate = (rate + (hz / 2)) / hz;
+	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	ns100 *= 100;
+	hz = DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
+	rate = DIV_ROUND_CLOSEST(rate * 100, hz);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-- 
2.1.4
