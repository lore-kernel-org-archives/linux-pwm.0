From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 15/16] pwm: add documentation for pwm push-pull mode
Date: Fri, 12 Jan 2018 16:23:02 +0200
Message-ID: <1515766983-15151-16-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  8 +++++++-
 Documentation/pwm.txt                         | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index fdff25bad1db..a4562af3577c 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -58,15 +58,21 @@ Example with optional PWM specifier for inverse polarity
 - PWM_MODE_NORMAL: for all PWM controllers
 - PWM_MODE_COMPLEMENTARY: for PWM controllers with more than one output per
 PWM channel
+- PWM_MODE_PUSH_PULL: for PWM controllers with more than one output per channel,
+in push-pull mode
 
 Example with PWM modes:
 
 	bl: blacklight {
 		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERTED
-			PWM_DTMODE_NORMAL | PWM_DTMODE_COMPLEMENTARY>;
+			PWM_DTMODE_NORMAL | PWM_DTMODE_COMPLEMENTARY |
+			PWM_DTMODE_PUSH_PULL>;
 		pwm-names = "backlight";
 	};
 
+If all the available modes are given as argument of pwms binding only the first
+valid one will be considered (first valid LSB bit of mode field).
+
 2) PWM controller nodes
 -----------------------
 
diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 58c9bd55f021..71b538239519 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -135,6 +135,24 @@ channel that was exported. The following properties will then be available:
 
     Where T is the signal period.
 
+    Push-pull mode - for PWM chips with mode than one output per PWM channel;
+        output waveform for a PWM controller with 2 outputs per PWM channel, in
+	push-pull mode, with normal polarity looks like this:
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
+    Where T is the signal period.
+
 Implementing a PWM driver
 -------------------------
 
-- 
2.7.4
