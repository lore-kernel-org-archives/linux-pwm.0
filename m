From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] pwm: bcm7038: fix build failure
Date: Tue,  6 Oct 2015 16:50:54 +0530
Message-ID: <1444130454-17769-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <20151006182522.09d2d3f5@canb.auug.org.au>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36609 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbJFLVF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Oct 2015 07:21:05 -0400
In-Reply-To: <20151006182522.09d2d3f5@canb.auug.org.au>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

While building arm allmodconfig, the build fails with:
In function 'brcmstb_pwm_suspend': error: 'dev' undeclared (first use in this function)
In function 'brcmstb_pwm_resume': error: 'dev' undeclared (first use in this function)

The function was using dev but the argument that it received was named
as "d". Declare dev and fix the build fail.

Fixes: 9a47354fe63a ("pwm: Add Broadcom BCM7038 PWM controller support")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/pwm/pwm-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 083e3ef..423ce08 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -304,7 +304,7 @@ static int brcmstb_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int brcmstb_pwm_suspend(struct device *d)
+static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
@@ -313,7 +313,7 @@ static int brcmstb_pwm_suspend(struct device *d)
 	return 0;
 }
 
-static int brcmstb_pwm_resume(struct device *d)
+static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-- 
1.9.1
