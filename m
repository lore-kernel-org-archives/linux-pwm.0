From: Denis Carikli <denis@eukrea.com>
Subject: =?UTF-8?q?=5BPATCH=202/3=5D=20ARM=3A=20dts=3A=20mbimxsd53=20Add=20backlight=20and=20LCD=20regulator=2E?=
Date: Wed, 27 Nov 2013 16:39:30 +0100
Message-ID: <1385566771-366-2-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:57962 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755227Ab3K0PkC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 27 Nov 2013 10:40:02 -0500
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Denis Carikli <denis@eukrea.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi       |    7 +++
 .../imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts  |   64 ++++++++++++=
++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-=
cmo-qvga.dts

diff --git a/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi b/arch/arm/bo=
ot/dts/imx53-eukrea-cpuimx53.dtsi
index cb40cf3..bad044f 100644
--- a/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
+++ b/arch/arm/boot/dts/imx53-eukrea-cpuimx53.dtsi
@@ -35,6 +35,13 @@
 	pinctrl-0 =3D <&pinctrl_i2c1>;
 	status =3D "okay";
=20
+	pmic: mc34708@8 {
+		compatible =3D "fsl,mc34708";
+		reg =3D <0x8>;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <28 0x4>;
+	};
+
 	pcf8563@51 {
 		compatible =3D "nxp,pcf8563";
 		reg =3D <0x51>;
diff --git a/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvg=
a.dts b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
new file mode 100644
index 0000000..b9eceae
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-eukrea-mbimxsd53-baseboard-cmo-qvga.dts
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2013 Eukr=C3=A9a Electromatique <denis@eukrea.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include "imx53-eukrea-mbimxsd53-baseboard.dts"
+
+/ {
+	backlight {
+		compatible =3D "pwm-backlight";
+		power-supply =3D <&reg_lvds_backlight_3v3>;
+		pwms =3D <&mc13xxx_pwm 0 16000>;
+		brightness-levels =3D <0 8 16 32 64 128 255>;
+		default-brightness-level =3D <7>;
+	};
+
+	mc13xxx_pwm: pwm {
+		compatible =3D "fsl,mc34708-pwm";
+		mfd =3D <&pmic>;
+		#pwm-cells =3D <2>;
+	};
+
+	reg_lvds_backlight_3v3: lvds-backlight-en {
+		  compatible =3D "regulator-fixed";
+		  pinctrl-names =3D "default";
+		  pinctrl-0 =3D <&pinctrl_reg_lvds_backlight>;
+		  regulator-name =3D "lvds-3v3";
+		  regulator-min-microvolt =3D <3300000>;
+		  regulator-max-microvolt =3D <3300000>;
+		  gpios =3D <&gpio4 4 0>;
+		  enable-active-high;
+	};
+
+	reg_lcd_3v3: lcd-en {
+		  compatible =3D "regulator-fixed";
+		  pinctrl-names =3D "default";
+		  pinctrl-0 =3D <&pinctrl_reg_lcd_3v3>;
+		  regulator-name =3D "lcd-3v3";
+		  regulator-min-microvolt =3D <3300000>;
+		  regulator-max-microvolt =3D <3300000>;
+		  gpios =3D <&gpio4 20 0>;
+		  enable-active-high;
+	  };
+};
+
+&iomuxc {
+	imx53-eukrea {
+		pinctrl_reg_lcd_3v3: reg_lcd_3v3grp {
+			fsl,pins =3D <MX53_PAD_DI0_PIN4__GPIO4_20 0x80000000>;
+		};
+
+		pinctrl_reg_lvds_backlight: reg_lvds_backlightgrp {
+			fsl,pins =3D <MX53_PAD_GPIO_14__GPIO4_4 0x80000000>;
+		};
+	};
+};
--=20
1.7.9.5

