From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH v2 2/3] dt-bindings: iio: update STM32 timers clock names
Date: Wed, 14 Jun 2017 17:13:15 +0200
Message-ID: <1497453196-31470-3-git-send-email-fabrice.gasnier@st.com>
References: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497453196-31470-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Fixes: bf2d8581b1b3 (iio: Add bindings for STM32 timer trigger driver)
Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Acked-by: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
index 55a653d..6abc755 100644
--- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -14,7 +14,7 @@ Example:
 		compatible = "st,stm32-timers";
 		reg = <0x40010000 0x400>;
 		clocks = <&rcc 0 160>;
-		clock-names = "clk_int";
+		clock-names = "int";
 
 		timer@0 {
 			compatible = "st,stm32-timer-trigger";
-- 
1.9.1
