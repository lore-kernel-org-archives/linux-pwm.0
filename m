From: Atish Patra <atish.patra@wdc.com>
Subject: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM Controller.
Date: Tue,  9 Oct 2018 11:51:22 -0700
Message-ID: <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: palmer@sifive.com, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, hch@infradead.org, atish.patra@wdc.com
List-Id: linux-pwm@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

DT documentation for PWM controller added with updated compatible
string.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Compatible string update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 .../devicetree/bindings/pwm/pwm-sifive.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
new file mode 100644
index 00000000..532b10fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
@@ -0,0 +1,32 @@
+SiFive PWM controller
+
+Unlike most other PWM controllers, the SiFive PWM controller currently only
+supports one period for all channels in the PWM. This is set globally in DTS.
+The period also has significant restrictions on the values it can achieve,
+which the driver rounds to the nearest achievable frequency.
+
+Required properties:
+- compatible: should be one of
+	"sifive,fu540-c000-pwm0","sifive,pwm0".
+	PWM controller is HiFive Unleashed specific chip which warrants a
+	specific compatible string. The second string is kept for backward
+	compatibility until a firmware update with latest compatible string.
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
+	compatible = "sifive,fu540-c000-pwm0","sifive,pwm0";
+	reg = <0x0 0x10020000 0x0 0x1000>;
+	clocks = <&tlclk>;
+	interrupt-parent = <&plic>;
+	interrupts = <42 43 44 45>;
+	#pwm-cells = <2>;
+	sifive,approx-period = <1000000>;
+};
-- 
2.7.4
