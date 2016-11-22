From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/7] add pwm-stm32 DT bindings
Date: Tue, 22 Nov 2016 17:13:23 +0100
Message-ID: <1479831207-32699-4-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Define binding for pwm-stm32

Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/pwm/pwm-stm32.txt          | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
new file mode 100644
index 0000000..819e024
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
@@ -0,0 +1,43 @@
+STMicroelectronics PWM driver bindings for STM32
+--------------------------------------
+
+Must be a child of STM32 multifunctions timer driver
+
+Required parameters:
+- compatible :		"st,stm32-pwm1"
+			"st,stm32-pwm2"
+			"st,stm32-pwm3"
+			"st,stm32-pwm4"
+			"st,stm32-pwm5"
+			"st,stm32-pwm8"
+			"st,stm32-pwm9"
+			"st,stm32-pwm10"
+			"st,stm32-pwm11"
+			"st,stm32-pwm12"
+			"st,stm32-pwm13"
+			"st,stm32-pwm14"
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes
+			for PWM module.
+			For Pinctrl properties, please refer to [1].
+
+Optional parameters:
+- st,breakinput-polarity if set enable break input feature.
+			 The value define the active polarity:
+			  - 0 (active LOW)
+			  - 1 (active HIGH)
+
+[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+Example:
+	mfd_timer1: mfdtimer1@40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		pwm1: pwm1@40010000 {
+			compatible = "st,stm32-pwm1";
+		};
+	};
-- 
1.9.1
