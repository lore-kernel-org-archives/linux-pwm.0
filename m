From: Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v3 5/5] ARM: berlin: add a PWM node on the BG2CD
Date: Wed, 12 Aug 2015 15:51:37 +0200
Message-ID: <1439387497-6863-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1439387497-6863-1-git-send-email-antoine.tenart@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439387497-6863-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sebastian.hesselbarth@gmail.com, thierry.reding@gmail.com
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

This patch adds a PWM node in the Berlin BG2CD device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d78a32..5d984f58dde7 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -368,6 +368,13 @@
 			status = "disabled";
 		};
 
+		pwm: pwm@f20000 {
+			compatible = "marvell,berlin-pwm";
+			reg = <0xf20000 0x40>;
+			clocks = <&chip_clk CLKID_CFG>;
+			#pwm-cells = <3>;
+		};
+
 		apb@fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
2.5.0
