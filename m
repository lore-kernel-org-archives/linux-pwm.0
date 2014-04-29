From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 4/4] pwm: ftm-pwm: Add big-endian support
Date: Tue, 29 Apr 2014 11:33:49 +0800
Message-ID: <1398742429-10399-5-git-send-email-Li.Xiubo@freescale.com>
References: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0183.outbound.protection.outlook.com ([207.46.163.183]:39923
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754486AbaD2ES0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 29 Apr 2014 00:18:26 -0400
In-Reply-To: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

This add the big endianness support for the FTM PWM driver, which
will run on LS1 SoC.

Now for the following scenarios:
 SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
---------|--------|---------|---------------------------------
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

