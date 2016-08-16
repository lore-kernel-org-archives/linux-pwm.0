From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 15/17] pwm: sti: It's now valid for number of PWM channels to be zero
Date: Tue, 16 Aug 2016 10:35:06 +0100
Message-ID: <20160816093508.28307-16-lee.jones@linaro.org>
References: <20160816093508.28307-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160816093508.28307-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, patrice.chotard@st.com, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Setting up the STI PWM IP as capture only, with zero PWM-out devices
is a perfectly valued configuration.  It is no longer okay to assume
that there must be at least 1 PWM-out devices.  In this patch we make
the default number of PWM-out devices zero and only configure channels
explicitly requested.

Reported-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-sti.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index fcc80eb..a1319c0 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -483,6 +483,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	if (!ret)
 		cdata->cpt_num_devs = num_devs;
 
+	if (cdata->pwm_num_devs && !cdata->cpt_num_devs) {
+		dev_err(dev, "No channels configured\n");
+		return -EINVAL;
+	}
+
 	reg_fields = cdata->reg_fields;
 
 	pc->prescale_low = devm_regmap_field_alloc(dev, pc->regmap,
@@ -573,7 +578,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields   = &sti_pwm_regfields[0];
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt  = 255;
-	cdata->pwm_num_devs = 1;
+	cdata->pwm_num_devs = 0;
 	cdata->cpt_num_devs = 0;
 
 	pc->cdata = cdata;
@@ -585,6 +590,9 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (!cdata->pwm_num_devs)
+		goto skip_pwm;
+
 	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
 	if (IS_ERR(pc->pwm_clk)) {
 		dev_err(dev, "failed to get PWM clock\n");
@@ -597,6 +605,10 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+skip_pwm:
+	if (!cdata->cpt_num_devs)
+		goto skip_cpt;
+
 	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
 	if (IS_ERR(pc->cpt_clk)) {
 		dev_err(dev, "failed to get PWM capture clock\n");
@@ -609,6 +621,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+skip_cpt:
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
-- 
2.9.0
