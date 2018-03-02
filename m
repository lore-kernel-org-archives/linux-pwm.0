From: <sean.wang@mediatek.com>
Subject: [PATCH v1] pwm: mediatek: improve precision in rate calculation
Date: Fri, 2 Mar 2018 16:49:14 +0800
Message-ID: <72b74a30ced1c7e7549dcbb56d6123fc27fac405.1519980119.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, matthias.bgg@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a way that turning resolution from in nanosecond into in picosecond
to improve noticeably almost 4.5% precision.

It's necessary to hold the new resolution with type u64 and thus related
operations on u64 are applied instead in those rate calculations.

And the patch has a dependency on [1].

[1] http://lists.infradead.org/pipermail/linux-mediatek/2018-March/012225.html

Cc: stable@vger.kernel.org
Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 796baea..98b0a93 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -135,19 +135,25 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
-	u32 resolution, clkdiv = 0, reg_width = PWMDWIDTH,
+	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
 	    reg_thres = PWMTHRES;
+	u64 resolution;
 	int ret;
 
 	ret = mtk_pwm_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
-	resolution = NSEC_PER_SEC / clk_get_rate(clk);
+	/* Using resolution in picosecond gets accuracy higher */
+	resolution = (u64)NSEC_PER_SEC * 1000;
+	do_div(resolution, clk_get_rate(clk));
 
-	while (period_ns / resolution > 8191) {
+	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
+	while (cnt_period > 8191) {
 		resolution *= 2;
 		clkdiv++;
+		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
+						   resolution);
 	}
 
 	if (clkdiv > PWM_CLK_DIV_MAX) {
@@ -165,9 +171,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		reg_thres = PWM45THRES_FIXUP;
 	}
 
+	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, period_ns / resolution);
-	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, duty_ns / resolution);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_width, cnt_period);
+	mtk_pwm_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 
 	mtk_pwm_clk_disable(chip, pwm);
 
-- 
2.7.4
