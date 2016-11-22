From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/7] add binding for stm32 multifunctions timer driver
Date: Tue, 22 Nov 2016 17:13:21 +0100
Message-ID: <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add bindings information for stm32 timer MFD

Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
new file mode 100644
index 0000000..3cefce1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
@@ -0,0 +1,53 @@
+STM32 multifunctions timer driver
+
+stm32 timer MFD allow to handle at the same time pwm and IIO timer devices
+
+Required parameters:
+- compatible: must be one of the follow value:
+	"st,stm32-mfd-timer1"
+	"st,stm32-mfd-timer2"
+	"st,stm32-mfd-timer3"
+	"st,stm32-mfd-timer4"
+	"st,stm32-mfd-timer5"
+	"st,stm32-mfd-timer6"
+	"st,stm32-mfd-timer7"
+	"st,stm32-mfd-timer8"
+	"st,stm32-mfd-timer9"
+	"st,stm32-mfd-timer10"
+	"st,stm32-mfd-timer11"
+	"st,stm32-mfd-timer12"
+	"st,stm32-mfd-timer13"
+	"st,stm32-mfd-timer14"
+
+- reg :			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "mfd_timer_clk".
+- clocks: 		Phandle of the clock used by the timer module.
+			For Clk properties, please refer to [1].
+- interrupts :		Reference to the timer interrupt
+
+Optional parameters:
+- resets :		Reference to a reset controller asserting the timer
+
+Optional subnodes:
+- pwm:			See Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+- iiotimer:		See Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
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
+
+		iiotimer1: iiotimer1@40010000 {
+			compatible = "st,stm32-iio-timer1";
+		};
+	};
-- 
1.9.1
