From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] Documentation: dt: add Broadcom BCM7038 PWM controller binding
Date: Thu,  6 Aug 2015 17:55:57 -0700
Message-ID: <1438908959-1578-2-git-send-email-f.fainelli@gmail.com>
References: <1438908959-1578-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438908959-1578-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Add a binding documentation for the Broadcom BCM7038 PWM controller found in
BCM7xxx chips.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
new file mode 100644
index 000000000000..8b9bc43b561e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
@@ -0,0 +1,22 @@
+Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
+
+Required properties:
+
+- compatible: must be "brcm,bcm7038-pwm"
+- reg: physical base address and length for this controller
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description
+  of the cells format.
+
+Optional properties:
+
+- clocks: a phandle to the reference clock for this block which is fed through
+  its internal variable clock frequency generator
+
+Example:
+
+	pwm: pwm@f0408000 {
+		compatible = "brcm,bcm7038-pwm";
+		reg = <0xf0408000 0x28>;
+		#pwm-cells = <2>;
+		clocks = <&upg_fixed>;
+	};
-- 
2.1.0
