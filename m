From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v4 1/2] Documentation: dt: add Broadcom BCM7038 PWM controller binding
Date: Mon, 14 Sep 2015 16:47:05 -0700
Message-ID: <1442274426-3507-2-git-send-email-f.fainelli@gmail.com>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35406 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbINXux (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2015 19:50:53 -0400
In-Reply-To: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, ariel@vanguardiasur.com.ar

Add a binding documentation for the Broadcom BCM7038 PWM controller found in
BCM7xxx chips.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- list 'clocks' property as mandatory

 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.txt     | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
new file mode 100644
index 000000000000..d9254a6da5ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.txt
@@ -0,0 +1,20 @@
+Broadcom BCM7038 PWM controller (BCM7xxx Set Top Box PWM controller)
+
+Required properties:
+
+- compatible: must be "brcm,bcm7038-pwm"
+- reg: physical base address and length for this controller
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description
+  of the cells format
+- clocks: a phandle to the reference clock for this block which is fed through
+  its internal variable clock frequency generator
+
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
