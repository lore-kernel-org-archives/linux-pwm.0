From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 3/7] pwm: rockchip: Remove the dumplicate rockchip_pwm_ops ops
Date: Sat,  8 Jul 2017 12:03:45 +0800
Message-ID: <1499486629-9659-4-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

The rockchip_pwm_ops_v1 and rockchip_pwm_ops_v2 ops are the same
struct members, remove one of them.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 drivers/pwm/pwm-rockchip.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index cd45f17..85f9515 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -255,13 +255,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static const struct pwm_ops rockchip_pwm_ops_v1 = {
-	.get_state = rockchip_pwm_get_state,
-	.apply = rockchip_pwm_apply,
-	.owner = THIS_MODULE,
-};
-
-static const struct pwm_ops rockchip_pwm_ops_v2 = {
+static const struct pwm_ops rockchip_pwm_ops = {
 	.get_state = rockchip_pwm_get_state,
 	.apply = rockchip_pwm_apply,
 	.owner = THIS_MODULE,
@@ -275,7 +269,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		.ctrl = 0x0c,
 	},
 	.prescaler = 2,
-	.ops = &rockchip_pwm_ops_v1,
+	.ops = &rockchip_pwm_ops,
 	.set_enable = rockchip_pwm_set_enable_v1,
 	.get_state = rockchip_pwm_get_state_v1,
 };
@@ -289,7 +283,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
-	.ops = &rockchip_pwm_ops_v2,
+	.ops = &rockchip_pwm_ops,
 	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
 };
@@ -303,7 +297,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	},
 	.prescaler = 1,
 	.supports_polarity = true,
-	.ops = &rockchip_pwm_ops_v2,
+	.ops = &rockchip_pwm_ops,
 	.set_enable = rockchip_pwm_set_enable_v2,
 	.get_state = rockchip_pwm_get_state_v2,
 };
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
