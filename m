From: Tim Kryger <tim.kryger@linaro.org>
Subject: [PATCH v6 1/5] Documentation: dt: Add Kona PWM binding
Date: Fri, 18 Apr 2014 09:44:50 -0700
Message-ID: <1397839494-21049-2-git-send-email-tim.kryger@linaro.org>
References: <1397839494-21049-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397839494-21049-1-git-send-email-tim.kryger@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Matt Porter <mporter@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Christian Daudt <bcm@fixthebug.org>, Grant Likely <grant.likely@linaro.org>
Cc: Tim Kryger <tim.kryger@linaro.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, Linux Doc List <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Add the binding description for the Kona PWM controller found on Broadcom's
mobile SoCs.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 .../devicetree/bindings/pwm/bcm-kona-pwm.txt       |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
new file mode 100644
index 0000000..8eae9fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/bcm-kona-pwm.txt
@@ -0,0 +1,21 @@
+Broadcom Kona PWM controller device tree bindings
+
+This controller has 6 channels.
+
+Required Properties :
+- compatible: should contain "brcm,kona-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle + clock specifier pair for the external clock
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a
+  description of the cells format.
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
+
+Example:
+
+pwm: pwm@3e01a000 {
+	compatible = "brcm,bcm11351-pwm", "brcm,kona-pwm";
+	reg = <0x3e01a000 0xc4>;
+	clocks = <&pwm_clk>;
+	#pwm-cells = <3>;
+};
-- 
1.7.9.5

