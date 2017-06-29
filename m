From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH 2/5] pwm: rockchip: Remove the judge from return value of rockchip_pwm_config()
Date: Thu, 29 Jun 2017 20:27:48 +0800
Message-ID: <1498739271-27431-3-git-send-email-david.wu@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:51257 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752956AbdF2MYr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2017 08:24:47 -0400
In-Reply-To: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

It seems the rockchip_pwm_config always returns the result 0,
so remove the judge.

Signed-off-by: David Wu <david.wu@rock-chips.com>
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
