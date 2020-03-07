From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] pwm: imx27: Add COMPILE_TEST support for PWM_IMX27
Date: Sat,  7 Mar 2020 21:13:32 +0800
Message-ID: <1583586812-6635-1-git-send-email-Anson.Huang@nxp.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from inva021.nxp.com ([92.121.34.21]:43446 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgCGNTw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 7 Mar 2020 08:19:52 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com

Add COMPILE_TEST support to PWM_IMX27 driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190be..b4fc982 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -204,7 +204,7 @@ config PWM_IMX1
 
 config PWM_IMX27
 	tristate "i.MX27 PWM support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  Generic PWM framework driver for i.MX27 and later i.MX SoCs.
 
-- 
2.7.4
