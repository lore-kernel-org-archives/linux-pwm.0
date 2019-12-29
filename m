From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 04/32] pwm: renesas-tpu: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:42 +0000
Message-ID: <20191229080610.7597-4-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-renesas-tpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4a855a21b782..9f4695cc8e72 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -383,7 +383,6 @@ static const struct pwm_ops tpu_pwm_ops = {
 static int tpu_probe(struct platform_device *pdev)
 {
 	struct tpu_device *tpu;
-	struct resource *res;
 	int ret;
 
 	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
@@ -394,8 +393,7 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->pdev = pdev;
 
 	/* Map memory, get clock and pin control. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tpu->base = devm_ioremap_resource(&pdev->dev, res);
+	tpu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tpu->base))
 		return PTR_ERR(tpu->base);
 
-- 
2.17.1
