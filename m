From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 3/3] ARM: dts: stm32: update pwm-cells for LPTimer on stm32h743
Date: Thu, 1 Feb 2018 14:44:38 +0100
Message-ID: <1517492678-767-4-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517492678-767-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

LPTimer pwm cells should be updated to 3, to allow initialization of
channel, period and polarity.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
---
 arch/arm/boot/dts/stm32h743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index bbfcbac..40d7d76 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -85,6 +85,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -238,6 +239,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -264,6 +266,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -285,6 +288,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
@@ -300,6 +304,7 @@
 
 			pwm {
 				compatible = "st,stm32-pwm-lp";
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
