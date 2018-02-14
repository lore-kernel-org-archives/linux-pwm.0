From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: [RESEND PATCH v2 3/8] dt-bindings: mfd: stm32-timers: add support for dmas
Date: Wed, 14 Feb 2018 11:04:34 +0100
Message-ID: <1518602679-3064-4-git-send-email-fabrice.gasnier@st.com>
References: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518602679-3064-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
Cc: benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
dma requests: up to 4 channels, update, compare and trigger.
DMAs may be used to transfer data from pwm capture for instance.
DMA support is made optional, PWM capture support is also an option.
This is much more wise system-wide to avoid shortage on DMA request
lines as there's significant amount of timer instances that can
request up to 7 channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 1db6e00..0e900b5 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -19,6 +19,11 @@ Required parameters:
 Optional parameters:
 - resets:		Phandle to the parent reset controller.
 			See ../reset/st,stm32-rcc.txt
+- dmas:			List of phandle to dma channels that can be used for
+			this timer instance. There may be up to 7 dma channels.
+- dma-names:		List of dma names. Must match 'dmas' property. Valid
+			names are: "ch1", "ch2", "ch3", "ch4", "up", "trig",
+			"com".
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
@@ -44,3 +49,18 @@ Example:
 			reg = <0>;
 		};
 	};
+
+Example with all dmas:
+	timer@40010000 {
+		...
+		dmas = <&dmamux1 11 0x400 0x0>,
+		       <&dmamux1 12 0x400 0x0>,
+		       <&dmamux1 13 0x400 0x0>,
+		       <&dmamux1 14 0x400 0x0>,
+		       <&dmamux1 15 0x400 0x0>,
+		       <&dmamux1 16 0x400 0x0>,
+		       <&dmamux1 17 0x400 0x0>;
+		dma-names = "ch1", "ch2", "ch3", "ch4", "up", "trig", "com";
+		...
+		child nodes...
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
