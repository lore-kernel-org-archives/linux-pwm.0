From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 3/5] ARM: dts: stm32: add pwm cells to stm32mp157c
Date: Wed, 19 Jun 2019 11:52:03 +0200
Message-ID: <1560937925-8990-4-git-send-email-fabrice.gasnier@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com
Cc: mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

STM32 Timers support generic 3 cells PWM to encode PWM number, period and
polarity.

Fixes: 61fc211c484d ("ARM: dts: stm32: add timers support to stm32mp157c")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 2afeee6..215dc95 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -133,6 +133,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -161,6 +162,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -187,6 +189,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -215,6 +218,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -272,6 +276,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -293,6 +298,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -314,6 +320,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -545,6 +552,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -575,6 +583,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -637,6 +646,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -661,6 +671,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 			timer@15 {
@@ -684,6 +695,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
-- 
2.7.4
