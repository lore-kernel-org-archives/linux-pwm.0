From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv4 3/3] pwm: documentation: Add 'big-endian' property for FTM PWM.
Date: Tue, 19 Aug 2014 12:38:03 +0800
Message-ID: <1408423083-19827-4-git-send-email-Li.Xiubo@freescale.com>
References: <1408423083-19827-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:13065
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752600AbaHSEmm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 19 Aug 2014 00:42:42 -0400
In-Reply-To: <1408423083-19827-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, rdunlap@infradead.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, Xiubo Li <Li.Xiubo@freescale.com>

For the same FTM PWM device, which on different SoCs will in
differrent endian mode, using the same device driver need
one boolean properties to distingush this.

For now the FTM PWM is only applied to the ARM SoCs which are all
in LE mode.

The FTM PWM device can be integrated as little-endian or big-endian.
This endianness differs per SoC:
SoC     | FTM-PWM endianness
--------+-------------------
Vybrid  | LE
LS1     | BE
LS2     | LE

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
index 0bda229..49eedf4 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
@@ -1,5 +1,24 @@
 Freescale FlexTimer Module (FTM) PWM controller
 
+For the same FTM PWM device, which on different SoCs will in
+differrent endian mode, using the same device driver need
+one boolean properties to distingush this.
+
+For now the FTM PWM is only applied to the ARM SoCs which are all
+in LE mode.
+
+The FTM PWM device can be integrated as little-endian or big-endian.
+This endianness differs per SoC:
+SoC     | FTM-PWM endianness
+--------+-------------------
+Vybrid  | LE
+LS1     | BE
+LS2     | LE
+
+Please see "Documentation/devicetree/bindings/regmap/regmap.txt" for more
+detail about the endianness.
+
+
 Required properties:
 - compatible: Should be "fsl,vf610-ftm-pwm".
 - reg: Physical base address and length of the controller's registers
@@ -16,7 +35,8 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
+- big-endian: Boolean property, required if all the FTM_PWM registers
+  are big-endian rather than little-endian.
 
 Example:
 
@@ -32,4 +52,5 @@ pwm0: pwm@40038000 {
 			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pwm0_1>;
+		big-endian;
 };
-- 
1.8.5

