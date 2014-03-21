From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 3/3] pwm: ftm-pwm: Add big-endian support
Date: Fri, 21 Mar 2014 12:53:10 +0800
Message-ID: <1395377590-23537-4-git-send-email-Li.Xiubo@freescale.com>
References: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395377590-23537-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: broonie@kernel.org, swarren@nvidia.com, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

Now for the following scenarios:

     SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
-------------|--------|---------|---------------------------------
    Vybird   |  LE    |   LE    |     No
     LS1     |  LE    |   BE    |     Yes
     LS2     |  LE    |   LE    |     No

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 5d999c1..9a82741 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -409,6 +409,7 @@ static struct regmap_config fsl_pwm_regmap_config = {
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct fsl_pwm_chip *fpc;
 	struct resource *res;
 	void __iomem *base;
@@ -422,6 +423,11 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 	fpc->chip.dev = &pdev->dev;
 
+	if (of_property_read_bool(np, "big-endian"))
+		fsl_pwm_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
+	else
+		fsl_pwm_regmap_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-- 
1.8.4
