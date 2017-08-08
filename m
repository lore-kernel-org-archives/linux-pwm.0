From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3 2/7] pwm: rockchip: Remove the judge from return value of
 pwm_config
Date: Tue,  8 Aug 2017 23:38:30 +0800
Message-ID: <1502206715-24174-3-git-send-email-david.wu@rock-chips.com>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, David Wu <david.wu@rock-chips.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

It seems the rockchip_pwm_config always returns the result 0,
so remove the judge.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-rockchip.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index ac3cd5e..33bbb5a 100644
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
