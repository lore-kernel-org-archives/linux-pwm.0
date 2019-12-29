From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 28/32] pwm: img: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:06 +0000
Message-ID: <20191229080610.7597-28-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fb..e9b25440b808 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -238,7 +238,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
-	struct resource *res;
 	struct img_pwm_chip *pwm;
 	const struct of_device_id *of_dev_id;
 
@@ -248,8 +247,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 
 	pwm->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-- 
2.17.1
