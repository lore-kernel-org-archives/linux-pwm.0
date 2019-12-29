From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 06/32] pwm: tegra: convert to devm_platform_ioremap_resource
Date: Sun, 29 Dec 2019 08:05:44 +0000
Message-ID: <20191229080610.7597-6-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3ed92e..7f77a93eb4b5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -170,7 +170,6 @@ static const struct pwm_ops tegra_pwm_ops = {
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pwm;
-	struct resource *r;
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
@@ -180,8 +179,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pwm->soc = of_device_get_match_data(&pdev->dev);
 	pwm->dev = &pdev->dev;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->regs = devm_ioremap_resource(&pdev->dev, r);
+	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->regs))
 		return PTR_ERR(pwm->regs);
 
-- 
2.17.1
