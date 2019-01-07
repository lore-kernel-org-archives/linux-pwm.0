Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/4] pwm: imx: set drvdata earlier simplifying the end of
 .probe
Date: Mon,  7 Jan 2019 20:53:50 +0100
Message-Id: <20190107195352.3149-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190107195352.3149-1-u.kleine-koenig@pengutronix.de>
References: <20190107195352.3149-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

When .probe fails the driver core cares about unsetting drvdata again.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1e90d2b78625..809493d86d22 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -390,7 +390,6 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	const struct imx_pwm_data *data;
 	struct imx_chip *imx;
 	struct resource *r;
-	int ret = 0;
 
 	if (!of_id)
 		return -ENODEV;
@@ -401,6 +400,8 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (imx == NULL)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, imx);
+
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg)) {
 		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
@@ -431,12 +432,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	ret = pwmchip_add(&imx->chip);
-	if (ret < 0)
-		return ret;
-
-	platform_set_drvdata(pdev, imx);
-	return 0;
+	return pwmchip_add(&imx->chip);
 }
 
 static int imx_pwm_remove(struct platform_device *pdev)
-- 
2.20.1
