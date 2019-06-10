From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness' property
Date: Mon, 10 Jun 2019 16:37:38 -0700
Message-ID: <20190610233739.29477-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Add an optional 'max-brightness' property, which is used to specify
the number of brightness levels (max-brightness + 1) when the node
has no 'brightness-levels' table.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
index 64fa2fbd98c9..98f4ba626054 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
@@ -27,6 +27,9 @@ Optional properties:
                             resolution pwm duty cycle can be used without
                             having to list out every possible value in the
                             brightness-level array.
+  - max-brightness: Maximum brightness value. Used to specify the number of
+                    brightness levels (max-brightness + 1) when the node
+                    has no 'brightness-levels' table.
 
 [0]: Documentation/devicetree/bindings/pwm/pwm.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog
