From: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/5] pwm: rockchip: Add APB and function both clocks support
Date: Thu, 29 Jun 2017 20:27:47 +0800
Message-ID: <1498739271-27431-2-git-send-email-david.wu@rock-chips.com>
References: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498739271-27431-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

New PWM module provides two individual clocks of APB clock
and function clock.

Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-rockchip.txt       |  8 +++-
 drivers/pwm/pwm-rockchip.c                         | 53 ++++++++++++++++++----
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
index b8be3d0..2350ef9 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
@@ -6,7 +6,13 @@ Required properties:
    "rockchip,rk3288-pwm": found on RK3288 SoC
    "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
  - reg: physical base address and length of the controller's registers
- - clocks: phandle and clock specifier of the PWM reference clock
+ - clocks: See ../clock/clock-bindings.txt
+   - For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399):
+     - There is one clock that's used both to derive the functional clock
+       for the device and as the bus clock.
+   - For newer hardware (rk3328 and future socs): specified by name
+     - "pwm": This is used to derive the functional clock.
+     - "pclk": This is the APB bus clock.
  - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.txt in this directory
    for a description of the cell format.
 
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 744d561..617824c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -33,6 +33,7 @@
 struct rockchip_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
+	struct clk *pclk;
 	const struct rockchip_pwm_data *data;
 	void __iomem *base;
 };
@@ -145,7 +146,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 	u64 tmp;
 	int ret;
 
-	ret = clk_enable(pc->clk);
+	ret = clk_enable(pc->pclk);
 	if (ret)
 		return;
 
@@ -161,7 +162,7 @@ static void rockchip_pwm_get_state(struct pwm_chip *chip,
 
 	pc->data->get_state(chip, pwm, state);
 
-	clk_disable(pc->clk);
+	clk_disable(pc->pclk);
 }
 
 static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -224,7 +225,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_get_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
-	ret = clk_enable(pc->clk);
+	ret = clk_enable(pc->pclk);
 	if (ret)
 		return ret;
 
@@ -257,7 +258,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	rockchip_pwm_get_state(chip, pwm, state);
 
 out:
-	clk_disable(pc->clk);
+	clk_disable(pc->pclk);
 
 	return ret;
 }
@@ -328,7 +329,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
 	struct resource *r;
-	int ret;
+	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
 	if (!id)
@@ -343,13 +344,38 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pc->clk))
-		return PTR_ERR(pc->clk);
+	pc->clk = devm_clk_get(&pdev->dev, "pwm");
+	count = of_property_count_strings(pdev->dev.of_node, "clock-names");
+	if (count == 2)
+		pc->pclk = devm_clk_get(&pdev->dev, "pclk");
+	else
+		pc->pclk = pc->clk;
+
+	if (IS_ERR(pc->clk)) {
+		ret = PTR_ERR(pc->clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get bus clk: %d\n", ret);
+		return ret;
+	}
+
+	if (IS_ERR(pc->pclk)) {
+		ret = PTR_ERR(pc->pclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
+		return ret;
+	}
 
 	ret = clk_prepare_enable(pc->clk);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
 		return ret;
+	}
+
+	ret = clk_prepare(pc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
+		goto err_clk;
+	}
 
 	platform_set_drvdata(pdev, pc);
 
@@ -368,12 +394,20 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		clk_unprepare(pc->clk);
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		goto err_pclk;
 	}
 
 	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
 	if (!pwm_is_enabled(pc->chip.pwms))
 		clk_disable(pc->clk);
 
+	return 0;
+
+err_pclk:
+	clk_unprepare(pc->pclk);
+err_clk:
+	clk_disable_unprepare(pc->clk);
+
 	return ret;
 }
 
@@ -395,6 +429,7 @@ static int rockchip_pwm_remove(struct platform_device *pdev)
 	if (pwm_is_enabled(pc->chip.pwms))
 		clk_disable(pc->clk);
 
+	clk_unprepare(pc->pclk);
 	clk_unprepare(pc->clk);
 
 	return pwmchip_remove(&pc->chip);
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
