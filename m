From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 07/20] ARM: dts: STiH416: Define the number of PWM Capture channels
Date: Wed,  8 Jun 2016 10:21:22 +0100
Message-ID: <20160608092135.21184-8-lee.jones@linaro.org>
References: <20160608092135.21184-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608092135.21184-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, robh+dt@kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index c93e78d2..7621fcd 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -487,6 +487,7 @@
 			clocks		= <&clk_sysin>, <&clk_s_a0_ls CLK_ICN_REG>;
 
 			st,pwm-num-devs = <4>;
+			st,capture-num-devs = <2>;
 		};
 
 		/* SBC PWM Module */
-- 
2.8.3
