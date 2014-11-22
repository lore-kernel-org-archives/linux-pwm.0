From: naidu.tellapati@gmail.com
Subject: [PATCH RESEND v4 2/4] DT: pwm: Add binding document for IMG PWM DAC
Date: Sat, 22 Nov 2014 07:23:30 +0530
Message-ID: <1416621212-11701-3-git-send-email-Naidu.Tellapati@gmail.com>
References: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59673 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbaKVByM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Nov 2014 20:54:12 -0500
In-Reply-To: <1416621212-11701-1-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Add binding document for IMG Pulse Width Modulator (PWM) DAC present on the
Pistachio SOC. The PWM DAC has four channels.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
No changes from v3.
---
 Documentation/devicetree/bindings/pwm/img-pwm.txt |   23 +++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Documentation/devicetree/bindings/pwm/img-pwm.txt
new file mode 100644
index 0000000..d3828dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
@@ -0,0 +1,23 @@
+*Imagination Technologies PWM DAC driver
+
+Required properties:
+  - compatible: Should be "img,pistachio-pwm"
+  - reg: Should contain physical base address and length of pwm registers.
+  - clocks: Must contain an entry for each entry in clock-names.
+	See ../clock/clock-bindings.txt for details.
+  - clock-names: input clock names.
+	Required elements: "pwm" and "sys".
+  - #pwm-cells: Should be 2. See pwm.txt in this directory for the
+	description of the cells format.
+  - img,cr-periph: Must contain a phandle to the peripheral control
+	syscon node which contains PWM control registers.
+
+Example:
+	pwm: pwm@18101300 {
+		compatible = "img,pistachio-pwm";
+		reg = <0x18101300 0x100>;
+		clocks = <&pwm_clk>, <&system_clk>;
+		clock-names = "pwm", "sys";
+		#pwm-cells = <2>;
+		img,cr-periph = <&cr_periph>;
+	};
-- 
1.7.0.4

