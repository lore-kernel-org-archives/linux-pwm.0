From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 1/2] pwm: Add device tree binding document for R-Car PWM Timer
Date: Wed, 13 May 2015 18:27:17 +0900
Message-ID: <1431509238-7648-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1431509238-7648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:9025 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933632AbbEMJ1i (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 May 2015 05:27:38 -0400
In-Reply-To: <1431509238-7648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add binding document for Renesas PWM Timer on R-Car SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
new file mode 100644
index 0000000..38123f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -0,0 +1,21 @@
+* Renesas R-Car PWM Timer Controller
+
+Required Properties:
+- compatible: must contain "renesas,pwm-rcar"
+- reg: base address and length of the registers block for the PWM
+- #pwm-cells: should be 7. See pwm.txt in this directory for a description of
+  the cells format.
+- clocks: clock phandle and specifier pair.
+- pinctrl-0: phandle, referring to a default pin configuration node.
+- pinctrl-names: Set to "default"
+
+Example: R8A7790 (R-Car H2) PWM Timer node
+
+	pwm: pwm@e6e30000 {
+		compatible = "renesas,pwm-rcar";
+		reg = <0 0xe6e30000 0 0x7000>;
+		#pwm-cells = <7>;
+		clocks = <&mstp5_clks R8A7790_CLK_PWM>;
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1
