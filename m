From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v3 3/6] pwm: mediatek: fix clock control issue
Date: Fri, 30 Jun 2017 14:05:18 +0800
Message-ID: <1498802721-32455-4-git-send-email-zhi.mao@mediatek.com>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org

1. prepare top/main clk in mtk_pwm_probe() function,
   it will increase power consumption
   and in original code these clocks is only prepeare but never enabled.
2. pwm clock should be enabled before setting pwm registers
   in function: mtk_pwm_config().
3. delete "pwm_disable" in function:mtk_pwm_remove(),
   as framework should disable all the pwms, before remove them.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |   69 ++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index d08b5b3..554a042 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -2,6 +2,7 @@
  * Mediatek Pulse Width Modulator driver
  *
  * Copyright (C) 2015 John Crispin <blogic@openwrt.org>
+ * Copyright (C) 2017 Zhi Mao <zhi.mao@mediatek.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -61,6 +62,42 @@ static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct mtk_pwm_chip, chip);
 }
 
+static int mtk_pwm_clk_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+	int ret = 0;
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_TOP]);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_MAIN]);
+	if (ret < 0)
+		goto disable_clk_top;
+
+	ret = clk_prepare_enable(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	if (ret < 0)
+		goto disable_clk_main;
+
+	return 0;
+
+disable_clk_main:
+	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+disable_clk_top:
+	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+
+	return ret;
+}
+
+static void mtk_pwm_clk_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
+
+	clk_disable_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	clk_disable_unprepare(pc->clks[MTK_CLK_MAIN]);
+	clk_disable_unprepare(pc->clks[MTK_CLK_TOP]);
+}
+
 static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int num,
 				unsigned int offset)
 {
@@ -80,6 +117,11 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct mtk_pwm_chip *pc = to_mtk_pwm_chip(chip);
 	struct clk *clk = pc->clks[MTK_CLK_PWM1 + pwm->hwpwm];
 	u32 resolution, clkdiv = 0;
+	int ret;
+
+	ret = mtk_pwm_clk_enable(chip, pwm);
+	if (ret < 0)
+		return ret;
 
 	resolution = NSEC_PER_SEC / clk_get_rate(clk);
 
@@ -95,6 +137,8 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMTHRES, duty_ns / resolution);
 
+	mtk_pwm_clk_disable(chip, pwm);
+
 	return 0;
 }
 
@@ -104,7 +148,7 @@ static int mtk_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u32 value;
 	int ret;
 
-	ret = clk_prepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	ret = mtk_pwm_clk_enable(chip, pwm);
 	if (ret < 0)
 		return ret;
 
@@ -124,7 +168,7 @@ static void mtk_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	value &= ~BIT(pwm->hwpwm);
 	writel(value, pc->regs);
 
-	clk_unprepare(pc->clks[MTK_CLK_PWM1 + pwm->hwpwm]);
+	mtk_pwm_clk_disable(chip, pwm);
 }
 
 static const struct pwm_ops mtk_pwm_ops = {
@@ -156,14 +200,6 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 			return PTR_ERR(pc->clks[i]);
 	}
 
-	ret = clk_prepare(pc->clks[MTK_CLK_TOP]);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(pc->clks[MTK_CLK_MAIN]);
-	if (ret < 0)
-		goto disable_clk_top;
-
 	platform_set_drvdata(pdev, pc);
 
 	pc->chip.dev = &pdev->dev;
@@ -174,26 +210,15 @@ static int mtk_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_main;
+		return ret;
 	}
 
 	return 0;
-
-disable_clk_main:
-	clk_unprepare(pc->clks[MTK_CLK_MAIN]);
-disable_clk_top:
-	clk_unprepare(pc->clks[MTK_CLK_TOP]);
-
-	return ret;
 }
 
 static int mtk_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_pwm_chip *pc = platform_get_drvdata(pdev);
-	unsigned int i;
-
-	for (i = 0; i < pc->chip.npwm; i++)
-		pwm_disable(&pc->chip.pwms[i]);
 
 	return pwmchip_remove(&pc->chip);
 }
-- 
1.7.9.5
