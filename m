From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] pwm: add DT bindings for the STMPE PWM
Date: Sun, 14 Feb 2016 14:08:37 +0100
Message-ID: <1455455317-17043-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34421 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbcBNNIm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Feb 2016 08:08:42 -0500
Received: by mail-lb0-f179.google.com with SMTP id ap4so8155902lbd.1
        for <linux-pwm@vger.kernel.org>; Sun, 14 Feb 2016 05:08:42 -0800 (PST)
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

This adds fairly standard device tree bindings for the STMPE
PWM found in STMPE24xx multi-purpose expanders.

Cc: devicetree@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
new file mode 100644
index 000000000000..c8b53f39ae31
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
@@ -0,0 +1,18 @@
+== ST STMPE PWM controller ==
+
+This is a PWM block embedded in the ST Microelectronics STMPE
+(ST Multi-Purpose Expander) chips. The PWM is registered as a
+subdevices of the STMPE MFD device.
+
+Required properties:
+- compatible: should be:
+  - "st,stmpe-pwm"
+- #pwm-cells: should be 2. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+
+stmpe1_pwm0: stmpe_pwm {
+	compatible = "st,stmpe-pwm";
+	#pwm-cells = <2>;
+};
-- 
2.4.3
