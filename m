Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER board.
Date: Fri, 13 Sep 2013 13:58:41 +0800
Message-ID: <1379051922-4930-4-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
References: <1379051922-4930-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: s.hauer@pengutronix.de, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Selecting system clock as the counter source clock by default.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..27cbe91 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -57,6 +57,31 @@
 	status = "okay";
 };
 
+&pwm0 {
+	fsl,pwm-counter-clk = "ftm0";
+	pinctrl-names = "ch0-active", "ch0-idle", "ch1-active", "ch1-idle",
+			"ch2-active", "ch2-idle", "ch3-active", "ch3-idle",
+			"ch4-active", "ch4-idle", "ch5-active", "ch5-idle",
+			"ch6-active", "ch6-idle", "ch7-active", "ch7-idle";
+	pinctrl-0 = <&pinctrl_pwm0_ch0_active>;
+	pinctrl-1 = <&pinctrl_pwm0_ch0_idle>;
+	pinctrl-2 = <&pinctrl_pwm0_ch1_active>;
+	pinctrl-3 = <&pinctrl_pwm0_ch1_idle>;
+	pinctrl-4 = <&pinctrl_pwm0_ch2_active>;
+	pinctrl-5 = <&pinctrl_pwm0_ch2_idle>;
+	pinctrl-6 = <&pinctrl_pwm0_ch3_active>;
+	pinctrl-7 = <&pinctrl_pwm0_ch3_idle>;
+	pinctrl-8 = <&pinctrl_pwm0_ch4_active>;
+	pinctrl-9 = <&pinctrl_pwm0_ch4_idle>;
+	pinctrl-10 = <&pinctrl_pwm0_ch5_active>;
+	pinctrl-11 = <&pinctrl_pwm0_ch5_idle>;
+	pinctrl-12 = <&pinctrl_pwm0_ch6_active>;
+	pinctrl-13 = <&pinctrl_pwm0_ch6_idle>;
+	pinctrl-14 = <&pinctrl_pwm0_ch7_active>;
+	pinctrl-15 = <&pinctrl_pwm0_ch7_idle>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
