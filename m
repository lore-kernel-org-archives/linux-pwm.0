Return-Path: <B47053@freescale.com>
From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER board.
Date: Fri, 6 Sep 2013 16:08:26 +0800
Message-ID: <1378454907-22728-4-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: r65073@freescale.com, thierry.reding@gmail.com
Cc: grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

Selecting system clock as the counter source clock by default.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 1a58678..c742275 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -57,6 +57,11 @@
 	status = "okay";
 };
 
+&pwm0 {
+	fsl,pwm-counter-clk = "ftm0";
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.0
