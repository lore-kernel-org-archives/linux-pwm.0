From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 30/32] pwm: hibvt: do some cleanup
Date: Sun, 29 Dec 2019 08:06:08 +0000
Message-ID: <20191229080610.7597-30-tiny.windzz@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: claudiu.beznea@microchip.com, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de, palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org, wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.
'i' and 'ret' are variables of the same type and there is no
need to use two lines.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ad205fdad372..a1900d0a872e 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -190,9 +190,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
 	struct hibvt_pwm_chip *pwm_chip;
-	struct resource *res;
-	int ret;
-	int i;
+	int ret, i;
 
 	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
 	if (pwm_chip == NULL)
@@ -213,8 +211,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.of_pwm_n_cells = 3;
 	pwm_chip->soc = soc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm_chip->base))
 		return PTR_ERR(pwm_chip->base);
 
-- 
2.17.1
