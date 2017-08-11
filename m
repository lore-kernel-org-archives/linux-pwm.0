From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 07/13] ARM: dts: rockchip: add pwm dt node for rv1108
Date: Fri, 11 Aug 2017 11:44:33 +0800
Message-ID: <1502423073-31039-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:46654 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbdHKDom (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Aug 2017 23:44:42 -0400
In-Reply-To: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>

Add pwm device tree node for rv1108 soc

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3: None
Changes in v2:
- add compatible string "rockchip,rv1108-pwm"

 arch/arm/boot/dts/rv1108.dtsi | 143 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index b688f4a..76a325a 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -213,6 +213,54 @@
 		status = "disabled";
 	};
 
+	pwm4: pwm@10280000 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x10280000 0x10>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm4_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm5: pwm@10280010 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x10280010 0x10>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm5_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm6: pwm@10280020 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x10280020 0x10>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm6_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm7: pwm@10280030 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x10280030 0x10>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm7_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
 	grf: syscon@10300000 {
 		compatible = "rockchip,rv1108-grf", "syscon";
 		reg = <0x10300000 0x1000>;
@@ -232,6 +280,53 @@
 		status = "disabled";
 	};
 
+	pwm0: pwm@20040000 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x20040000 0x10>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm1: pwm@20040010 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x20040010 0x10>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm2: pwm@20040020 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x20040020 0x10>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm3: pwm@20040030 {
+		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
+		reg = <0x20040030 0x10>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm3_pin>;
+		clocks = <&cru SCLK_PWM0_PMU>, <&cru PCLK_PWM0_PMU>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
 	pmugrf: syscon@20060000 {
 		compatible = "rockchip,rv1108-pmugrf", "syscon";
 		reg = <0x20060000 0x1000>;
@@ -466,6 +561,54 @@
 			};
 		};
 
+		pwm0 {
+			pwm0_pin: pwm0-pin {
+				rockchip,pins = <0 RK_PC5 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm1 {
+			pwm1_pin: pwm1-pin {
+				rockchip,pins = <0 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm2 {
+			pwm2_pin: pwm2-pin {
+				rockchip,pins = <0 RK_PC6 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm3 {
+			pwm3_pin: pwm3-pin {
+				rockchip,pins = <0 RK_PC0 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
+
+		pwm4 {
+			pwm4_pin: pwm4-pin {
+				rockchip,pins = <1 RK_PC1 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
+
+		pwm5 {
+			pwm5_pin: pwm5-pin {
+				rockchip,pins = <1 RK_PA7 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		pwm6 {
+			pwm6_pin: pwm6-pin {
+				rockchip,pins = <1 RK_PB0 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		pwm7 {
+			pwm7_pin: pwm7-pin {
+				rockchip,pins = <1 RK_PB1 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		sdmmc {
 			sdmmc_clk: sdmmc-clk {
 				rockchip,pins = <3 RK_PC4 RK_FUNC_1 &pcfg_pull_none_drv_4ma>;
-- 
2.7.4
