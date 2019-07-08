Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RFC 7/7] arm64: dts: renesas: salvator-common: add gpio property into pwm1
Date: Mon,  8 Jul 2019 18:07:48 +0900
Message-Id: <1562576868-8124-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a specific gpio property to output duty zero.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 5c2c847..5b68fb6 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -727,6 +727,7 @@
 &pwm1 {
 	pinctrl-0 = <&pwm1_pins>;
 	pinctrl-names = "default";
+	renesas,duty-zero-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
 
 	status = "okay";
 };
-- 
2.7.4
