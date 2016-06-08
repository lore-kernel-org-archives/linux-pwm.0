From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 01/20] ARM: dts: STi: Rename properites in line with PWM naming conventions
Date: Wed,  8 Jun 2016 10:21:16 +0100
Message-ID: <20160608092135.21184-2-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++--
 arch/arm/boot/dts/stih416.dtsi        | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 5947878..0723900 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -668,7 +668,7 @@
 			pinctrl-0	= <&pinctrl_pwm0_chan0_default>;
 			clock-names	= "pwm";
 			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <1>;
+			st,pwm-num-devs	= <1>;
 
 			status		= "okay";
 		};
@@ -685,7 +685,7 @@
 					&pinctrl_pwm1_chan3_default>;
 			clock-names	= "pwm";
 			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <4>;
+			st,pwm-num-devs	= <4>;
 
 			status		= "disabled";
 		};
diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 0afb4f7..82091072 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -484,7 +484,8 @@
 
 			clock-names	= "pwm";
 			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <4>;
+
+			st,pwm-num-devs = <4>;
 		};
 
 		/* SBC PWM Module */
@@ -508,7 +509,7 @@
 
 			clock-names	= "pwm";
 			clocks		= <&clk_sysin>;
-			st,pwm-num-chan = <3>;
+			st,pwm-num-devs = <3>;
 		};
 	};
 };
-- 
2.8.3
