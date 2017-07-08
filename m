From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2 7/7] arm64: dts: rockchip: Add pwm nodes for rk3328
Date: Sat,  8 Jul 2017 12:10:15 +0800
Message-ID: <1499487015-9994-1-git-send-email-david.wu@rock-chips.com>
References: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:40319 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdGHEGP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jul 2017 00:06:15 -0400
In-Reply-To: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org
Cc: catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

There are 4 pwm channels built in rk3328 soc, need to configure
the both APB clock and bus clock.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 29b3800..46f0847 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -310,6 +310,51 @@
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pwm0: pwm@ff1b0000 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0000 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm1: pwm@ff1b0010 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0010 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm2: pwm@ff1b0020 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0020 0x0 0x10>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm2_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
+	pwm3: pwm@ff1b0030 {
+		compatible = "rockchip,rk3328-pwm";
+		reg = <0x0 0xff1b0030 0x0 0x10>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwmir_pin>;
+		clocks = <&cru SCLK_PWM>, <&cru PCLK_PWM>;
+		clock-names = "pwm", "pclk";
+		status = "disabled";
+	};
+
 	saradc: adc@ff280000 {
 		compatible = "rockchip,rk3328-saradc", "rockchip,rk3399-saradc";
 		reg = <0x0 0xff280000 0x0 0x100>;
-- 
1.9.1
