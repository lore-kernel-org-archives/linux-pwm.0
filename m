From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] pwm: add DT bindings for the STMPE PWM
Date: Wed, 10 Feb 2016 09:54:26 +0100
Message-ID: <1455094468-25521-2-git-send-email-linus.walleij@linaro.org>
References: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33836 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbcBJIyp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2016 03:54:45 -0500
Received: by mail-lf0-f46.google.com with SMTP id j78so7383512lfb.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Feb 2016 00:54:44 -0800 (PST)
In-Reply-To: <1455094468-25521-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org

This adds fairly standard device tree bindings for the STMPE
PWM found in STMPE24xx multi-purpose expanders.

Cc: devicetree@vger.kernel.org
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
