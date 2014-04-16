From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PWM: Enable driver compilation with COMPILE_TEST
Date: Wed, 16 Apr 2014 08:52:07 +0800
Message-ID: <1397609527.14807.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:43375 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaDPAwN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Apr 2014 20:52:13 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so9788549vcb.22
        for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2014 17:52:12 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, "Philip, Avinash" <avinashphilip@ti.com>, Tony Prisk <linux@prisktech.co.nz>, linux-pwm@vger.kernel.org

This helps increasing build testing coverage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 5b34ff2..bdaec11 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -91,7 +91,7 @@ config PWM_EP93XX
 
 config PWM_FSL_FTM
 	tristate "Freescale FlexTimer Module (FTM) PWM support"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  Generic FTM PWM framework driver for Freescale VF610 and
 	  Layerscape LS-1 SoCs.
@@ -101,7 +101,7 @@ config PWM_FSL_FTM
 
 config PWM_IMX
 	tristate "i.MX PWM support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for i.MX.
 
@@ -130,7 +130,7 @@ config PWM_LP3943
 
 config PWM_LPC32XX
 	tristate "LPC32XX PWM support"
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	help
 	  Generic PWM framework driver for LPC32XX. The LPC32XX SOC has two
 	  PWM controllers.
@@ -150,7 +150,7 @@ config PWM_LPSS
 
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
-	depends on ARCH_MXS && OF
+	depends on (ARCH_MXS && OF) || COMPILE_TEST
 	select STMP_DEVICE
 	help
 	  Generic PWM framework driver for Freescale MXS.
@@ -179,7 +179,7 @@ config PWM_PUV3
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  Generic PWM framework driver for PXA.
 
@@ -219,7 +219,7 @@ config PWM_SPEAR
 
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Generic PWM framework driver for the PWFM controller found on NVIDIA
 	  Tegra SoCs.
@@ -229,7 +229,7 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX
+	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX || COMPILE_TEST
 	help
 	  PWM driver support for the ECAP APWM controller found on AM33XX
 	  TI SOC
@@ -239,7 +239,7 @@ config  PWM_TIECAP
 
 config  PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
-	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX
+	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX || COMPILE_TEST
 	help
 	  PWM driver support for the EHRPWM controller found on AM33XX
 	  TI SOC
@@ -276,7 +276,7 @@ config PWM_TWL_LED
 
 config PWM_VT8500
 	tristate "vt8500 PWM support"
-	depends on ARCH_VT8500
+	depends on ARCH_VT8500 || COMPILE_TEST
 	help
 	  Generic PWM framework driver for vt8500.
 
-- 
1.8.3.2



