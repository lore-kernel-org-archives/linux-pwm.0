From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] pwm: tegra: Avoid potential overflow for short periods
Date: Wed, 12 Apr 2017 18:33:20 +0200
Message-ID: <20170412163320.11760-1-thierry.reding@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33037 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbdDLQd2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2017 12:33:28 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org

For very short periods, the result of the division might overflow the
unsigned long hz variable (on 32-bit architectures). Avoid that by
making it an unsigned long long. While at it, also remove an unneeded
local variable whose only purpose is to store a temporary computation.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-tegra.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 9c7f180b9f3a..c040f87ee144 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -75,9 +75,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	unsigned long long c = duty_ns;
-	unsigned long rate, hz;
-	unsigned long long ns100 = NSEC_PER_SEC;
+	unsigned long long c = duty_ns, hz;
+	unsigned long rate;
 	u32 val = 0;
 	int err;
 
@@ -98,9 +97,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	rate = clk_get_rate(pc->clk) >> PWM_DUTY_WIDTH;
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
-	ns100 *= 100;
-	hz = DIV_ROUND_CLOSEST_ULL(ns100, period_ns);
-	rate = DIV_ROUND_CLOSEST(rate * 100, hz);
+	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
+	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
-- 
2.12.0
