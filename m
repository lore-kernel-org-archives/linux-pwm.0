From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 1/5] pwm: tegra: Add support for reset control
Date: Wed, 22 Jun 2016 17:17:19 +0530
Message-ID: <1466596043-27262-2-git-send-email-ldewangan@nvidia.com>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5822 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbcFVMBI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2016 08:01:08 -0400
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Rohith Seelaboyina <rseelaboyina@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>

From: Rohith Seelaboyina <rseelaboyina@nvidia.com>

Add reset control of the PWM controller to reset it before
accessing the PWM register.

Signed-off-by: Rohith Seelaboyina <rseelaboyina@nvidia.com>
Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index d4de060..71b9c4d 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -29,6 +29,7 @@
 #include <linux/pwm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/reset.h>
 
 #define PWM_ENABLE	(1 << 31)
 #define PWM_DUTY_WIDTH	8
@@ -43,6 +44,7 @@ struct tegra_pwm_chip {
 	struct device		*dev;
 
 	struct clk		*clk;
+	struct reset_control	*rstc;
 
 	void __iomem		*mmio_base;
 };
@@ -189,6 +191,14 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	pwm->rstc = devm_reset_control_get(&pdev->dev, "pwm");
+	if (IS_ERR(pwm->rstc)) {
+		ret = PTR_ERR(pwm->rstc);
+		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
+		return ret;
+	}
+	reset_control_reset(pwm->rstc);
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &tegra_pwm_ops;
 	pwm->chip.base = -1;
-- 
2.1.4
