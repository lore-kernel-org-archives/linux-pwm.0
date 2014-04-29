From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 1/4] Documentation: Add 'big-endian' property for FTM PWM.
Date: Tue, 29 Apr 2014 11:33:46 +0800
Message-ID: <1398742429-10399-2-git-send-email-Li.Xiubo@freescale.com>
References: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:30952
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754294AbaD2ESV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 29 Apr 2014 00:18:21 -0400
In-Reply-To: <1398742429-10399-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

This add the big endianness usage in the binding docuementation, which
will run on LS1 SoC.

Now for the following scenarios:
SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
--------|--------|---------|---------------------------------
Vybird  |  LE    |   LE    |     No
LS1     |  LE    |   BE    |     Yes
LS2     |  LE    |   LE    |     No

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 0bda229..346e2eb 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -1,5 +1,13 @@
 Freescale FlexTimer Module (FTM) PWM controller
 
+The endianness of the FTM PWM devices on different SoCs:
+SoC     |  CPU   | FTM-PWM | 'big-endian' property is needed?
+--------|--------|---------|---------------------------------
+Vybird  |  LE    |   LE    |     No
+LS1     |  LE    |   BE    |     Yes
+LS2     |  LE    |   LE    |     No
+
+
 Required properties:
 - compatible: Should be "fsl,vf610-ftm-pwm".
 - reg: Physical base address and length of the controller's registers
@@ -16,7 +24,8 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
+- big-endian: One boolean property, for all the device registers, the BE mode
+  will be in use if it's present, or the LE mode will be in use.
 
 Example:
 
@@ -32,4 +41,5 @@ pwm0: pwm@40038000 {
 			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pwm0_1>;
+		big-endian;
 };
-- 
1.8.4

