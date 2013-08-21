Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 3/4] ARM: dts: Enables ftm pwm device for Vybrid VF610 TOWER board.
Date: Wed, 21 Aug 2013 11:07:41 +0800
Message-ID: <1377054462-6283-4-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index b3905f5..6f93d8d 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -50,6 +50,23 @@
 	status = "okay";
 };
 
+&pwm0 {
+	pinctrl-names = "en0", "ds0", "en1", "ds1", "en2", "ds2", "en3", "ds3";
+	pinctrl-0 = <&pinctrl_pwm0_ch0_en>;
+	pinctrl-1 = <&pinctrl_pwm0_ch0_ds>;
+	pinctrl-2 = <&pinctrl_pwm0_ch1_en>;
+	pinctrl-3 = <&pinctrl_pwm0_ch1_ds>;
+	pinctrl-4 = <&pinctrl_pwm0_ch2_en>;
+	pinctrl-5 = <&pinctrl_pwm0_ch2_ds>;
+	pinctrl-6 = <&pinctrl_pwm0_ch3_en>;
+	pinctrl-7 = <&pinctrl_pwm0_ch3_ds>;
+	fsl,pwm-clk-ps = <7>;
+	fsl,pwm-cpwm = <0>;
+	fsl,pwm-number = <4>;
+	fsl,pwm-channels = <0 1 2 3>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
