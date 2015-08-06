From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: [PATCH v2 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Wed,  5 Aug 2015 23:31:47 -0300
Message-ID: <1438828307-14641-3-git-send-email-ariel@vanguardiasur.com.ar>
References: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:32934 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbbHFCcG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Aug 2015 22:32:06 -0400
Received: by qged69 with SMTP id d69so44245258qge.0
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2015 19:32:05 -0700 (PDT)
In-Reply-To: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, manabian@gmail.com, ezequiel@vanguardiasur.com.ar, thierry.reding@gmail.com, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Add the devicetree binding document for NXP LPC18xx PWM/SCT.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
new file mode 100644
index 0000000..36e49d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.txt
@@ -0,0 +1,20 @@
+* NXP LPC18xx State Configurable Timer - Pulse Width Modulator driver
+
+Required properties:
+  - compatible: Should be "nxp,lpc1850-sct-pwm"
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
+    compatible = "nxp,lpc1850-sct-pwm";
+    reg = <0x40000000 0x1000>;
+    clocks =<&ccu1 CLK_CPU_SCT>;
+    clock-names = "pwm";
+    #pwm-cells = <3>;
+  };
-- 
1.9.1
