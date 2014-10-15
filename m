From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 2/3] pwm: ftm: add regmap rbtree type cache support.
Date: Wed, 15 Oct 2014 13:21:34 +0800
Message-ID: <1413350495-40980-3-git-send-email-Li.Xiubo@freescale.com>
References: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

This patch is to prepare for adding PM support for FTM pwm driver
using callback function suspend and resume in .driver.pm of
platform_driver.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 1150598..9bfbea5 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -397,12 +397,23 @@ static int fsl_pwm_init(struct fsl_pwm_chip *fpc)
 	return 0;
 }
 
+static bool fsl_pwm_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FTM_CNT:
+		return true;
+	}
+	return false;
+}
+
 static const struct regmap_config fsl_pwm_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 
 	.max_register = FTM_PWMLOAD,
+	.volatile_reg = fsl_pwm_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_pwm_probe(struct platform_device *pdev)
-- 
2.1.0.27.g96db324
