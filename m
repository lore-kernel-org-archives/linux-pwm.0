From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v7 1/5] Documentation: bindings: document the Berlin PWM driver
Date: Fri,  2 Oct 2015 16:59:46 +0200
Message-ID: <1443797990-10809-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Following the addition of a Berlin PWM driver, this patch adds the
corresponding documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-berlin.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-berlin.txt b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
new file mode 100644
index 000000000000..82cbe16fcbbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-berlin.txt
@@ -0,0 +1,17 @@
+Berlin PWM controller
+
+Required properties:
+- compatible: should be "marvell,berlin-pwm"
+- reg: physical base address and length of the controller's registers
+- clocks: phandle to the input clock
+- #pwm-cells: should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+
+pwm: pwm@f7f20000 {
+	compatible = "marvell,berlin-pwm";
+	reg = <0xf7f20000 0x40>;
+	clocks = <&chip_clk CLKID_CFG>;
+	#pwm-cells = <3>;
+}
-- 
2.6.0
