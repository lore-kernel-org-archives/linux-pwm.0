From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 05/32] pwm: ep93xx: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:43 +0000
Message-ID: <20191229080610.7597-5-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-ep93xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 4bab73073ad7..c9fc6f223640 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -169,15 +169,13 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
 	struct ep93xx_pwm *ep93xx_pwm;
-	struct resource *res;
 	int ret;
 
 	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
 	if (!ep93xx_pwm)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep93xx_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
 		return PTR_ERR(ep93xx_pwm->base);
 
-- 
2.17.1
