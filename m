From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3] pwm: rockchip: State of pwm clock should synchronize with
 pwm enabled state
Date: Wed,  1 Mar 2017 19:10:55 +0800
Message-ID: <1488366655-31387-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: boris.brezillon@free-electrons.com, briannorris@chromium.org, heiko@sntech.de, thierry.reding@gmail.com
Cc: huangtao@rock-chips.com, linux-pwm@vger.kernel.org, dianders@chromium.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, b.galvani@gmail.com, linux-rockchip@lists.infradead.org, caesar.wang@rock-chips.com, "david.wu" <david.wu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
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

Fixes: 2bf1c98aa5a4 ("pwm: rockchip: Add support for atomic update")
Cc: stable@vger.kernel.org
Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
change in v2:
 - change the function name from rk_pwm_enable to rockchip_pwm_enable
 drivers/pwm/pwm-rockchip.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index ef89df1..744d561 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -191,6 +191,28 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int rockchip_pwm_enable(struct pwm_chip *chip,
+			 struct pwm_device *pwm,
+			 bool enable,
+			 enum pwm_polarity polarity)
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
@@ -207,22 +229,26 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	if (state->polarity != curstate.polarity && enabled) {
-		pc->data->set_enable(chip, pwm, false, state->polarity);
+		ret = rockchip_pwm_enable(chip, pwm, false, state->polarity);
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
+			rockchip_pwm_enable(chip, pwm, !enabled,
+				      state->polarity);
 		goto out;
 	}
 
-	if (state->enabled != enabled)
-		pc->data->set_enable(chip, pwm, state->enabled,
-				     state->polarity);
+	if (state->enabled != enabled) {
+		ret = rockchip_pwm_enable(chip, pwm, state->enabled,
+				    state->polarity);
+		if (ret)
+			goto out;
+	}
 
 	/*
 	 * Update the state with the real hardware, which can differ a bit
-- 
1.9.1
