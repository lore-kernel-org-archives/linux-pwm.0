From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/5] pwm: tegra: Allow 100% duty cycle
Date: Wed, 22 Jun 2016 17:17:20 +0530
Message-ID: <1466596043-27262-3-git-send-email-ldewangan@nvidia.com>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, "Victor(Weiguo) Pan" <wpan@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

From: "Victor(Weiguo) Pan" <wpan@nvidia.com>

To get 100% duty cycle (always high), pulse width needs to be
set to 256.

Signed-off-by: Victor(Weiguo) Pan <wpan@nvidia.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 71b9c4d..575ca8e 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -79,7 +79,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c = duty_ns * ((1 << PWM_DUTY_WIDTH) - 1) + period_ns / 2;
+	c = duty_ns * (1 << PWM_DUTY_WIDTH) + period_ns / 2;
 	do_div(c, period_ns);
 
 	val = (u32)c << PWM_DUTY_SHIFT;
-- 
2.1.4
