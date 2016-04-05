From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2 v2] pwm: add DT bindings for the STMPE PWM
Date: Tue,  5 Apr 2016 23:22:29 +0200
Message-ID: <1459891349-28305-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36220 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbcDEVW7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Apr 2016 17:22:59 -0400
Received: by mail-lf0-f50.google.com with SMTP id g184so20066868lfb.3
        for <linux-pwm@vger.kernel.org>; Tue, 05 Apr 2016 14:22:39 -0700 (PDT)
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
ChangeLog v1->v2:
- Give a simpler, non-contextual node name for the PWM.
---
 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt b/Documentation/devicetree/bindings/pwm/st,stmpe-pwm.txt
new file mode 100644
index 000000000000..cb209646bf13
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
+pwm0: pwm {
+	compatible = "st,stmpe-pwm";
+	#pwm-cells = <2>;
+};
-- 
2.4.11
