From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 3/4] ARM: dts: keystone-k2g-evm: Enable PWM ECAP0
Date: Mon, 7 Aug 2017 17:19:42 +0530
Message-ID: <20170807114943.22612-4-vigneshr@ti.com>
References: <20170807114943.22612-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807114943.22612-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Enable PWM ECAP0 which will be used for display backlight.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 61883cb969d2..3ce8010622ff 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -34,6 +34,12 @@
 			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
+
+	ecap0_pins: ecap0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1374) (BUFFER_CLASS_B | MUX_MODE4)	/* pr1_mdio_data.ecap0_in_apwm0_out */
+		>;
+	};
 };
 
 &uart0 {
@@ -41,3 +47,9 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&ecap0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap0_pins>;
+};
-- 
2.13.3
