From: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH v2 11/16] pwm: add documentation for PWM modes
Date: Fri, 12 Jan 2018 16:22:58 +0200
Message-ID: <1515766983-15151-12-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Add documentation for PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 Documentation/devicetree/bindings/pwm/pwm.txt | 17 ++++++++++++++--
 Documentation/pwm.txt                         | 29 +++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 8556263b8502..fdff25bad1db 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -43,8 +43,8 @@ because the name "backlight" would be used as fallback anyway.
 pwm-specifier typically encodes the chip-relative PWM number and the PWM
 period in nanoseconds.
 
-Optionally, the pwm-specifier can encode a number of flags (defined in
-<dt-bindings/pwm/pwm.h>) in a third cell:
+Optionally, the pwm-specifier can encode:
+1. a number of flags (defined in <dt-bindings/pwm/pwm.h>) in a third cell:
 - PWM_POLARITY_INVERTED: invert the PWM signal polarity
 
 Example with optional PWM specifier for inverse polarity
@@ -54,6 +54,19 @@ Example with optional PWM specifier for inverse polarity
 		pwm-names = "backlight";
 	};
 
+2. PWM working modes (defined in <dt-bindings/pwm/pwm.h>) in the 4th cell:
+- PWM_MODE_NORMAL: for all PWM controllers
+- PWM_MODE_COMPLEMENTARY: for PWM controllers with more than one output per
+PWM channel
+
+Example with PWM modes:
+
+	bl: blacklight {
+		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERTED
+			PWM_DTMODE_NORMAL | PWM_DTMODE_COMPLEMENTARY>;
+		pwm-names = "backlight";
+	};
+
 2) PWM controller nodes
 -----------------------
 
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..58c9bd55f021 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -61,8 +61,8 @@ In addition to the PWM state, the PWM API also exposes PWM arguments, which
 are the reference PWM config one should use on this PWM.
 PWM arguments are usually platform-specific and allows the PWM user to only
 care about dutycycle relatively to the full period (like, duty = 50% of the
-period). struct pwm_args contains 2 fields (period and polarity) and should
-be used to set the initial PWM config (usually done in the probe function
+period). struct pwm_args contains 3 fields (period, polarity and mode) and
+should be used to set the initial PWM config (usually done in the probe function
 of the PWM user). PWM arguments are retrieved with pwm_get_args().
 
 Using PWMs with the sysfs interface
@@ -83,6 +83,9 @@ will find:
   unexport
    Unexports a PWM channel from sysfs (write-only).
 
+  mode
+   PWM chip supported modes.
+
 The PWM channels are numbered using a per-chip index from 0 to npwm-1.
 
 When a PWM channel is exported a pwmX directory will be created in the
@@ -110,6 +113,28 @@ channel that was exported. The following properties will then be available:
 	- 0 - disabled
 	- 1 - enabled
 
+  mode
+    Set PWM channel working mode (normal and complementary). PWM chip with
+    complementary mode could also work in normal mode by using only one physical
+    output.
+
+    Normal mode - for PWM chips with one output per PWM channel; output
+        waveforms looks like this:
+             __    __    __    __
+    PWM   __|  |__|  |__|  |__|  |__
+            <--T-->
+
+    Complementary mode - for PWM chips with more than one output per PWM
+        channel; output waveforms for a PWM controller with 2 outputs per PWM
+        channel looks line this:
+             __    __    __    __
+    PWMH1 __|  |__|  |__|  |__|  |__
+          __    __    __    __    __
+    PWML1   |__|  |__|  |__|  |__|
+            <--T-->
+
+    Where T is the signal period.
+
 Implementing a PWM driver
 -------------------------
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
