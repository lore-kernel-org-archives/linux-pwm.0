From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Date: Fri, 3 Apr 2020 18:05:03 +0530
Message-ID: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Added support for dynamic clock freq configuration in pwm kernel driver.
Earlier the pwm driver used to cache boot time clock rate by pwm clock
parent during probe. Hence dynamically changing pwm frequency was not
possible for all the possible ranges. With this change, dynamic calculation
is enabled and it is able to set the requested period from sysfs knob
provided the value is supported by clock source.

Changes mainly have 2 parts:
  - T186 and later chips [1]
  - T210 and prior chips [2]

For [1] - Changes implemented to set pwm period dynamically and
          also checks added to allow only if requested period(ns) is
          below or equals to higher range.

For [2] - Only checks if the requested period(ns) is below or equals
          to higher range defined by max clock limit. The limitation
          in T210 or prior chips are due to the reason of having only
          one pwm-controller supporting multiple channels. But later
          chips have multiple pwm controller instances each having
	  single channel support.

Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/pwm/pwm-tegra.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3..d3ba33c 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -4,7 +4,7 @@
  *
  * Tegra pulse-width-modulation controller driver
  *
- * Copyright (c) 2010, NVIDIA Corporation.
+ * Copyright (c) 2010-2020, NVIDIA Corporation.
  * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
  */
 
@@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (u32)c << PWM_DUTY_SHIFT;
 
 	/*
+	 * Its okay to ignore the fraction part since we will be trying to set
+	 * slightly lower value to rate than the actual required rate
+	 */
+	rate = NSEC_PER_SEC/period_ns;
+
+	/*
+	 *  Period in nano second has to be <= highest allowed period
+	 *  based on the max clock rate of the pwm controller.
+	 *
+	 *  higher limit = max clock limit >> PWM_DUTY_WIDTH
+	 */
+	if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
+		return -EINVAL;
+
+	/*
 	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
-	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+	if (pc->soc->num_channels == 1) {
+		/*
+		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * with the hieghest applicable rate that the controller can
+		 * provide. Any further lower value can be derived by setting
+		 * PFM bits[0:12].
+		 * Higher mark is taken since BPMP has round-up mechanism
+		 * implemented.
+		 */
+		rate = rate << PWM_DUTY_WIDTH;
+
+		err = clk_set_rate(pc->clk, rate);
+		if (err < 0)
+			return -EINVAL;
+
+		rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
+	} else {
+		/*
+		 * This is the case for SoCs who support multiple channels:
+		 *
+		 * clk_set_rate() can not be called again in config because
+		 * T210 or any prior chip supports one pwm-controller and
+		 * multiple channels. Hence in this case cached clock rate
+		 * will be considered which was stored during probe.
+		 */
+		rate = pc->clk_rate >> PWM_DUTY_WIDTH;
+	}
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
-- 
2.7.4
