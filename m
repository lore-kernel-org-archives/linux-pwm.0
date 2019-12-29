From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 26/32] pwm: mtk-disp: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:04 +0000
Message-ID: <20191229080610.7597-26-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-mtk-disp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 83b8be0209b7..87c6b4bc5d43 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -172,7 +172,6 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
 static int mtk_disp_pwm_probe(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp;
-	struct resource *r;
 	int ret;
 
 	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
@@ -181,8 +180,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	mdp->data = of_device_get_match_data(&pdev->dev);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdp->base = devm_ioremap_resource(&pdev->dev, r);
+	mdp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdp->base))
 		return PTR_ERR(mdp->base);
 
-- 
2.17.1
