From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 1/4] pwm: tegra: Use DIV_ROUND_CLOSEST_ULL() instead of local implementation
Date: Thu, 6 Apr 2017 19:50:58 +0530
Message-ID: <1491488461-24621-2-git-send-email-ldewangan@nvidia.com>
References: <1491488461-24621-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1491488461-24621-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Use macro DIV_ROUND_CLOSEST_ULL() for 64bit division to closet one
instead of implementing the same locally. This increase readability.

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes from V1:
None

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
