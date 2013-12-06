From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFCv2 endianess 3/4] ARM: dts: Enables FTM PWM device for Vybrid VF610 TOWER board.
Date: Fri, 6 Dec 2013 13:52:13 +0800
Message-ID: <1386309134-1822-4-git-send-email-Li.Xiubo@freescale.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:9981 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab3LFGnX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Dec 2013 01:43:23 -0500
In-Reply-To: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: r65073@freescale.com, thierry.reding@gmail.com, s.hauer@pengutronix.de, galak@codeaurora.org, grant.likely@linaro.org, matt.porter@linaro.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org

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


