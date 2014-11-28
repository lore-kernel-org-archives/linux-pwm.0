From: Naidu Tellapati <naidu.tellapati@gmail.com>
Subject: [PATCH v6 2/4] DT: pwm: Add binding document for IMG PWM DAC
Date: Fri, 28 Nov 2014 23:42:23 +0530
Message-ID: <1417198345-19633-3-git-send-email-Naidu.Tellapati@gmail.com>
References: <1417198345-19633-1-git-send-email-Naidu.Tellapati@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:57027 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbaK1SNC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Nov 2014 13:13:02 -0500
In-Reply-To: <1417198345-19633-1-git-send-email-Naidu.Tellapati@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, abrestic@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de, James.Hartley@imgtec.com, Ezequiel.Garcia@imgtec.com
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Arul.Ramasamy@imgtec.com, Sai.Masarapu@imgtec.com, Naidu Tellapati <Naidu.Tellapati@gmail.com>, Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Add binding document for IMG Pulse Width Modulator (PWM) DAC present on the
Pistachio SOC. The PWM DAC has four channels.

Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Signed-off-by: Sai Masarapu <Sai.Masarapu@imgtec.com>
Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
---
 Documentation/devicetree/bindings/pwm/img-pwm.txt |   24 +++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/img-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/img-pwm.txt b/Documentation/devicetree/bindings/pwm/img-pwm.txt
new file mode 100644
index 0000000..fade5f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/img-pwm.txt
@@ -0,0 +1,24 @@
+*Imagination Technologies PWM DAC driver
+
+Required properties:
+  - compatible: Should be "img,pistachio-pwm"
+  - reg: Should contain physical base address and length of pwm registers.
+  - clocks: Must contain an entry for each entry in clock-names.
+	See ../clock/clock-bindings.txt for details.
+  - clock-names: Must include the following entries.
+    - pwm: PWM operating clock.
+    - sys: PWM system interface clock.
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

