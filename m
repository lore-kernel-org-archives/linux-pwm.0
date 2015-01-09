From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/7] gpio: mvebu: Fix probe cleanup on error
Date: Sat, 10 Jan 2015 00:34:48 +0100
Message-ID: <1420846493-31647-3-git-send-email-andrew@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49529 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754827AbbAIXho (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 9 Jan 2015 18:37:44 -0500
In-Reply-To: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linus.walleij@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, kaloz@openwrt.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Ensure that when there is an error during probe that the gpiochip is
removed and the generic irq chip is removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/gpio/gpio-mvebu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 7533d446b820..d0bc123c7975 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -667,6 +667,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	unsigned int ngpios;
 	int soc_variant;
 	int i, cpu, id;
+	int err;
 
 	match = of_match_device(mvebu_gpio_of_match, &pdev->dev);
 	if (match)
@@ -785,14 +786,16 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->irqbase = irq_alloc_descs(-1, 0, ngpios, -1);
 	if (mvchip->irqbase < 0) {
 		dev_err(&pdev->dev, "no irqs\n");
-		return mvchip->irqbase;
+		err = mvchip->irqbase;
+		goto err_gpiochip_add;
 	}
 
 	gc = irq_alloc_generic_chip("mvebu_gpio_irq", 2, mvchip->irqbase,
 				    mvchip->membase, handle_level_irq);
 	if (!gc) {
 		dev_err(&pdev->dev, "Cannot allocate generic irq_chip\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_gpiochip_add;
 	}
 
 	gc->private = mvchip;
@@ -823,13 +826,21 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
-		irq_remove_generic_chip(gc, IRQ_MSK(ngpios), IRQ_NOREQUEST,
-					IRQ_LEVEL | IRQ_NOPROBE);
-		kfree(gc);
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_generic_chip;
 	}
 
 	return 0;
+
+err_generic_chip:
+	irq_remove_generic_chip(gc, IRQ_MSK(ngpios), IRQ_NOREQUEST,
+				IRQ_LEVEL | IRQ_NOPROBE);
+	kfree(gc);
+
+err_gpiochip_add:
+	gpiochip_remove(&mvchip->chip);
+
+	return err;
 }
 
 static struct platform_driver mvebu_gpio_driver = {
-- 
2.1.3

