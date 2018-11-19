Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Nov 2018 20:58:05 +0100
Message-Id: <20181119195808.16436-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH 1/4] pwm: imx: remove if block where the condition is always
 wrong
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

.remove is only called when probe returned successfully. In this case the
driver data cannot be NULL.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 1d5242c9cde0..7296578571f0 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -312,8 +312,6 @@ static int imx_pwm_remove(struct platform_device *pdev)
 	struct imx_chip *imx;
 
 	imx = platform_get_drvdata(pdev);
-	if (imx == NULL)
-		return -ENODEV;
 
 	return pwmchip_remove(&imx->chip);
 }
-- 
2.19.1
