From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 077/459] pwm: omap-dmtimer: Simplify error handling
Date: Fri, 14 Feb 2020 10:55:27 -0500
Message-ID: <20200214160149.11681-77-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit c4cf7aa57eb83b108d2d9c6c37c143388fee2a4d ]

Instead of doing error handling in the middle of ->probe(), move error
handling and freeing the reference to timer to the end.

This fixes a resource leak as dm_timer wasn't freed when allocating
*omap failed.

Implementation note: The put: label was never reached without a goto and
ret being unequal to 0, so the removed return statement is fine.

Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode timers")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 00772fc534906..6cfeb0e1cc679 100644
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
2.20.1
