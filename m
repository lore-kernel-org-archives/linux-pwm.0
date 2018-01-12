From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 04/16] pwm: clps711x: update documentation regarding pwm-cells
Date: Fri, 12 Jan 2018 16:22:51 +0200
Message-ID: <1515766983-15151-5-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>, Alexander Shiyan <shc_work@mail.ru>
List-Id: linux-pwm@vger.kernel.org

pwm-cells should be at least 2 to provide channel number and period value.

Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
index c0b2028238d6..57f480a872e3 100644
--- a/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/cirrus,clps711x-pwm.txt
@@ -4,12 +4,12 @@ Required properties:
 - compatible: Shall contain "cirrus,ep7209-pwm".
 - reg: Physical base address and length of the controller's registers.
 - clocks: phandle + clock specifier pair of the PWM reference clock.
-- #pwm-cells: Should be 1. The cell specifies the index of the channel.
+- #pwm-cells: Should be 2. The cell specifies the index of the channel.
 
 Example:
 	pwm: pwm@80000400 {
 		compatible = "cirrus,ep7312-pwm", "cirrus,ep7209-pwm";
 		reg = <0x80000400 0x4>;
 		clocks = <&clks 8>;
-		#pwm-cells = <1>;
+		#pwm-cells = <2>;
 	};
-- 
2.7.4
