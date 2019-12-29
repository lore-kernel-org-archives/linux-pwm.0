From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 19/32] pwm: puv3: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:57 +0000
Message-ID: <20191229080610.7597-19-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-puv3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-puv3.c b/drivers/pwm/pwm-puv3.c
index 9d0bd87a425e..2367dad7cf95 100644
--- a/drivers/pwm/pwm-puv3.c
+++ b/drivers/pwm/pwm-puv3.c
@@ -100,7 +100,6 @@ static const struct pwm_ops puv3_pwm_ops = {
 static int pwm_probe(struct platform_device *pdev)
 {
 	struct puv3_pwm_chip *puv3;
-	struct resource *r;
 	int ret;
 
 	puv3 = devm_kzalloc(&pdev->dev, sizeof(*puv3), GFP_KERNEL);
@@ -111,8 +110,7 @@ static int pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(puv3->clk))
 		return PTR_ERR(puv3->clk);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	puv3->base = devm_ioremap_resource(&pdev->dev, r);
+	puv3->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(puv3->base))
 		return PTR_ERR(puv3->base);
 
-- 
2.17.1
