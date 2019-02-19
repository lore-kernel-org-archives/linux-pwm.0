From: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 1/3] pwm: hibvt: Use individual struct per of-data.
Date: Tue, 19 Feb 2019 10:58:06 +0100
Message-ID: <20190219095808.12059-1-m.othacehe@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Split pwm-soc array in one struct per soc and point to the
corresponding on in of-data.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..ffc803818c3c 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -49,15 +49,19 @@ struct hibvt_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
+	const struct hibvt_pwm_soc *soc;
 };
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
 };
 
-static const struct hibvt_pwm_soc pwm_soc[2] = {
-	{ .num_pwms = 4 },
-	{ .num_pwms = 8 },
+static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
+	.num_pwms = 4,
+};
+
+static const struct hibvt_pwm_soc hi3519v100_soc_info = {
+	.num_pwms = 8,
 };
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
@@ -198,6 +202,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.npwm = soc->num_pwms;
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
+	pwm_chip->soc = soc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
@@ -250,8 +255,10 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm",
+	  .data = &hi3516cv300_soc_info },
+	{ .compatible = "hisilicon,hi3519v100-pwm",
+	  .data = &hi3519v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1
