From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 09/32] pwm: pxa: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:47 +0000
Message-ID: <20191229080610.7597-9-tiny.windzz@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: claudiu.beznea@microchip.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-pxa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a2a0912c2dcd..d06cf60e6575 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -166,7 +166,6 @@ static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct pxa_pwm_chip *pwm;
-	struct resource *r;
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
@@ -193,8 +192,7 @@ static int pwm_probe(struct platform_device *pdev)
 		pwm->chip.of_pwm_n_cells = 1;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	pwm->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->mmio_base))
 		return PTR_ERR(pwm->mmio_base);
 
-- 
2.17.1
