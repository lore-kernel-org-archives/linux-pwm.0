From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH] pwm: rockchip: State of pwm clock should synchronize with pwm enabled state
Date: Tue, 28 Feb 2017 14:43:36 +0800
Message-ID: <1488264216-9361-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@free-electrons.com, briannorris@chromium.org, heiko@sntech.de, thierry.reding@gmail.com
Cc: dianders@chromium.org, b.galvani@gmail.com, caesar.wang@rock-chips.com, huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "david.wu" <david.wu@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

From: "david.wu" <david.wu@rock-chips.com>

If the pwm was not enabled at uboot loader, pwm could not work for clock
always disabled at pwm driver. The pwm clock is enabled at beginning of
pwm_apply(), but disabled at end of pwm_apply().

If the pwm was enabled at uboot loader, pwm clock is always enabled unless
closed by ATF. The pwm-backlight might turn off the power at early suspend,
should disable pwm clock for saving power consume.

It is important to provide opportunity to enable/disable clock at pwm driver,
the pwm consumer should ensure correct order to call pwm enable/disable, and
pwm driver ensure state of pwm clock synchronized with pwm enabled state.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 drivers/pwm/pwm-rockchip.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index ef89df1..14a0445 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -191,6 +191,26 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int rk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			 bool enable, enum pwm_polarity polarity)
+{
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	int ret;
+
+	if (enable) {
+		ret = clk_enable(pc->clk);
+		if (ret)
+			return ret;
+	}
+
+	pc->data->set_enable(chip, pwm, enable, polarity);
+
+	if (!enable)
+		clk_disable(pc->clk);
+
+	return 0;
+}
+
 static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      struct pwm_state *state)
 {
@@ -207,22 +227,26 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	if (state->polarity != curstate.polarity && enabled) {
-		pc->data->set_enable(chip, pwm, false, state->polarity);
+		ret = rk_pwm_enable(chip, pwm, false, state->polarity);
+		if (ret)
+			goto out;
 		enabled = false;
 	}
 
 	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
 	if (ret) {
 		if (enabled != curstate.enabled)
-			pc->data->set_enable(chip, pwm, !enabled,
-					     state->polarity);
-
+			rk_pwm_enable(chip, pwm, !enabled,
+				      state->polarity);
 		goto out;
 	}
 
-	if (state->enabled != enabled)
-		pc->data->set_enable(chip, pwm, state->enabled,
-				     state->polarity);
+	if (state->enabled != enabled) {
+		ret = rk_pwm_enable(chip, pwm, state->enabled,
+				    state->polarity);
+		if (ret)
+			goto out;
+	}
 
 	/*
 	 * Update the state with the real hardware, which can differ a bit
-- 
1.9.1
