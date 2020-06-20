From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: [RFC PATCH 01/10] DT bindings in plain text format
Date: Sun, 21 Jun 2020 00:39:05 +0200
Message-ID: <20200620223915.1311485-2-j.neuschaefer@gmx.net>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200620223915.1311485-1-j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie@kernel.>
List-Id: linux-pwm@vger.kernel.org

For reference, here are the devicetree bindings in plaintext format.
(Not for merge.)

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
=2D--
 .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
 .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
 .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++
 3 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.t=
xt
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.txt

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.txt b/Do=
cumentation/devicetree/bindings/mfd/netronix,ntxec.txt
new file mode 100644
index 0000000000000..e303932657999
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.txt
@@ -0,0 +1,58 @@
+Netronix Embedded Controller
+
+This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino)=
, and
+is typically implemented as a TI MSP430 microcontroller.
+
+
+Required properties:
+- compatible: should be "netronix,ntxec"
+- reg: The I2C address of the EC
+
+Optional properties:
+- system-power-controller:
+  See Documentation/devicetree/bindings/power/power-controller.txt
+- interrupts or interrupts-extended
+- interrupt-controller
+- #interrupt-cells: Should be 1
+
+Optional subnodes:
+
+Sub-nodes are identified by their compatible string.
+
+ compatible string              | description
+--------------------------------|--------------------------------------
+ netronix,ntxec-pwm             | PWM (used for backlight)
+ netronix,ntxec-rtc             | real time clock
+
+
+Example:
+
+&i2c3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c3>;
+	status =3D "okay";
+
+	ec: embedded-controller@43 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_ntxec>;
+
+		compatible =3D "netronix,ntxec";
+		reg =3D <0x43>;
+		system-power-controller;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells =3D <1>;
+
+		pwm {
+			compatible =3D "netronix,ntxec-pwm";
+			#pwm-cells =3D <1>;
+		};
+
+		rtc {
+			compatible =3D "netronix,ntxec-rtc";
+			interrupts-extended =3D <&ec 15>;
+			interrupt-names =3D "alarm";
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt =
b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
new file mode 100644
index 0000000000000..50be27f82559e
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
@@ -0,0 +1,27 @@
+PWM functionality in Netronix Embedded Controller
+
+Required properties:
+- compatible: should be "netronix,ntxec-pwm"
+- #pwm-cells: should be 1.
+
+Available PWM channels:
+- 0: The PWM channel controlled by registers 0xa1-0xa7
+
+Example:
+
+	embedded-controller@43 {
+		compatible =3D "netronix,ntxec";
+		...
+
+		ec_pwm: pwm {
+			compatible =3D "netronix,ntxec-pwm";
+			#pwm-cells =3D <1>;
+		};
+	};
+
+	...
+
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&ec_pwm 0 50000>;
+	};
diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt =
b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt
new file mode 100644
index 0000000000000..0ef9e791b6a36
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt
@@ -0,0 +1,17 @@
+Netronix embedded controller RTC
+
+Required properties:
+
+- compatible: should be "netronix,ntxec-rtc"
+
+
+Example:
+
+	embedded-controller@43 {
+		compatible =3D "netronix,ntxec";
+		...
+
+		rtc {
+			compatible =3D "netronix,ntxec-rtc";
+		};
+	}
=2D-
2.27.0
