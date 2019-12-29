From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 20/32] pwm: imx: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:58 +0000
Message-ID: <20191229080610.7597-20-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-imx1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index f8b2c2e001a7..1a60bfd7d659 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -136,7 +136,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
 	struct pwm_imx1_chip *imx;
-	struct resource *r;
 
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (!imx)
@@ -168,8 +167,7 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-- 
2.17.1
