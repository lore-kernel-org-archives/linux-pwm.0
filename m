From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFCv2 endianess 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
Date: Fri, 6 Dec 2013 13:52:12 +0800
Message-ID: <1386309134-1822-3-git-send-email-Li.Xiubo@freescale.com>
References: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:59559
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab3LFGnP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Dec 2013 01:43:15 -0500
In-Reply-To: <1386309134-1822-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: r65073@freescale.com, thierry.reding@gmail.com, s.hauer@pengutronix.de, galak@codeaurora.org, grant.likely@linaro.org, matt.porter@linaro.org, tomasz.figa@gmail.com, swarren@wwwdotorg.org, mark.rutland@arm.com
Cc: linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org

This adds devicetree node for VF610, and there are 8 channels
supported.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/vf610.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 67d929c..24aad55 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -140,6 +140,17 @@
 				clock-names = "pit";
 			};
 
+			pwm0: pwm@40038000 {
+				compatible = "fsl,vf610-ftm-pwm";
+				#pwm-cells = <3>;
+				reg = <0x40038000 0x1000>;
+				clock-names = "ftm_sys", "ftm_ext", "ftm_fix";
+				clocks = <&clks VF610_CLK_FTM0>,
+					<&clks VF610_CLK_FTM0_EXT_SEL>,
+					<&clks VF610_CLK_FTM0_FIX_SEL>;
+				status = "disabled";
+			};
+
 			wdog@4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
-- 
1.8.4


