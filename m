From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] pwm: Kconfig: Select REGMAP_MMIO for PWM_FSL_FTM
Date: Thu, 21 Aug 2014 20:50:25 -0300
Message-ID: <1408665025-23204-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36029 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaHUXuo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Aug 2014 19:50:44 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so9722390qgf.35
        for <linux-pwm@vger.kernel.org>; Thu, 21 Aug 2014 16:50:43 -0700 (PDT)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: Li.Xiubo@freescale.com, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 42fa98a9c3609c1 ("pwm: fsl-ftm: Convert to direct regmap API usage")
introduced the following error when REGMAP_MMIO=n:

drivers/built-in.o: In function `fsl_pwm_probe':
>> pwm-fsl-ftm.c:(.text+0xd7d7): undefined reference to `devm_regmap_init_mmio_clk'

Select select REGMAP_MMIO in order to fix this error.

Reported-by: kbuild test robot <fengguang.wu@intel.com> 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Change since v1:
- Added Reported-by tag

 drivers/pwm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b800783..e56e91e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -101,6 +101,7 @@ config PWM_EP93XX
 config PWM_FSL_FTM
 	tristate "Freescale FlexTimer Module (FTM) PWM support"
 	depends on OF
+	select REGMAP_MMIO
 	help
 	  Generic FTM PWM framework driver for Freescale VF610 and
 	  Layerscape LS-1 SoCs.
-- 
1.9.1

