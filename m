Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RFC 4/7] dt-bindings: pwm: rcar: Add specific gpios property to output duty zero
Date: Mon,  8 Jul 2019 18:07:45 +0900
Message-Id: <1562576868-8124-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
adds a specific gpio property to output it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index fbd6a4f..6acaaeb 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -26,6 +26,9 @@ Required Properties:
 - pinctrl-0: phandle, referring to a default pin configuration node.
 - pinctrl-names: Set to "default".
 
+Optional properties:
+- renesas,duty-zero-gpios: Specify GPIO for outputting duty zero.
+
 Example: R8A7743 (RZ/G1M) PWM Timer node
 
 	pwm0: pwm@e6e30000 {
-- 
2.7.4
