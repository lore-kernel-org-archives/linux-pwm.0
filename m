From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 3/3] pwm: documentation: Add 'big-endian' property for FTM PWM.
Date: Mon, 18 Aug 2014 11:32:35 +0800
Message-ID: <1408332755-35102-4-git-send-email-Li.Xiubo@freescale.com>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from [207.46.163.139] ([207.46.163.139]:3484 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751671AbaHRDhZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 17 Aug 2014 23:37:25 -0400
In-Reply-To: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, rdunlap@infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

For the same FTM PWM device, which on different SoCs will in
differrent endian mode, using the same linux device driver need
one boolean properties to distingush this.

For now the FTM PWM is only applied to the ARM SoCs which are all
in LE mode.

So the DT binding for FTM PWM device endian:
SoC     |  FTM-PWM | 'big-endian' property is needed?
--------|----------|---------------------------------
Vybird  |    LE    |     No
LS1     |    BE    |     Yes
LS2     |    LE    |     No

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 0bda229..67ed8d6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -1,5 +1,23 @@
 Freescale FlexTimer Module (FTM) PWM controller
 
+For the same FTM PWM device, which on different SoCs will in
+differrent endian mode, using the same linux device driver need
+one boolean properties to distingush this.
+
+For now the FTM PWM is only applied to the ARM SoCs which are all
+in LE mode.
+
+So the DT binding for FTM PWM device endian:
+SoC     |  FTM-PWM | 'big-endian' property is needed?
+--------|----------|---------------------------------
+Vybird  |    LE    |     No
+LS1     |    BE    |     Yes
+LS2     |    LE    |     No
+
+Please see "Documentation/devicetree/bindings/regmap/regmap.txt" for more
+detail about the endianness.
+
+
 Required properties:
 - compatible: Should be "fsl,vf610-ftm-pwm".
 - reg: Physical base address and length of the controller's registers
@@ -16,7 +34,8 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
+- big-endian: One boolean property, for all the device registers, the BE mode
+  will be in use if it's present, or the LE mode will be in use.
 
 Example:
 
@@ -32,4 +51,5 @@ pwm0: pwm@40038000 {
 			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pwm0_1>;
+		big-endian;
 };
-- 
1.8.5

