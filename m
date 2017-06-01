From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: [PATCH] gpio: mvebu: change compatible string for PWM support
Date: Thu,  1 Jun 2017 22:08:20 +0200
Message-ID: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34356 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFAUIe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jun 2017 16:08:34 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ralph Sennhauser <ralph.sennhauser@gmail.com>

As it turns out more than just Armada 370 and XP support using GPIO
lines as PWM lines. For example the Armada 38x family has the same
hardware support. As such "marvell,armada-370-xp-gpio" for the
compatible string is a misnomer.

Change the compatible string to "marvell,armada-370-gpio" before the
driver makes it out of the -rc stage. This also follows the practice of
using only the first device family supported as part of the name.

Also update the documentation and comments in the code accordingly.

Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

---

Hi everyone,

The suggestion to change the compatible string last minute comes from
Gregory CLEMENT after we realized the bad choice of name due to Richard
Genoud reporting an issue when he used the driver with an Armada-388.

Rob Herring just requested to use a separate compatible string but not
what it should look like. So I assume he is fine with the new one as
well. The rest of this patch is rather minor.

Nothing in tree is using this driver so far, first consumers will be
added with 4.13.

Ralph

---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 6 +++---
 drivers/gpio/gpio-mvebu.c                             | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index 42c3bb2..01e331a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -41,9 +41,9 @@ Required properties:
 Optional properties:
 
 In order to use the GPIO lines in PWM mode, some additional optional
-properties are required. Only Armada 370 and XP support these properties.
+properties are required.
 
-- compatible: Must contain "marvell,armada-370-xp-gpio"
+- compatible: Must contain "marvell,armada-370-gpio"
 
 - reg: an additional register set is needed, for the GPIO Blink
   Counter on/off registers.
@@ -71,7 +71,7 @@ Example:
 		};
 
 		gpio1: gpio@18140 {
-			compatible = "marvell,armada-370-xp-gpio";
+			compatible = "marvell,armada-370-gpio";
 			reg = <0x18140 0x40>, <0x181c8 0x08>;
 			reg-names = "gpio", "pwm";
 			ngpios = <17>;
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 19a92ef..f94fd47 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -721,7 +721,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	u32 set;
 
 	if (!of_device_is_compatible(mvchip->chip.of_node,
-				     "marvell,armada-370-xp-gpio"))
+				     "marvell,armada-370-gpio"))
 		return 0;
 
 	if (IS_ERR(mvchip->clk))
@@ -845,7 +845,7 @@ static const struct of_device_id mvebu_gpio_of_match[] = {
 		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ARMADAXP,
 	},
 	{
-		.compatible = "marvell,armada-370-xp-gpio",
+		.compatible = "marvell,armada-370-gpio",
 		.data	    = (void *) MVEBU_GPIO_SOC_VARIANT_ORION,
 	},
 	{
@@ -1121,7 +1121,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 						 mvchip);
 	}
 
-	/* Armada 370/XP has simple PWM support for GPIO lines */
+	/* Some MVEBU SoCs have simple PWM support for GPIO lines */
 	if (IS_ENABLED(CONFIG_PWM))
 		return mvebu_pwm_probe(pdev, mvchip, id);
 
-- 
2.10.2
