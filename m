From: Maxim <bigunclemax@gmail.com>
Subject: [PATCH] gpio: mvebu: clear irq in edge cause register before unmask edge irq
Date: Wed, 15 Jan 2020 10:38:11 +0300
Message-ID: <20200115073811.24438-1-bigunclemax@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: bigunclemax@gmail.com, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
Interrupt Cause Register (ICR) even if the corresponding interrupt
masked in the GPIO Interrupt Mask Register.

Because interrupt mask register only affects assertion of the interrupt
bits in Main Interrupt Cause Register and it does not affect the
setting of bits in the GPIO ICR.

So, there is problem, when we unmask interrupt with already
asserted bit in the GPIO ICR, then false interrupt immediately occurs
even if GPIO don't change their value since last unmask.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 drivers/gpio/gpio-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 993bbeb3c006..bdae0c08f239 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -432,6 +432,7 @@ static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
+	mvebu_gpio_write_edge_cause(mvchip, ~mask);
 	ct->mask_cache_priv |= mask;
 	mvebu_gpio_write_edge_mask(mvchip, ct->mask_cache_priv);
 	irq_gc_unlock(gc);
-- 
2.24.1
