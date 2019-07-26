From: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 6/6] arm64: dts: allwinner: h6: Add PWM node
Date: Fri, 26 Jul 2019 20:40:45 +0200
Message-ID: <20190726184045.14669-7-jernej.skrabec@siol.net>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726184045.14669-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

Allwinner H6 PWM is similar to that in A20 except that it has additional
bus clock and reset line.

Note that first PWM channel is connected to output pin and second
channel is used internally, as a clock source to AC200 co-packaged chip.
This means that any combination of these two channels can be used and
thus it doesn't make sense to add pinctrl nodes at this point.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
index e8bed58e7246..c1abd805cfdc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -229,6 +229,16 @@
 			status =3D "disabled";
 		};
=20
+		pwm: pwm@300a000 {
+			compatible =3D "allwinner,sun50i-h6-pwm";
+			reg =3D <0x0300a000 0x400>;
+			clocks =3D <&osc24M>, <&ccu CLK_BUS_PWM>;
+			clock-names =3D "pwm", "bus";
+			resets =3D <&ccu RST_BUS_PWM>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		pio: pinctrl@300b000 {
 			compatible =3D "allwinner,sun50i-h6-pinctrl";
 			reg =3D <0x0300b000 0x400>;
--=20
2.22.0
