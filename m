From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for devm_clk_get()
Date: Sun, 29 Mar 2020 11:48:09 +0100
Message-ID: <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35648 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgC2Ksa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:48:30 -0400
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>

Honour deferred probing for devm_clk_get() so that we can get the clock
for PWM.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpio/gpio-mvebu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index fa5641615db6..ee13b11c5298 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
 	/* Not all SoCs require a clock.*/
 	if (!IS_ERR(mvchip->clk))
 		clk_prepare_enable(mvchip->clk);
-- 
2.20.1
