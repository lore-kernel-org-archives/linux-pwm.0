Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/4] pwm: omap-dmtimer: put_device() after
 of_find_device_by_node()
Date: Mon, 11 Nov 2019 10:03:56 +0100
Message-Id: <20191111090357.13903-3-u.kleine-koenig@pengutronix.de>
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

This was found by coccicheck:

	drivers/pwm/pwm-omap-dmtimer.c:304:2-8: ERROR: missing put_device;
	call of_find_device_by_node on line 255, but without a corresponding
	object release within this function.

Reported-by: Markus Elfring <elfring@users.sourceforge.net>
Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e36fcad668a6..88a3c5690fea 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -256,7 +256,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!timer_pdev) {
 		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
 		ret = -ENODEV;
-		goto put;
+		goto err_find_timer_pdev;
 	}
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
@@ -264,7 +264,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev,
 			 "dmtimer pdata structure NULL, deferring probe\n");
 		ret = -EPROBE_DEFER;
-		goto put;
+		goto err_platdata;
 	}
 
 	pdata = timer_pdata->timer_ops;
@@ -283,19 +283,19 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	    !pdata->write_counter) {
 		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
 		ret = -EINVAL;
-		goto put;
+		goto err_platdata;
 	}
 
 	if (!of_get_property(timer, "ti,timer-pwm", NULL)) {
 		dev_err(&pdev->dev, "Missing ti,timer-pwm capability\n");
 		ret = -ENODEV;
-		goto put;
+		goto err_timer_property;
 	}
 
 	dm_timer = pdata->request_by_node(timer);
 	if (!dm_timer) {
 		ret = -EPROBE_DEFER;
-		goto put;
+		goto err_request_timer;
 	}
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
@@ -352,7 +352,14 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 err_alloc_omap:
 
 	pdata->free(dm_timer);
-put:
+err_request_timer:
+
+err_timer_property:
+err_platdata:
+
+	put_device(&timer_pdev->dev);
+err_find_timer_pdev:
+
 	of_node_put(timer);
 
 	return ret;
@@ -372,6 +379,8 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 
 	omap->pdata->free(omap->dm_timer);
 
+	put_device(&omap->dm_timer_pdev->dev);
+
 	mutex_destroy(&omap->mutex);
 
 	return 0;
-- 
2.23.0
