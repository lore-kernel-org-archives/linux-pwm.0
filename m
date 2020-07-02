From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 4/8] arm64: dts: exynos: Remove DMA controller bus node name to fix dtschema warnings
Date: Thu,  2 Jul 2020 17:51:45 +0200
Message-ID: <20200702155149.12854-4-krzk@kernel.org>
References: <20200702155149.12854-1-krzk@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200702155149.12854-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <snawrocki-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Pankaj Dubey <pankaj.dubey-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

There is no need to keep DMA controller nodes under AMBA bus node.
Remove the "amba" node to fix dtschema warnings like:

    amba: $nodename:0: 'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---

Changes since v1:
1. Remove the bus, as suggested by Marek
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 47 +++++++++-------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 47 +++++++++-------------
 2 files changed, 40 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 57b433a1c900..74ac4ac75865 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1756,33 +1756,26 @@
 			status = "disabled";
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@15610000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x15610000 0x1000>;
-				interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu_fsys CLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@15600000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x15600000 0x1000>;
-				interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cmu_fsys CLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@15610000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x15610000 0x1000>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_fsys CLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@15600000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x15600000 0x1000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu_fsys CLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		audio-subsystem@11400000 {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index c0b63b0d39ab..b9ed6a33e290 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -105,33 +105,26 @@
 				<0x11006000 0x2000>;
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pdma0: pdma@10e10000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10E10000 0x1000>;
-				interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_fsys0 ACLK_PDMA0>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
-
-			pdma1: pdma@10eb0000 {
-				compatible = "arm,pl330", "arm,primecell";
-				reg = <0x10EB0000 0x1000>;
-				interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clock_fsys0 ACLK_PDMA1>;
-				clock-names = "apb_pclk";
-				#dma-cells = <1>;
-				#dma-channels = <8>;
-				#dma-requests = <32>;
-			};
+		pdma0: pdma@10e10000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10E10000 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 ACLK_PDMA0>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
+		};
+
+		pdma1: pdma@10eb0000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x10EB0000 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_fsys0 ACLK_PDMA1>;
+			clock-names = "apb_pclk";
+			#dma-cells = <1>;
+			#dma-channels = <8>;
+			#dma-requests = <32>;
 		};
 
 		clock_topc: clock-controller@10570000 {
-- 
2.17.1
