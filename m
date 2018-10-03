From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
Date: Wed, 3 Oct 2018 22:36:58 +0530
Message-ID: <20181003170658.3835-3-vigneshr@ti.com>
References: <20181003170658.3835-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003170658.3835-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

K3 devices have the same ECAP IP as OMAP SoC. Enable driver to be built
for K3 devices.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 504d252716f2..0c7bc6f554cf 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -447,7 +447,7 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
 	  PWM driver support for the ECAP APWM controller found on AM33XX
 	  TI SOC
-- 
2.19.0
