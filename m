From: lis8215@gmail.com
Subject: [PATCH v4 8/9] pwm: sunxi: Code cleanup.
Date: Fri, 24 Feb 2017 08:41:15 +0300
Message-ID: <1487914876-8594-9-git-send-email-lis8215@gmail.com>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33528 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXFla (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Feb 2017 00:41:30 -0500
Received: by mail-lf0-f67.google.com with SMTP id j2so753572lfe.0
        for <linux-pwm@vger.kernel.org>; Thu, 23 Feb 2017 21:41:29 -0800 (PST)
In-Reply-To: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-sunxi@googlegroups.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-pwm@vger.kernel.org, Siarhei Volkau <lis8215@gmail.com>

From: Siarhei Volkau <lis8215@gmail.com>

This patch removes macros, which are not use anymore and
fixes two extra -Wsign-compare warnings.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e474303..37fc746 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -28,17 +28,8 @@
 
 #define PWMCH_OFFSET		15
 #define PWM_PRESCAL_MASK	GENMASK(3, 0)
-#define PWM_PRESCAL_OFF		0
 #define PWM_EN			BIT(4)
-#define PWM_ACT_STATE		BIT(5)
 #define PWM_CLK_GATING		BIT(6)
-#define PWM_MODE		BIT(7)
-#define PWM_PULSE		BIT(8)
-#define PWM_BYPASS		BIT(9)
-
-#define PWM_RDY_BASE		28
-#define PWM_RDY_OFFSET		1
-#define PWM_RDY(ch)		BIT(PWM_RDY_BASE + PWM_RDY_OFFSET * (ch))
 
 #define PWM_PRD(prd)		(((prd) - 1) << 16)
 #define PWM_PRD_MASK		GENMASK(15, 0)
@@ -539,7 +530,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	u32 val;
-	int i, ret;
+	int ret;
+	unsigned int i;
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
-- 
2.4.11
