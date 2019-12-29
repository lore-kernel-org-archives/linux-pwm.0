From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 25/32] pwm: brcmstb: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:06:03 +0000
Message-ID: <20191229080610.7597-25-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-brcmstb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index fea612c45f20..8b66f9d2f589 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
 static int brcmstb_pwm_probe(struct platform_device *pdev)
 {
 	struct brcmstb_pwm *p;
-	struct resource *res;
 	int ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
@@ -262,8 +261,7 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->chip.base = -1;
 	p->chip.npwm = 2;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base)) {
 		ret = PTR_ERR(p->base);
 		goto out_clk;
-- 
2.17.1
