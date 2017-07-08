From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 2/7] pwm: rockchip: Remove the judge from return value of pwm_config
Date: Sat,  8 Jul 2017 12:03:44 +0800
Message-ID: <1499486629-9659-3-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

It seems the rockchip_pwm_config always returns the result 0,
so remove the judge.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 617824c..cd45f17 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -165,7 +165,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	clk_disable(pc->pclk);
 }
 
-static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
@@ -188,8 +188,6 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(period, pc->base + pc->data->regs.period);
 	writel(duty, pc->base + pc->data->regs.duty);
-
-	return 0;
 }
 
 static int rockchip_pwm_enable(struct pwm_chip *chip,
@@ -236,13 +234,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		enabled = false;
 	}
 
-	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
-	if (ret) {
-		if (enabled != curstate.enabled)
-			rockchip_pwm_enable(chip, pwm, !enabled,
-				      state->polarity);
-		goto out;
-	}
+	rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
 	if (state->enabled != enabled) {
 		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
-- 
1.9.1
