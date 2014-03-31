From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/4] ARM: sun7i: dt: add PWM support
Date: Mon, 31 Mar 2014 14:07:28 +0200
Message-ID: <1396267649-18009-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Adds the PWM bindings for the Allwinner A20.
Also adds the pinctrl descriptions for both PWM channels.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6f25cf559ad0..0dd15fcb8955 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -366,6 +366,20 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			pwm0_pins_a: pwm0@0 {
+				allwinner,pins = "PB2";
+				allwinner,function = "pwm";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			pwm1_pins_a: pwm1@0 {
+				allwinner,pins = "PI3";
+				allwinner,function = "pwm";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart0_pins_a: uart0@0 {
 				allwinner,pins = "PB22", "PB23";
 				allwinner,function = "uart0";
@@ -446,6 +460,14 @@
 			clocks = <&osc24M>;
 		};
 
+		pwm: pwm@01c20e00 {
+			compatible = "allwinner,sun7i-pwm";
+			reg = <0x01c20e00 0xc>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		wdt: watchdog@01c20c90 {
 			compatible = "allwinner,sun4i-wdt";
 			reg = <0x01c20c90 0x10>;
-- 
1.8.3.2
