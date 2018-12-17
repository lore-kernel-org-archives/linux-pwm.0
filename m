From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v7 2/6] pwm: add PWM modes
Date: Mon, 17 Dec 2018 14:13:43 +0000
Message-ID: <1545055999-23950-3-git-send-email-claudiu.beznea@microchip.com>
References: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545055999-23950-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh@kernel.org, corbet@lwn.net, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add PWM normal and complementary modes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Rob,

In prevous version I had your Acked-by tag on this patch but I removed it
in this version since there are some changes b/w the previous one and this
one. Please see bellow and let me know if you are ok with this.

Thank you,
Claudiu Beznea

Changes in v6:
- remove DT bindings since they were also removed from code
- use 1/3 duty factor ratio
- use '^' symbols to emphasize the beginning of a new period
- use PWMx_y to refrer to output y of PWM x

 Documentation/pwm.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..669fd4c9cc8e 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -110,6 +110,28 @@ channel that was exported. The following properties wi=
ll then be available:
 	- 0 - disabled
 	- 1 - enabled
=20
+  mode
+    Get/set PWM channel working mode.
+
+    In the following description PWMx_y refers to output y of PWM with ID =
x.
+
+    Normal mode - for PWM channels with one output; this should be the
+        default working mode for every PWM channel; output waveforms looks
+        like this:
+              __      __      __      __
+    PWMx   __|  |____|  |____|  |____|  |__
+             ^       ^       ^       ^
+
+    Complementary mode - for PWM channels with two outputs; output wavefor=
ms
+        looks line this:
+              __      __      __      __
+    PWMx_0 __|  |____|  |____|  |____|  |__
+           __    ____    ____    ____    __
+    PWMx_1   |__|    |__|    |__|    |__|
+             ^       ^       ^       ^
+
+    Where '^' specifies the beginning of a period.
+
 Implementing a PWM driver
 -------------------------
=20
--=20
2.7.4
