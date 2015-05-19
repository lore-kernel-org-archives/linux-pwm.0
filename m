From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/2] pwm: Add device tree binding document for R-Car PWM Timer
Date: Tue, 19 May 2015 19:42:38 +0900
Message-ID: <1432032159-704-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pwm@vger.kernel.org

Add binding document for Renesas PWM Timer on R-Car SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
new file mode 100644
index 0000000..0e6e0cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -0,0 +1,26 @@
+* Renesas R-Car PWM Timer Controller
+
+Required Properties:
+- compatible: should be one of the following.
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
+		compatible = "renesas,pwm-r8a7790";
+		reg = <0 0xe6e30000 0 0x10>;
+		#pwm-cells = <2>;
+		clocks = <&mstp5_clks R8A7790_CLK_PWM>;
+		pinctrl-0 = <&pwm0_pins>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1

