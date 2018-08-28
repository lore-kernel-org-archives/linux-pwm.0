From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v5 8/9] pwm: add documentation for pwm push-pull mode
Date: Tue, 28 Aug 2018 16:01:25 +0300
Message-ID: <1535461286-12308-9-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  2 ++
 Documentation/pwm.txt                         | 16 ++++++++++++++++
 include/dt-bindings/pwm/pwm.h                 |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 7c8aaac43f92..6a60c0fca112 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -49,6 +49,8 @@ Optionally, the pwm-specifier can encode a number of flags (defined in
 - PWM_MODE_COMPLEMENTARY: PWM complementary working mode (for PWM channels
 with two outputs); if not specified, the default for PWM channel will be
 used
+- PWM_MODE_PUSH_PULL: PWM push-pull working modes (for PWM channels with
+two outputs); if not specified the default for PWM channel will be used
 
 Example with optional PWM specifier for inverse polarity and complementary
 mode:
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 912c43da8b48..675f9351fed1 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -128,6 +128,22 @@ channel that was exported. The following properties will then be available:
     PWML1   |__|  |__|  |__|  |__|
             <--T-->
 
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks like
+        this:
+            __          __
+    PWMH __|  |________|  |________
+                  __          __
+    PWML ________|  |________|  |__
+           <--T-->
+
+    If polarity is inversed:
+         __    ________    ________
+    PWMH   |__|        |__|
+         ________    ________    __
+    PWML         |__|        |__|
+           <--T-->
+
     Where T is the signal period.
 
 Implementing a PWM driver
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index b82279cc1787..cd4265bce968 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -12,5 +12,6 @@
 
 #define PWM_POLARITY_INVERTED			(1 << 0)
 #define PWM_MODE_COMPLEMENTARY			(1 << 1)
+#define PWM_MODE_PUSH_PULL			(1 << 2)
 
 #endif
-- 
2.7.4
