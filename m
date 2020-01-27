From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: [PATCH] dt-bindings: convert google,cros-ec-pwm.txt to yaml format
Date: Mon, 27 Jan 2020 11:34:41 +0100
Message-ID: <20200127103441.4618-1-dafna.hirschfeld@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org, enric.balletbo@collabora.com, groeck@chromium.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dafna.hirschfeld@collabora.com, helen.koike@collabora.com, ezequiel@collabora.com, kernel@collabora.com, dafna3@gmail.com
List-Id: linux-pwm@vger.kernel.org

Convert the binding file google,cros-ec-pwm.txt to yaml format.

This was tested and verified on ARM64 with:

make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 .../bindings/pwm/google,cros-ec-pwm.txt       | 23 -----------
 .../bindings/pwm/google,cros-ec-pwm.yaml      | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
deleted file mode 100644
index 472bd46ab5a4..000000000000
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* PWM controlled by ChromeOS EC
-
-Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
-(EC) and controlled via a host-command interface.
-
-An EC PWM node should be only found as a sub-node of the EC node (see
-Documentation/devicetree/bindings/mfd/cros-ec.txt).
-
-Required properties:
-- compatible: Must contain "google,cros-ec-pwm"
-- #pwm-cells: Should be 1. The cell specifies the PWM index.
-
-Example:
-	cros-ec@0 {
-		compatible = "google,cros-ec-spi";
-
-		...
-
-		cros_ec_pwm: ec-pwm {
-			compatible = "google,cros-ec-pwm";
-			#pwm-cells = <1>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
new file mode 100644
index 000000000000..24c217b76580
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/google,cros-ec-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM controlled by ChromeOS EC
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - '"Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>'
+
+description: |
+  Google's ChromeOS EC PWM is a simple PWM attached to the Embedded Controller
+  (EC) and controlled via a host-command interface.
+  An EC PWM node should be only found as a sub-node of the EC node (see
+  Documentation/devicetree/bindings/mfd/cros-ec.txt).
+
+properties:
+  compatible:
+    const: google,cros-ec-pwm
+  "#pwm-cells":
+    description: The cell specifies the PWM index.
+    const: 1
+
+required:
+  - compatible
+  - '#pwm-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    cros-ec@0 {
+        compatible = "google,cros-ec-spi";
+        cros_ec_pwm: ec-pwm {
+            compatible = "google,cros-ec-pwm";
+            #pwm-cells = <1>;
+        };
+    };
-- 
2.17.1
