From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] gpio: mvebu: avoid error message for optional IRQ
Date: Fri, 13 Mar 2020 16:42:44 +1300
Message-ID: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37054 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgCMDmw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 23:42:52 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc: linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

platform_get_irq() will generate an error message if the requested irq
is not present

  mvebu-gpio f1010140.gpio: IRQ index 3 not found

use platform_get_irq_optional() to avoid the error message being
generated.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/gpio/gpio-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index d2b999c7987f..3c9f4fb3d5a2 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1247,7 +1247,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
 	 * pins.
 	 */
 	for (i =3D 0; i < 4; i++) {
-		int irq =3D platform_get_irq(pdev, i);
+		int irq =3D platform_get_irq_optional(pdev, i);
=20
 		if (irq < 0)
 			continue;
--=20
2.25.1
