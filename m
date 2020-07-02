From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 6/8] ARM: dts: exynos: Define fixed regulators in root node for consistency in Origen
Date: Thu,  2 Jul 2020 17:51:47 +0200
Message-ID: <20200702155149.12854-6-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702155149.12854-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pwm@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes Exynos4412 Origen board consistent with other
Exynos boards.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos4412-origen.dts | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index dc865be40751..74f7cef8acc5 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -33,20 +33,14 @@
 		reg = <0x0203F000 0x1000>;
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		mmc_reg: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "VMEM_VDD_2.8V";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
-			enable-active-high;
-		};
+	mmc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		reg = <0>;
+		regulator-name = "VMEM_VDD_2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		gpio = <&gpx1 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
 	display-timings {
-- 
2.17.1
