From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] ARM: dts: ls1021a: add nodes for PWMs
Date: Tue, 27 Nov 2018 15:09:44 +0100
Message-ID: <20181127140944.31018-1-patrick.havelange@essensium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: matthew.weber@rockwellcollins.com, Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

The LS1021A has 8 possible PWMs, so adding them (disabled by default)

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 96 ++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..d3014da9a66b 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -525,6 +525,102 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm@29d0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm1: pwm@29e0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29e0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm2: pwm@29f0000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x29f0000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm3: pwm@2a00000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a00000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm4: pwm@2a10000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a10000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm5: pwm@2a20000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a20000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm6: pwm@2a30000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a30000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
+		pwm7: pwm@2a40000 {
+			compatible = "fsl,vf610-ftm-pwm";
+			#pwm-cells = <3>;
+			reg = <0x0 0x2a40000 0x0 0x10000>;
+			clock-names = "ftm_sys", "ftm_ext",
+				"ftm_fix", "ftm_cnt_clk_en";
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				<&clockgen 4 1>, <&clockgen 4 1>;
+			big-endian;
+			status = "disabled";
+		};
+
 		wdog0: watchdog@2ad0000 {
 			compatible = "fsl,imx21-wdt";
 			reg = <0x0 0x2ad0000 0x0 0x10000>;
-- 
2.17.1
