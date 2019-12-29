From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 27/32] pwm: clps711x: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:05 +0000
Message-ID: <20191229080610.7597-27-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-clps711x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a797cf..e69a5877cec6 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -113,14 +113,12 @@ static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
 	struct clps711x_chip *priv;
-	struct resource *res;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->pmpcon = devm_ioremap_resource(&pdev->dev, res);
+	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
 		return PTR_ERR(priv->pmpcon);
 
-- 
2.17.1
