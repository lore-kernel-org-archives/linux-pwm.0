From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 3/8] dt-bindings: mfd: stm32-timers: add support for dmas
Date: Tue, 16 Jan 2018 13:43:46 +0100
Message-ID: <1516106631-18722-4-git-send-email-fabrice.gasnier@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, benjamin.gaignard@linaro.org
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
dma requests: up to 4 channels, update, compare and trigger.
DMAs may be used to transfer data from pwm capture for instance.
DMA support is made optional, PWM capture support is also an option.
This is much more wise system-wide to avoid shortage on DMA request
lines as there's significant amount of timer instances that can
request up to 7 channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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
