From: hao_zhang <hao5781286@gmail.com>
Subject: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can not
 be match correctly.
Date: Wed, 13 Dec 2017 22:47:48 +0800
Message-ID: <20171213144748.GA18267@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, wens@csie.org, linus.walleij@linaro.org, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, hao5781286@gmail.com
List-Id: linux-pwm@vger.kernel.org

Pin function can not be match correctly when SUNXI_PIN describe with
mutiple variant and same function.

such as:
on pinctrl-sun4i-a10.c

SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
		SUNXI_FUNCTION(0x0, "gpio_in"),
		SUNXI_FUNCTION(0x1, "gpio_out"),
		SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
			PINCTRL_SUN4I_A10 |
			PINCTRL_SUN7I_A20),
		SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
			PINCTRL_SUN8I_R40)),

it would always match to the first variant function
(PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)

so we should add variant compare on it.

Signed-off-by: hao_zhang <hao5781286@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 4b6cb25..f23e74e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -83,9 +83,11 @@ sunxi_pinctrl_desc_find_function_by_name(struct sunxi_pinctrl *pctl,
 			struct sunxi_desc_function *func = pin->functions;
 
 			while (func->name) {
-				if (!strcmp(func->name, func_name))
+				if (!strcmp(func->name, func_name)) {
+					if (!(func->variant) ||
+					   (func->variant & pctl->variant))
 					return func;
-
+				}
 				func++;
 			}
 		}
-- 
2.7.4
