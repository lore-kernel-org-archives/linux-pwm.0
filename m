From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 1/4] pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead of local implementation
Date: Wed, 5 Apr 2017 19:43:43 +0530
Message-ID: <1491401626-31303-2-git-send-email-ldewangan@nvidia.com>
References: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491401626-31303-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: jonathanh@nvidia.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

Use macro DIV_ROUND_CLOSEST_ULL() for 64bit division to closet one
instead of implementing the same locally. This increase readability.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e464784..0a688da 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -85,8 +85,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * nearest integer during division.
 	 */
 	c *= (1 << PWM_DUTY_WIDTH);
-	c += period_ns / 2;
-	do_div(c, period_ns);
+	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
 	val = (u32)c << PWM_DUTY_SHIFT;
 
-- 
2.1.4
