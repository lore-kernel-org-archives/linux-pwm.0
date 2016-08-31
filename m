From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 3/4] pinctrl: sunxi: Remove unsupported PWM channel pinmux in H3
Date: Wed, 31 Aug 2016 17:25:19 +0900
Message-ID: <20160831082520.25962-4-woogyom.kim@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33343 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933371AbcHaI0J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Aug 2016 04:26:09 -0400
In-Reply-To: <20160831082520.25962-1-woogyom.kim@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>, Jens Kuske <jenskuske@gmail.com>, Krzysztof Adamski <k@japko.eu>

H3 has single PWM channel. The second PWM channel is not supported,
so the pinctrl function should be removed.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Jens Kuske <jenskuske@gmail.com>
Cc: Krzysztof Adamski <k@japko.eu>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
index 26a2ad3..518a92d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
@@ -60,7 +60,6 @@ static const struct sunxi_desc_pin sun8i_h3_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "sim"),		/* PWREN */
-		  SUNXI_FUNCTION(0x3, "pwm1"),
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),	/* PA_EINT6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.9.3
