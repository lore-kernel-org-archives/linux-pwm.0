From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?=
        <noltari@gmail.com>
Subject: [PATCH 1/2] dt-bindings: hwmon: Add SFR NB6 sensor binding
Date: Sun,  7 Jun 2020 20:25:23 +0200
Message-ID: <20200607182524.3221837-2-noltari@gmail.com>
References: <20200607182524.3221837-1-noltari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200607182524.3221837-1-noltari@gmail.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
List-Id: linux-pwm@vger.kernel.org

SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
temperature and other stats. It also has PWM LEDs that can be manually
controlled or set to specific hardware monitoring modes.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 .../bindings/hwmon/sfr,neufbox6.yaml          | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml b/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
new file mode 100644
index 000000000000..418180e30a66
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sfr,neufbox6.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sfr,neufbox6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SFR NeufBox 6 Sensor
+
+maintainers:
+  - Álvaro Fernández Rojas <noltari@gmail.com>
+
+description: |
+  SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
+  temperature and other stats. It also has PWM LEDs that can be manually
+  controlled or set to specific hardware monitoring modes.
+
+properties:
+  compatible:
+    const: sfr,nb6_hwmon
+
+  reg:
+    description: I2C address
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: hwmon@60 {
+      compatible = "sfr,nb6_hwmon";
+      reg = <0x60>;
+    };
+
+    pwm-leds {
+      compatible = "pwm-leds";
+
+      service1_red {
+        label = "neufbox-6-foxconn-r0:red:service1";
+        pwms = <&pwm 0 31>;
+        max-brightness = <31>;
+      };
+
+      service2_red {
+        label = "neufbox-6-foxconn-r0:red:service2";
+        pwms = <&pwm 1 31>;
+        max-brightness = <31>;
+      };
+
+      service3_red {
+        label = "neufbox-6-foxconn-r0:red:service3";
+        pwms = <&pwm 2 31>;
+        max-brightness = <31>;
+      };
+
+      service1_green {
+        label = "neufbox-6-foxconn-r0:green:service1";
+        pwms = <&pwm 3 31>;
+        max-brightness = <31>;
+        default-state = "on";
+      };
+
+      service2_green {
+        label = "neufbox-6-foxconn-r0:green:service2";
+        pwms = <&pwm 4 31>;
+        max-brightness = <31>;
+      };
+
+      service3_green {
+        label = "neufbox-6-foxconn-r0:green:service3";
+        pwms = <&pwm 5 31>;
+        max-brightness = <31>;
+      };
+
+      wan_white {
+        label = "neufbox-6-foxconn-r0:white:wan";
+        pwms = <&pwm 6 31>;
+        max-brightness = <31>;
+      };
+
+      voip_white {
+        label = "neufbox-6-foxconn-r0:white:voip";
+        pwms = <&pwm 7 31>;
+        max-brightness = <31>;
+      };
+
+      wlan_white {
+        label = "neufbox-6-foxconn-r0:white:wlan";
+        pwms = <&pwm 8 31>;
+        max-brightness = <31>;
+      };
+    };
+...
-- 
2.26.2
