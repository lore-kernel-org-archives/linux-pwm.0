From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/4] dts: sunxi: A64: Add PWM controllers
Date: Sun, 18 Mar 2018 23:28:47 +0000
Message-ID: <20180318232847.14278-5-andre.przywara@arm.com>
References: <20180318232847.14278-1-andre.przywara@arm.com>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBRPMXPKQKGQEXXEQ6CA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180318232847.14278-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

The Allwinner A64 SoC features two PWM controllers, which are fully
compatible to the one used in the A13 and H3 chips.
Add the respective device nodes (one for the "normal" PWM, the other for
the one in the CPUS domain) and the pin their output is connected to.
On the A64 the "normal" PWM is muxed together with one of the MDIO pins
used to communicate with the Ethernet PHY, so it won't be usable on many
boards. But the Pinebook laptop uses this pin for controlling the LCD
backlight.
The CPUS PWM pin however is routed to the "RPi2" header, at the same
location as the PWM pin on the RaspberryPi.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d783d164b9c3..fda1783b1c86 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -321,6 +321,11 @@
 				bias-pull-up;
 			};
 
+			pwm_pin: pwm_pin {
+				pins = "PD22";
+				function = "pwm";
+			};
+
 			rmii_pins: rmii_pins {
 				pins = "PD10", "PD11", "PD13", "PD14", "PD17",
 				       "PD18", "PD19", "PD20", "PD22", "PD23";
@@ -537,6 +542,15 @@
 			#interrupt-cells = <3>;
 		};
 
+		pwm: pwm@1c21400 {
+			compatible = "allwinner,sun50i-a64-pwm",
+				     "allwinner,sun5i-a13-pwm";
+			reg = <0x01c21400 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
@@ -563,6 +577,15 @@
 			#reset-cells = <1>;
 		};
 
+		r_pwm: pwm@1f03800 {
+			compatible = "allwinner,sun50i-a64-pwm",
+				     "allwinner,sun5i-a13-pwm";
+			reg = <0x01f03800 0x400>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
@@ -578,6 +601,11 @@
 				pins = "PL0", "PL1";
 				function = "s_rsb";
 			};
+
+			r_pwm_pin: pwm {
+				pins = "PL10";
+				function = "s_pwm";
+			};
 		};
 
 		r_rsb: rsb@1f03400 {
-- 
2.14.1
