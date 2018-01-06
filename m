From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] pwm: jz4740: Enable for all Ingenic SoCs
Date: Sat,  6 Jan 2018 17:58:43 +0100
Message-ID: <20180106165843.3461-4-paul@crapouillou.net>
References: <20180106165843.3461-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180106165843.3461-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

This driver works perfectly with all the versions of the SoCs from
Ingenic that are supported upstream.

This makes the driver usable on JZ4740, JZ4770 and JZ4780 SoCs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..f4209302401c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -209,10 +209,10 @@ config PWM_IMX
 	  will be called pwm-imx.
 
 config PWM_JZ4740
-	tristate "Ingenic JZ4740 PWM support"
-	depends on MACH_JZ4740
+	tristate "Ingenic JZ47xx PWM support"
+	depends on MACH_INGENIC
 	help
-	  Generic PWM framework driver for Ingenic JZ4740 based
+	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
 
 	  To compile this driver as a module, choose M here: the module
-- 
2.11.0
