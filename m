From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Date: Tue, 3 Dec 2019 06:04:27 +0000
Message-ID: <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>
Cc: "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
List-Id: linux-pwm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use platform_irq_count to replace of_irq_count

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Code inspection, not tested

 drivers/gpio/gpio-bcm-kona.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 4122683eb1f9..c50721980a7c 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/gpio/driver.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
@@ -586,7 +585,7 @@ static int bcm_kona_gpio_probe(struct platform_device *=
pdev)
=20
 	kona_gpio->gpio_chip =3D template_chip;
 	chip =3D &kona_gpio->gpio_chip;
-	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
+	kona_gpio->num_bank =3D platform_irq_count(pdev);
 	if (kona_gpio->num_bank =3D=3D 0) {
 		dev_err(dev, "Couldn't determine # GPIO banks\n");
 		return -ENOENT;
--=20
2.16.4
