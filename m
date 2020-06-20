From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix embedded controller RTC
Date: Sun, 21 Jun 2020 00:42:18 +0200
Message-ID: <20200620224222.1312520-6-j.neuschaefer@gmx.net>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Stephan Gerhold <stephan@gerhold.net>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.>
List-Id: linux-pwm@vger.kernel.org

The Netronix EC implements an RTC with the following functionality:

- Calendar-based time keeping with single-second resolution
- Automatic power-on with single-minute resolution
- Alarm at single-second resolution

This binding only supports timekeeping for now.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/mfd/netronix,ntxec.yaml          |  7 +++++
 .../bindings/rtc/netronix,ntxec-rtc.yaml      | 27 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/D=
ocumentation/devicetree/bindings/mfd/netronix,ntxec.yaml
index 6562c41c5a9a9..f6a32f46f47bb 100644
=2D-- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
@@ -34,6 +34,9 @@ properties:
   pwm:
     $ref: ../pwm/netronix,ntxec-pwm.yaml

+  rtc:
+    $ref: ../rtc/netronix,ntxec-rtc.yaml
+
 required:
   - compatible
   - reg
@@ -61,6 +64,10 @@ examples:
                             compatible =3D "netronix,ntxec-pwm";
                             #pwm-cells =3D <1>;
                     };
+
+                    rtc {
+                            compatible =3D "netronix,ntxec-rtc";
+                    };
             };
     };

diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml=
 b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
new file mode 100644
index 0000000000000..4b301ef7319c8
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/netronix,ntxec-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTC functionality in Netronix embedded controller
+
+maintainers:
+  - Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+
+description: |
+  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+
+  The Netronix EC contains an RTC, which can be used for time-keeping, al=
arm,
+  and automatic power-on. Note that not all of this functionality is curr=
ently
+  supported in this binding.
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: netronix,ntxec-rtc
+
+required:
+  - compatible
=2D-
2.27.0
