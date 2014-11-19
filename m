From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata handling
Date: Wed, 19 Nov 2014 15:33:09 +0100
Message-ID: <1416407589-8157-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39015 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752896AbaKSOdO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Nov 2014 09:33:14 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

at91sam9x5 has an errata forbidding the use of slow clk as a clk source and
sama5d3 SoCs has another errata forbidding the use of div1 prescaler.

Take both of these erratas into account.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hi Thierry,

I've addressed the "erratas stored in of_device_id data" part, but still
haven't modified the compatible strings of the HLCDC subdevices.

Please let me know if you really want to handle erratas through pwm
compatibles instead of parent device compatibles.

Regards,

Boris

Changes since v1:
- use data field in of_device_id to attach erratas to an IP revision

 drivers/pwm/pwm-atmel-hlcdc.c | 50 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index eaf8b12..e7c4400 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -32,10 +32,16 @@
 #define ATMEL_HLCDC_PWMPS_MAX		0x6
 #define ATMEL_HLCDC_PWMPS(x)		((x) & ATMEL_HLCDC_PWMPS_MASK)
 
+struct atmel_hlcdc_pwm_erratas {
+	bool slow_clk_errata;
+	bool div1_clk_errata;
+};
+
 struct atmel_hlcdc_pwm {
 	struct pwm_chip chip;
 	struct atmel_hlcdc *hlcdc;
 	struct clk *cur_clk;
+	const struct atmel_hlcdc_pwm_erratas *erratas;
 };
 
 static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
@@ -56,20 +62,29 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
 	u32 pwmcfg;
 	int pres;
 
-	clk_freq = clk_get_rate(new_clk);
-	clk_period_ns = (u64)NSEC_PER_SEC * 256;
-	do_div(clk_period_ns, clk_freq);
+	if (!chip->erratas || !chip->erratas->slow_clk_errata) {
+		clk_freq = clk_get_rate(new_clk);
+		clk_period_ns = (u64)NSEC_PER_SEC * 256;
+		do_div(clk_period_ns, clk_freq);
+	}
 
-	if (clk_period_ns > period_ns) {
+	/* Errata: cannot use slow clk on some IP revisions */
+	if ((chip->erratas && chip->erratas->slow_clk_errata) ||
+	    clk_period_ns > period_ns) {
 		new_clk = hlcdc->sys_clk;
 		clk_freq = clk_get_rate(new_clk);
 		clk_period_ns = (u64)NSEC_PER_SEC * 256;
 		do_div(clk_period_ns, clk_freq);
 	}
 
-	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++)
+	for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
+		/* Errata: cannot divide by 1 on some IP revisions */
+		if (!pres && chip->erratas && chip->erratas->div1_clk_errata)
+			continue;
+
 		if ((clk_period_ns << pres) >= period_ns)
 			break;
+	}
 
 	if (pres > ATMEL_HLCDC_PWMPS_MAX)
 		return -EINVAL;
@@ -187,8 +202,29 @@ static const struct pwm_ops atmel_hlcdc_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_at91sam9x5_erratas = {
+	.slow_clk_errata = true,
+};
+
+const struct atmel_hlcdc_pwm_erratas atmel_hlcdc_pwm_sama5d3_erratas = {
+	.div1_clk_errata = true,
+};
+
+static const struct of_device_id atmel_hlcdc_dt_ids[] = {
+	{
+		.compatible = "atmel,at91sam9x5-hlcdc",
+		.data = &atmel_hlcdc_pwm_at91sam9x5_erratas,
+	},
+	{
+		.compatible = "atmel,sama5d3-hlcdc",
+		.data = &atmel_hlcdc_pwm_sama5d3_erratas,
+	},
+	{ /* sentinel */ },
+};
+
 static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct atmel_hlcdc_pwm *chip;
 	struct atmel_hlcdc *hlcdc;
@@ -204,6 +240,10 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	match = of_match_node(atmel_hlcdc_dt_ids, dev->parent->of_node);
+	if (match)
+		chip->erratas = match->data;
+
 	chip->hlcdc = hlcdc;
 	chip->chip.ops = &atmel_hlcdc_pwm_ops;
 	chip->chip.dev = dev;
-- 
1.9.1

