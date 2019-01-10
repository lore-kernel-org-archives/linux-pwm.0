From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 1/2] gpio: mvebu: implement get_direction
Date: Thu, 10 Jan 2019 14:26:21 +0200
Message-ID: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pwm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pwm@vger.kernel.org

struct gpio_chip documentation recommends to always implement this
callback function.

A more concrete motivation is to be able (in combination with
GPIOD_ASIS) to detect whether the bootloader has changed the state of a
GPIO signal.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 7d5c55494ccd..f97ed32b8beb 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -376,6 +376,16 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	return 0;
 }
 
+static int mvebu_gpio_get_direction(struct gpio_chip *chip, unsigned int pin)
+{
+	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
+	u32 u;
+
+	regmap_read(mvchip->regs, GPIO_IO_CONF_OFF + mvchip->offset, &u);
+
+	return !!(u & BIT(pin));
+}
+
 static int mvebu_gpio_to_irq(struct gpio_chip *chip, unsigned int pin)
 {
 	struct mvebu_gpio_chip *mvchip = gpiochip_get_data(chip);
@@ -1130,6 +1140,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	mvchip->chip.parent = &pdev->dev;
 	mvchip->chip.request = gpiochip_generic_request;
 	mvchip->chip.free = gpiochip_generic_free;
+	mvchip->chip.get_direction = mvebu_gpio_get_direction;
 	mvchip->chip.direction_input = mvebu_gpio_direction_input;
 	mvchip->chip.get = mvebu_gpio_get;
 	mvchip->chip.direction_output = mvebu_gpio_direction_output;
-- 
2.20.1
