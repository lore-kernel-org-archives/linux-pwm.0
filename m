From: Atish Patra <atish.patra@wdc.com>
Subject: [RFC 3/4] gpio: sifive: Add DT documentation for SiFive GPIO.
Date: Tue,  9 Oct 2018 11:51:24 -0700
Message-ID: <1539111085-25502-4-git-send-email-atish.patra@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org, atish.patra@wdc.com
List-Id: linux-pwm@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

DT documentation for GPIO added with updated compatible
string.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/gpio/gpio-sifive.txt       | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-sifive.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-sifive.txt b/Documentation/devicetree/bindings/gpio/gpio-sifive.txt
new file mode 100644
index 00000000..781fe4ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-sifive.txt
@@ -0,0 +1,28 @@
+SiFive GPIO controller bindings
+
+Required properties:
+- compatible: should be one of
+  	 "sifive,fu540-c000-gpio0","sifive,gpio0"
+- reg: Physical base address and length of the controller's registers.
+- #gpio-cells : Should be 2
+  - The first cell is the GPIO offset number.
+  - The second cell indicates the polarity of the GPIO
+- gpio-controller : Marks the device node as a GPIO controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells : Should be 2.
+  - The first cell is the GPIO offset number within the GPIO controller.
+  - The second cell is the edge/level to use for interrupt generation.
+- interrupts: Specify the interrupts, one per GPIO
+
+Example:
+
+gpio: gpio@10060000 {
+	compatible = "sifive,fu540-c000-gpio0","sifive,gpio0";
+	interrupt-parent = <&plic>;
+	interrupts = <7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22>;
+	reg = <0x0 0x10060000 0x0 0x1000>;
+	gpio-controller;
+	#gpio-cells = <2>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
-- 
2.7.4
