From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] pwm: tegra: Read PWM clock source rate in driver init
Date: Thu, 13 Apr 2017 19:40:27 +0530
Message-ID: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

It is required to know the PWM clock source frequency to
calculate the PWM period.

In driver, the clock source frequency of the PWM does not
get change and, hence, get the clock source frequency in
driver initi. Get this values later for period calculation
from pwm_config().

This will help in avoiding the clock call for getting clock rate
in the pwm_config() each time.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/pwm/pwm-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index c040f87..8c6ed55 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -50,6 +50,8 @@ struct tegra_pwm_chip {
 	struct clk *clk;
 	struct reset_control*rst;
 
+	unsigned long clk_rate;
+
 	void __iomem *regs;
 
 	const struct tegra_pwm_soc *soc;
@@ -94,7 +96,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 */
-	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
+	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
@@ -199,6 +201,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	/* Read PWM clock rate from source */
+	pwm->clk_rate = clk_get_rate(pwm->clk);
+
 	pwm->rst = devm_reset_control_get(&pdev->dev, "pwm");
 	if (IS_ERR(pwm->rst)) {
 		ret = PTR_ERR(pwm->rst);
-- 
2.1.4
