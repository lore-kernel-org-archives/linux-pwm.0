From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v6 5/6] pwm: add documentation for pwm push-pull mode
Date: Mon, 17 Dec 2018 14:03:29 +0000
Message-ID: <1545055368-23338-6-git-send-email-claudiu.beznea@microchip.com>
References: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545055368-23338-1-git-send-email-claudiu.beznea@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, robh@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Claudiu.Beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add documentation for PWM push-pull mode.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi Rob,                                                                    =
    =20
                                                                           =
    =20
In prevous version I had your Reviewed-by tag on this patch but I removed i=
t      =20
in this version since there are some changes b/w the previous one and this =
    =20
one. Please see bellow and let me know if you are ok with this.            =
                                           =20

Thank you,
Claudiu Beznea

Changes in v6:
- remove bindings part
- use 1/3 duty factor ratio
- use '^' symbols to emphasize the beginning of a new period
- use PWMx_y to refrer to output y of PWM x

 Documentation/pwm.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 669fd4c9cc8e..80552627627d 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -130,6 +130,22 @@ channel that was exported. The following properties wi=
ll then be available:
     PWMx_1   |__|    |__|    |__|    |__|
              ^       ^       ^       ^
=20
+    Push-pull mode - for PWM channels with two outputs; output waveforms
+        for a PWM channel in push-pull mode, with normal polarity looks li=
ke
+        this:
+              __              __
+    PWMx_0 __|  |____________|  |__________
+                      __              __
+    PWMx_1 __________|  |____________|  |__
+             ^       ^       ^       ^
+
+    If polarity is inversed:
+           __    ____________    __________
+    PWMx_0   |__|            |__|
+           __________    ____________    __
+    PWMx_1           |__|            |__|
+             ^       ^       ^       ^
+
     Where '^' specifies the beginning of a period.
=20
 Implementing a PWM driver
--=20
2.7.4
