From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 7/8] ARM: dts: exynos: Define fixed regulators in root node for consistency in Arndale
Date: Thu,  2 Jul 2020 17:51:48 +0200
Message-ID: <20200702155149.12854-7-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pankaj Dubey <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Remove the regulators node and define fixed regulators directly under
the root node.  This makes Exynos5250 Arndale board consistent with
other Exynos boards.

Suggested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

Changes since v1:
1. New patch
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 92 +++++++++++-------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index c4cc7611898c..7ccb3814bab6 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -84,60 +84,54 @@
 		};
 	};
 
-	regulators {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		main_dc_reg: regulator@0 {
-			compatible = "regulator-fixed";
-			reg = <0>;
-			regulator-name = "MAIN_DC";
-			regulator-always-on;
-		};
+	main_dc_reg: regulator-0 {
+		compatible = "regulator-fixed";
+		reg = <0>;
+		regulator-name = "MAIN_DC";
+		regulator-always-on;
+	};
 
-		mmc_reg: regulator@1 {
-			compatible = "regulator-fixed";
-			reg = <1>;
-			regulator-name = "VDD_MMC";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-			regulator-always-on;
-		};
+	mmc_reg: regulator-1 {
+		compatible = "regulator-fixed";
+		reg = <1>;
+		regulator-name = "VDD_MMC";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
 
-		reg_hdmi_en: regulator@2 {
-			compatible = "regulator-fixed";
-			reg = <2>;
-			regulator-name = "hdmi-en";
-			regulator-always-on;
-		};
+	reg_hdmi_en: regulator-2 {
+		compatible = "regulator-fixed";
+		reg = <2>;
+		regulator-name = "hdmi-en";
+		regulator-always-on;
+	};
 
-		vcc_1v2_reg: regulator@3 {
-			compatible = "regulator-fixed";
-			reg = <3>;
-			regulator-name = "VCC_1V2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-		};
+	vcc_1v2_reg: regulator-3 {
+		compatible = "regulator-fixed";
+		reg = <3>;
+		regulator-name = "VCC_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
 
-		vcc_1v8_reg: regulator@4 {
-			compatible = "regulator-fixed";
-			reg = <4>;
-			regulator-name = "VCC_1V8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-		};
+	vcc_1v8_reg: regulator-4 {
+		compatible = "regulator-fixed";
+		reg = <4>;
+		regulator-name = "VCC_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
 
-		vcc_3v3_reg: regulator@5 {
-			compatible = "regulator-fixed";
-			reg = <5>;
-			regulator-name = "VCC_3V3";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
+	vcc_3v3_reg: regulator-5 {
+		compatible = "regulator-fixed";
+		reg = <5>;
+		regulator-name = "VCC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	sound {
-- 
2.17.1
