From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v6 1/2] pwm: Add device tree binding document for R-Car PWM Timer
Date: Wed, 19 Aug 2015 13:13:58 +0900
Message-ID: <1439957639-4816-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:28628 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750888AbbHSEOO (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 00:14:14 -0400
In-Reply-To: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add binding document for Renesas PWM Timer on R-Car SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
new file mode 100644
index 0000000..ea0a27b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -0,0 +1,27 @@
+* Renesas R-Car PWM Timer Controller
+
+Required Properties:
+- compatible: should be one of the following.
+ - "renesas,pwm-rcar": for generic R-Car compatible PWM Timer
+ - "renesas,pwm-r8a7778": for R-Car M1A
+ - "renesas,pwm-r8a7779": for R-Car H1
+ - "renesas,pwm-r8a7790": for R-Car H2
+ - "renesas,pwm-r8a7791": for R-Car M2-W
+ - "renesas,pwm-r8a7794": for R-Car E2
+- reg: base address and length of the registers block for the PWM.
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+- clocks: clock phandle and specifier pair.
+- pinctrl-0: phandle, referring to a default pin configuration node.
+- pinctrl-names: Set to "default".
+
+Example: R8A7790 (R-Car H2) PWM Timer node
+
+	pwm0: pwm@e6e30000 {
+		compatible = "renesas,pwm-r8a7790", "renesas,pwm-rcar";
+		reg = <0 0xe6e30000 0 0x8>;
+		#pwm-cells = <2>;
+		clocks = <&mstp5_clks R8A7790_CLK_PWM>;
+		pinctrl-0 = <&pwm0_pins>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1
