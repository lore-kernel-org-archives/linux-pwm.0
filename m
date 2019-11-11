Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/4] pwm: omap-dmtimer: simplify error handling
Date: Mon, 11 Nov 2019 10:03:55 +0100
Message-Id: <20191111090357.13903-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, kernel@pengutronix.de, Markus Elfring <elfring@users.sourceforge.net>
List-ID: <linux-pwm.vger.kernel.org>

Instead of doing error handling in the middle of
pwm_omap_dmtimer_probe() move error handling and freeing the reference
to timer to the end.

This fixes a resource leak as dm_timer wasn't freed when allocating
*omap failed.

Implementation note: The put: label was never reached without a goto and
ret being unequal to 0, so the removed return statement is fine.

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index bdf94c78655f..e36fcad668a6 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -298,15 +298,10 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		goto put;
 	}
 
-put:
-	of_node_put(timer);
-	if (ret < 0)
-		return ret;
-
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
-		pdata->free(dm_timer);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_alloc_omap;
 	}
 
 	omap->pdata = pdata;
@@ -339,13 +334,28 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&omap->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
-		omap->pdata->free(omap->dm_timer);
-		return ret;
+		goto err_pwmchip_add;
 	}
 
+	of_node_put(timer);
+
 	platform_set_drvdata(pdev, omap);
 
 	return 0;
+
+err_pwmchip_add:
+
+	/*
+	 * *omap is allocated using devm_kzalloc,
+	 * so no free necessary here
+	 */
+err_alloc_omap:
+
+	pdata->free(dm_timer);
+put:
+	of_node_put(timer);
+
+	return ret;
 }
 
 static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
-- 
2.23.0
