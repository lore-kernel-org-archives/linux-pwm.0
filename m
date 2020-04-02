From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: [PATCH v2 05/16] dt-bindings: mfd: Add bindings for sl28cpld
Date: Thu,  2 Apr 2020 22:36:45 +0200
Message-ID: <20200402203656.27047-6-michael@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200402203656.27047-1-michael-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

This adds device tree bindings for the board management controller found
on the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
---
 .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  51 ++++++
 .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 +++
 .../bindings/mfd/kontron,sl28cpld.yaml        | 162 ++++++++++++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
 .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
 5 files changed, 310 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml

diff --git a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
new file mode 100644
index 000000000000..291ca116743d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+  There are three flavors of the GPIO controller, one full featured
+  input/output with interrupt support (kontron,sl28cpld-gpio), one
+  output-only (kontron,sl28-gpo) and one input-only (kontron,sl28-gpi).
+
+  Each controller supports 8 GPIO lines.
+
+properties:
+  compatible:
+    enum:
+      - kontron,sl28cpld-gpio
+      - kontron,sl28cpld-gpi
+      - kontron,sl28cpld-gpo
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-line-names:
+      minItems: 1
+      maxItems: 8
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
new file mode 100644
index 000000000000..1cebd61c6c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/kontron,sl28cpld-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hardware monitoring driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+properties:
+  compatible:
+    enum:
+      - kontron,sl28cpld-fan
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
new file mode 100644
index 000000000000..e155e3035513
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kontron's sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
+
+description: |
+  The board management controller may contain different IP blocks like
+  watchdog, fan monitoring, PWM controller, interrupt controller and a
+  GPIO controller.
+
+  Currently the MFD exports the following functions at the given
+  unit-addresses.
+
+  === =========== =======================
+   ua name        compatible
+  === =========== =======================
+   0  watchdog    kontron,sl28cpld-wdt
+   1  hwmon       kontron,sl28cpld-fan
+   2  pwm         kontron,sl28cpld-pwm
+   3  pwm         kontron,sl28cpld-pwm
+   4  gpio        kontron,sl28cpld-gpio
+   5  gpio        kontron,sl28cpld-gpio
+   6  gpio        kontron,sl28cpld-gpo
+   7  gpio        kontron,sl28cpld-gpi
+  === =========== =======================
+
+  The MFD driver will match the child nodes according to the unit-address
+  (eg. the reg property) and the compatible string.
+
+properties:
+  compatible:
+    const: kontron,sl28cpld
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+patternProperties:
+  "^gpio(@[0-9]+)?$":
+    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
+
+  "^hwmon(@[0-9]+)?$":
+    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
+
+  "^pwm(@[0-9]+)?$":
+    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
+
+  "^watchdog(@[0-9]+)?$":
+    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sl28cpld@4a {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "kontron,sl28cpld";
+            reg = <0x4a>;
+            interrupts-extended = <&gpio2 6 IRQ_TYPE_EDGE_FALLING>;
+
+            #interrupt-cells = <2>;
+            interrupt-controller;
+
+            watchdog@0 {
+                compatible = "kontron,sl28cpld-wdt";
+                reg = <0>;
+                kontron,assert-wdt-timeout-pin;
+            };
+
+            hwmon@1 {
+                compatible = "kontron,sl28cpld-fan";
+                reg = <1>;
+            };
+
+            pwm@2 {
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <2>;
+                #pwm-cells = <2>;
+            };
+
+            pwm@3 {
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <3>;
+                #pwm-cells = <2>;
+            };
+
+            gpio@4 {
+                compatible = "kontron,sl28cpld-gpio";
+                reg = <4>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            gpio@5 {
+                compatible = "kontron,sl28cpld-gpio";
+                reg = <5>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            gpio@6 {
+                compatible = "kontron,sl28cpld-gpo";
+                reg = <6>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-line-names = "a", "b", "c";
+            };
+
+            gpio@7 {
+                compatible = "kontron,sl28cpld-gpi";
+                reg = <7>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
new file mode 100644
index 000000000000..02fe88c30233
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/kontron,sl28cpld-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+  The controller supports one PWM channel and supports only four distinct
+  frequencies (250Hz, 500Hz, 1kHz, 2kHz).
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
new file mode 100644
index 000000000000..dd6559f2973a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/kontron,sl28cpld-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-wdt
+
+  reg:
+    maxItems: 1
+
+  kontron,assert-wdt-timeout-pin:
+    description: The SMARC standard defines a WDT_TIME_OUT# pin. If this
+      property is set, this output will be pulsed when the watchdog bites
+      and the system resets.
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.20.1
