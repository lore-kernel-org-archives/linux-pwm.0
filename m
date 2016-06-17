From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 3/4] doc: dt: pwm: add binding for ChromeOS EC PWM
Date: Fri, 17 Jun 2016 12:58:14 -0700
Message-ID: <1466193495-95801-4-git-send-email-briannorris@chromium.org>
References: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466193495-95801-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Stephen Barber <smbarber@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Randall Spangler <rspangler@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

The ChromeOS Embedded Controller can support controlling its attached
PWMs via its host-command interface. The number of supported PWMs varies
on a per-board basis, but we can autodetect this by checking the error
codes, so we don't need an extra property for this. And because the EC
only allows specifying the duty cycle and not the period, we don't
specify the period via pwm-cells, and instead have only support 1 cell
-- to specify the index.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v3:
 * add Rob's ack

v2: dropped the "google,max-pwms" property
---
 .../devicetree/bindings/pwm/google,cros-ec-pwm.txt | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
new file mode 100644
index 000000000000..472bd46ab5a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
@@ -0,0 +1,23 @@
+* PWM controlled by ChromeOS EC
+
+Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
+(EC) and controlled via a host-command interface.
+
+An EC PWM node should be only found as a sub-node of the EC node (see
+Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+Required properties:
+- compatible: Must contain "google,cros-ec-pwm"
+- #pwm-cells: Should be 1. The cell specifies the PWM index.
+
+Example:
+	cros-ec@0 {
+		compatible = "google,cros-ec-spi";
+
+		...
+
+		cros_ec_pwm: ec-pwm {
+			compatible = "google,cros-ec-pwm";
+			#pwm-cells = <1>;
+		};
+	};
-- 
2.8.0.rc3.226.g39d4020
