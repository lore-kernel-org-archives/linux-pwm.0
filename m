From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv7 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER board.
Date: Fri, 13 Dec 2013 16:57:06 +0800
Message-ID: <1386925027-16288-4-git-send-email-Li.Xiubo@freescale.com>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: mark.rutland@arm.com, s.hauer@pengutronix.de, galak@codeaurora.org, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, matt.porter@linaro.org, linux@arm.linux.org.uk, rob@landley.net, tomasz.figa@gmail.com, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/vf610-twr.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 82d352f..3130f85 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -83,6 +83,12 @@
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
