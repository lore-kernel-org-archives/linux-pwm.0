From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 3/5] pwm: tegra: fix overflow when calculating duty cycle
Date: Wed, 22 Jun 2016 17:17:21 +0530
Message-ID: <1466596043-27262-4-git-send-email-ldewangan@nvidia.com>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Hyong Bin Kim <hyongbink@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

From: Hyong Bin Kim <hyongbink@nvidia.com>

duty_ns * (1 << PWM_DUTY_WIDTH) could overflow in integer calcualtion
when PWM rate is low. Hence do all calculation on unsigned long long
to avoid overflow.

Signed-off-by: Hyong Bin Kim <hyongbink@nvidia.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 575ca8e..49cefd5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -69,7 +69,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	unsigned long long c;
+	unsigned long long c = duty_ns;
 	unsigned long rate, hz;
 	u32 val = 0;
 	int err;
@@ -79,7 +79,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c = duty_ns * (1 << PWM_DUTY_WIDTH) + period_ns / 2;
+	c *= (1 << PWM_DUTY_WIDTH);
+	c += period_ns / 2;
 	do_div(c, period_ns);
 
 	val = (u32)c << PWM_DUTY_SHIFT;
-- 
2.1.4
