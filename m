Return-Path: <yellowriver2010@hotmail.com>
From: Wen Yang <yellowriver2010@hotmail.com>
Subject: [PATCH] pwm: omap-dmtimer: Add missing put_device()
Date: Sat, 9 Feb 2019 14:17:12 +0000
Message-ID: <HK0PR02MB36347CD96866F06ECAB04EC9B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wen Yang <yellowriver2010@hotmail.com>

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Fixes: b7290cf6ff78 ("pwm: pwm-omap-dmtimer: Adapt driver to utilize dmtime=
r pdata ops")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.=
c
index f457986..f7ca52f 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -303,12 +303,15 @@ static int pwm_omap_dmtimer_probe(struct platform_dev=
ice *pdev)
=20
 put:
 	of_node_put(timer);
-	if (ret < 0)
+	if (ret < 0) {
+		put_device(&timer_pdev->dev);
 		return ret;
+	}
=20
 	omap =3D devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
 	if (!omap) {
 		pdata->free(dm_timer);
+		put_device(&timer_pdev->dev);
 		return -ENOMEM;
 	}
=20
@@ -360,6 +363,8 @@ static int pwm_omap_dmtimer_remove(struct platform_devi=
ce *pdev)
=20
 	omap->pdata->free(omap->dm_timer);
=20
+	put_device(&omap->dm_timer_pdev->dev);
+
 	mutex_destroy(&omap->mutex);
=20
 	return pwmchip_remove(&omap->chip);
--=20
2.7.4
