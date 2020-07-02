From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 8/8] ARM: dts: exynos: Define fixed regulators in root node for consistency in SMDK5420
Date: Thu,  2 Jul 2020 17:51:49 +0200
Message-ID: <20200702155149.12854-8-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pankaj Dubey <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes SMDK5420 board consistent with other Exynos
boards.

Name the fixed regulator nodes consistently.

Suggested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos5420-smdk5420.dts | 56 ++++++++++-------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index e3f2afe8359a..d703c603c45a 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -32,40 +32,34 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		vdd: fixed-regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "vdd-supply";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	vdd: regulator-0 {
+		compatible = "regulator-fixed";
+		reg = <0>;
+		regulator-name = "vdd-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 
-		dbvdd: fixed-regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "dbvdd-supply";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	dbvdd: regulator-1 {
+		compatible = "regulator-fixed";
+		reg = <1>;
+		regulator-name = "dbvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 
-		spkvdd: fixed-regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "spkvdd-supply";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			regulator-always-on;
-		};
+	spkvdd: regulator-2 {
+		compatible = "regulator-fixed";
+		reg = <2>;
+		regulator-name = "spkvdd-supply";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
 	};
 
-	usb300_vbus_reg: regulator-usb300 {
+	usb300_vbus_reg: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS0";
 		regulator-min-microvolt = <5000000>;
@@ -76,7 +70,7 @@
 		enable-active-high;
 	};
 
-	usb301_vbus_reg: regulator-usb301 {
+	usb301_vbus_reg: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "VBUS1";
 		regulator-min-microvolt = <5000000>;
-- 
2.17.1
