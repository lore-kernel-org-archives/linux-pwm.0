From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 07/16] arm64: dts: rockchip: update pwm-cells
Date: Fri, 12 Jan 2018 16:22:54 +0200
Message-ID: <1515766983-15151-8-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Update pwm-cells to 2 to allow initialization of channel number an period.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 0384e3121f18..0c790ec387eb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -77,7 +77,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&cros_ec_pwm 1>;
+		pwms = <&cros_ec_pwm 1 65535>;
 		brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
 				     17 18 19 20 21 22 23 24 25 26 27 28 29 30
 				     31 32 33 34 35 36 37 38 39 40 41 42 43 44
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 5772c52fbfd3..aa377f9ae6ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -853,7 +853,7 @@ ap_i2c_audio: &i2c8 {
 
 		cros_ec_pwm: ec-pwm {
 			compatible = "google,cros-ec-pwm";
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 		};
 	};
 };
-- 
2.7.4
