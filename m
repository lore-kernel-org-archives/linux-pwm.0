From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] gpio: mvebu: use platform_irq_count
Date: Tue, 3 Dec 2019 06:04:22 +0000
Message-ID: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
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

 drivers/gpio/gpio-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 993bbeb3c006..ecfedcdadc0d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -46,7 +46,6 @@
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -1102,7 +1101,7 @@ static int mvebu_gpio_probe(struct platform_device *p=
dev)
 		soc_variant =3D MVEBU_GPIO_SOC_VARIANT_ORION;
=20
 	/* Some gpio controllers do not provide irq support */
-	have_irqs =3D of_irq_count(np) !=3D 0;
+	have_irqs =3D platform_irq_count(pdev) !=3D 0;
=20
 	mvchip =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_gpio_chip),
 			      GFP_KERNEL);
--=20
2.16.4
