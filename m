From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Mon, 27 Jul 2015 01:45:45 -0300
Message-ID: <1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34352 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbG0Eq0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2015 00:46:26 -0400
Received: by qgeu79 with SMTP id u79so44619645qge.1
        for <linux-pwm@vger.kernel.org>; Sun, 26 Jul 2015 21:46:25 -0700 (PDT)
In-Reply-To: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, manabian@gmail.com, ezequiel@vanguardiasur.com.ar, thierry.reding@gmail.com, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Add the devicetree binding document for NXP LPC18xx PWM/SCT.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
new file mode 100644
index 0000000..3055429
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
@@ -0,0 +1,20 @@
+* NXP LPC18xx Pulse Width Modulator driver
+
+Required properties:
+  - compatible: Should be "nxp,lpc1850-pwm"
+  - reg: Should contain physical base address and length of pwm registers.
+  - clocks: Must contain an entry for each entry in clock-names.
+    See ../clock/clock-bindings.txt for details.
+  - clock-names: Must include the following entries.
+    - pwm: PWM operating clock.
+  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
+    of the cells format.
+
+Example:
+  pwm: pwm@40000000 {
+    compatible = "nxp,lpc1850-pwm";
+    reg = <0x40000000 0x580>;
+    clocks =<&ccu1 CLK_CPU_SCT>;
+    clock-names = "pwm";
+    #pwm-cells = <3>;
+  };
-- 
1.9.1
