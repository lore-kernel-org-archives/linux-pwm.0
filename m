From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv3 7/7] ARM: sunxi: dt: add PWM support for the cubietruck
Date: Mon, 28 Apr 2014 18:17:14 +0200
Message-ID: <1398701834-3719-8-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398701834-3719-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398701834-3719-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Enable the PWM for both PWM channels on the cubietruck. They can be found on
connector CN8.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index cb25d3c8da58..0c3bd127a5fd 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -63,6 +63,12 @@
 			};
 		};
 
+		pwm: pwm@01c20e00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pwm0_pins_a>, <&pwm1_pins_a>;
+			status = "okay";
+		};
+
 		uart0: serial@01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
-- 
1.9.1

