From: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: pwm: add bindings doc for ZTE ZX PWM controller
Date: Thu, 27 Jul 2017 16:23:36 +0800
Message-ID: <1501143817-15843-2-git-send-email-shawnguo@kernel.org>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbdG0IY6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 27 Jul 2017 04:24:58 -0400
In-Reply-To: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

From: Shawn Guo <shawn.guo@linaro.org>

It adds bindings document for ZTE ZX PWM controller.  The device
has two clocks: PCLK and WCLK.  The PCLK is for register access, and
WCLK is the reference clock for calculating period and duty cycles.
Also, the device supports polarity configuration, so #pwm-cells should
be 3.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm-zx.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-zx.txt b/Documentation/devicetree/bindings/pwm/pwm-zx.txt
new file mode 100644
index 000000000000..a6bcc75c9164
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-zx.txt
@@ -0,0 +1,22 @@
+ZTE ZX PWM controller
+
+Required properties:
+ - compatible: Should be "zte,zx296718-pwm".
+ - reg: Physical base address and length of the controller's registers.
+ - clocks : The phandle and specifier referencing the controller's clocks.
+ - clock-names: "pclk" for PCLK, "wclk" for WCLK to the PWM controller.  The
+   PCLK is for register access, while WCLK is the reference clock for
+   calculating period and duty cycles.
+ - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+   the cells format.
+
+Example:
+
+	pwm: pwm@1439000 {
+		compatible = "zte,zx296718-pwm";
+		reg = <0x1439000 0x1000>;
+		clocks = <&lsp1crm LSP1_PWM_PCLK>,
+			 <&lsp1crm LSP1_PWM_WCLK>;
+		clock-names = "pclk", "wclk";
+		#pwm-cells = <3>;
+	};
-- 
1.9.1
