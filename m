From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/8] arm64: dts: exynos: Remove generic arm,armv8-pmuv3 compatible
Date: Thu,  2 Jul 2020 17:51:44 +0200
Message-ID: <20200702155149.12854-3-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgGBPwF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 2 Jul 2020 11:52:05 -0400
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>

The ARM PMU node is described enough with first compatible so remove the
arm,armv8-pmuv3 to fix dtschema warnings like:

    arm-pmu: compatible: Additional items are not allowed ('arm,armv8-pmuv3' was unexpected)
    arm-pmu: compatible: ['arm,cortex-a57-pmu', 'arm,armv8-pmuv3'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None

Not tested although no effect expected.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++--
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index ebe089469b5f..57b433a1c900 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -24,7 +24,7 @@
 	interrupt-parent = <&gic>;
 
 	arm_a53_pmu {
-		compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
@@ -33,7 +33,7 @@
 	};
 
 	arm_a57_pmu {
-		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 709742b98c9c..c0b63b0d39ab 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	arm-pmu {
-		compatible = "arm,cortex-a57-pmu", "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a57-pmu";
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1
