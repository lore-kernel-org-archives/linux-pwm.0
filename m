Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Nov 2018 20:58:07 +0100
Message-Id: <20181119195808.16436-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181119195808.16436-1-u.kleine-koenig@pengutronix.de>
References: <20181119195808.16436-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH 3/4] pwm: imx: don't print an error on -EPROBE_DEFER
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
Cc: linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

When getting the peripheral clock fails with -EPROBE_DEFER the driver is
usually probed again later and emitting an error message is more irritating
than helpful.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index bd2650ccc0a2..3fa47ba86f87 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -279,9 +279,12 @@ static int imx_pwm_probe(struct platform_device *pdev)
 
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
2.19.1
