From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/2] gpio: bcm-kona: use platform_irq_count
Date: Wed, 4 Dec 2019 04:20:45 +0000
Message-ID: <1575433106-16171-2-git-send-email-peng.fan@nxp.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>
Cc: "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
List-Id: linux-pwm@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

platform_irq_count() is the more generic way (independent of
device trees) to determine the count of available interrupts. So
use this instead.

As platform_irq_count() might return an error code (which
of_irq_count doesn't) some additional handling is necessary.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log, and add err handling
 Not tested, just code inspection

 drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 4122683eb1f9..52ff56166263 100644
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
@@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_device=
 *pdev)
=20
 	kona_gpio->gpio_chip =3D template_chip;
 	chip =3D &kona_gpio->gpio_chip;
-	kona_gpio->num_bank =3D of_irq_count(dev->of_node);
-	if (kona_gpio->num_bank =3D=3D 0) {
+	ret =3D platform_irq_count(pdev);
+	if (!ret) {
 		dev_err(dev, "Couldn't determine # GPIO banks\n");
 		return -ENOENT;
+	} else if (ret < 0) {
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(dev, "Couldn't determine GPIO banks: %d\n",
+				ret);
+		return ret;
 	}
+	kona_gpio->num_bank =3D ret;
+
 	if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {
 		dev_err(dev, "Too many GPIO banks configured (max=3D%d)\n",
 			GPIO_MAX_BANK_NUM);
--=20
2.16.4
