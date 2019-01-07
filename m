Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/4] pwm: imx: don't print an error on -EPROBE_DEFER
Date: Mon,  7 Jan 2019 20:53:51 +0100
Message-Id: <20190107195352.3149-4-u.kleine-koenig@pengutronix.de>
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

When getting the peripheral clock fails with -EPROBE_DEFER the driver is
usually probed again later and emitting an error message is more irritating
than helpful.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 809493d86d22..10ac039e7ddb 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -411,9 +411,12 @@ static int imx_pwm_probe(struct platform_device *pdev)
 
 	imx->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(imx->clk_per)) {
-		dev_err(&pdev->dev, "getting per clock failed with %ld\n",
-				PTR_ERR(imx->clk_per));
-		return PTR_ERR(imx->clk_per);
+		int ret = PTR_ERR(imx->clk_per);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "getting per clock failed (%d)\n",
+				ret);
+		return ret;
 	}
 
 	imx->chip.ops = data->ops;
-- 
2.20.1
