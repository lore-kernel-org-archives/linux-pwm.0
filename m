From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 32/32] pwm: atmel: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:10 +0000
Message-ID: <20191229080610.7597-32-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-atmel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 9ba733467e26..86cc5ccaa46c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -340,7 +340,6 @@ MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
-	struct resource *res;
 	int ret;
 
 	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -351,8 +350,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 	atmel_pwm->updated_pwms = 0;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	atmel_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pwm->base))
 		return PTR_ERR(atmel_pwm->base);
 
-- 
2.17.1
