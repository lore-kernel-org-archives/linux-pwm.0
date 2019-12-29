From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 31/32] pwm: sifive: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:09 +0000
Message-ID: <20191229080610.7597-31-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9baa481..cb9134d7197b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -232,7 +232,6 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pwm_sifive_ddata *ddata;
 	struct pwm_chip *chip;
-	struct resource *res;
 	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
@@ -248,8 +247,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->npwm = 4;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddata->regs = devm_ioremap_resource(dev, res);
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
 
-- 
2.17.1
