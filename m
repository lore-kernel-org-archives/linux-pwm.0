From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/4] dt-bindings: pwm: Add bindings for Meson PWM Controller
Date: Fri, 17 Jun 2016 16:29:42 +0200
Message-ID: <1466173784-15625-3-git-send-email-narmstrong@baylibre.com>
References: <1466173784-15625-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466173784-15625-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, carlo@caione.org, khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Add bindings for the Amlogic PWM Controller in Meson8b and GXBB SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/pwm-meson.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
new file mode 100644
index 0000000..e06aed0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
@@ -0,0 +1,21 @@
+Amlogic Meson PWM Controller
+=================================
+
+Required properties:
+- compatible: Shall contain "amlogic,meson8b-pwm" or "amlogic,meson-gxbb-pwm".
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+
+Optional properties:
+- clocks: Could contain one or two parents clocks phandle for each of the two pwm channels.
+- clock-names: Could contain at least the "clkin0" and/or "clkin1" names.
+
+Example:
+pwm_ab: pwm@8550 {
+	compatible = "amlogic,meson-gxbb-pwm";
+	reg = <0x0 0x08550 0x0 0x10>;
+	#pwm-cells = <3>;
+	status = "disabled";
+	clocks = <&xtal>, <&xtal>;
+	clock-names = "clkin0", "clkin1";
+}
-- 
2.7.0
