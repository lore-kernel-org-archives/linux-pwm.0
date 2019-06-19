From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: add pwm cells to stm32f429
Date: Wed, 19 Jun 2019 11:52:04 +0200
Message-ID: <1560937925-8990-5-git-send-email-fabrice.gasnier@st.com>
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

Fixes: c0e14fc712d9 ("ARM: dts: stm32: add Timers driver for stm32f429
MCU")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 4a49544..5c8a826 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -112,6 +112,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -141,6 +142,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -170,6 +172,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -198,6 +201,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -267,6 +271,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -288,6 +293,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -303,6 +309,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -448,6 +455,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -469,6 +477,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -602,6 +611,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -623,6 +633,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -638,6 +649,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
-- 
2.7.4
