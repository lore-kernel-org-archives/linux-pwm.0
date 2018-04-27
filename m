From: "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
Date: Fri, 27 Apr 2018 15:59:56 -0700
Message-ID: <1524869998-2805-2-git-send-email-wesley@sifive.com>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524869998-2805-1-git-send-email-wesley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Wesley W. Terpstra" <wesley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

Document new PWM device tree bindings for SiFive SoCs.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 0000000..7cea20d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,28 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+
+Required properties:
+- compatible: should be "sifive,pwm0"
+- reg: physical base address and length of the controller's registers
+- clocks: The frequency the controller runs at
+- #pwm-cells: Should be 2.
+  The first cell is the PWM channel number
+  The second cell is the PWM polarity
+- sifive,approx-period: the driver will get as close to this period as it can
+- interrupts: one interrupt per PWM channel (currently unused in the driver)
+
+Examples:
+
+pwm:  pwm@10020000 {
+	compatible = "sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,approx-period = <1000000>;
+};
-- 
2.7.4
