From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv9 Resend 3/4] ARM: dts: vf610-twr: Enables FTM PWM device.
Date: Wed, 19 Feb 2014 16:38:56 +0800
Message-ID: <1392799137-17188-4-git-send-email-Li.Xiubo@freescale.com>
References: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392799137-17188-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Yuan Yao <yao.yuan@freescale.com>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index c3a3237..d5c6a39 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -100,6 +100,12 @@
 	status = "okay";
 };
 
+&pwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_1>;
-- 
1.8.4
