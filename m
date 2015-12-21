From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] pwm: omap-dmtimer: Potential NULL dereference on error
Date: Mon, 21 Dec 2015 16:13:04 +0300
Message-ID: <20151221131304.GA27286@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

"omap" is NULL so we can't dereference it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
It's weird that request_by_node() and free() are allocate/free pairs.
Also this was Thierry's last minute tweaks mentioned in the changelog,
Neil Armstrong is innocent.  :P

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index c453b33..826634e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -243,7 +243,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
-		omap->pdata->free(dm_timer);
+		pdata->free(dm_timer);
 		return -ENOMEM;
 	}
 
