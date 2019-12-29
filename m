From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 15/32] pwm: rockchip: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:53 +0000
Message-ID: <20191229080610.7597-15-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 73352e6fbccb..f0549b82338d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -292,7 +292,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
-	struct resource *r;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -303,8 +302,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->base = devm_ioremap_resource(&pdev->dev, r);
+	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-- 
2.17.1
