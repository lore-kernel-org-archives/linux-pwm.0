From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 16/35 linux-next] video: constify of_device_id array
Date: Mon, 16 Mar 2015 20:20:32 +0100
Message-ID: <1426533651-25586-7-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Timur Tabi <timur@tabi.org>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/video/backlight/gpio_backlight.c   | 2 +-
 drivers/video/backlight/pwm_bl.c           | 2 +-
 drivers/video/fbdev/fsl-diu-fb.c           | 2 +-
 drivers/video/fbdev/grvga.c                | 2 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 +-
 drivers/video/fbdev/ocfb.c                 | 2 +-
 drivers/video/fbdev/platinumfb.c           | 2 +-
 drivers/video/fbdev/xilinxfb.c             | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 439feb2..4751463 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -142,7 +142,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id gpio_backlight_of_match[] = {
+static const struct of_device_id gpio_backlight_of_match[] = {
 	{ .compatible = "gpio-backlight" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 3a145a6..2f1de60 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -178,7 +178,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	return 0;
 }
 
-static struct of_device_id pwm_backlight_of_match[] = {
+static const struct of_device_id pwm_backlight_of_match[] = {
 	{ .compatible = "pwm-backlight" },
 	{ }
 };
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 7fa2e6f..5783e66 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1865,7 +1865,7 @@ static int __init fsl_diu_setup(char *options)
 }
 #endif
 
-static struct of_device_id fsl_diu_match[] = {
+static const struct of_device_id fsl_diu_match[] = {
 #ifdef CONFIG_PPC_MPC512x
 	{
 		.compatible = "fsl,mpc5121-diu",
diff --git a/drivers/video/fbdev/grvga.c b/drivers/video/fbdev/grvga.c
index b471f92..bced3f3 100644
--- a/drivers/video/fbdev/grvga.c
+++ b/drivers/video/fbdev/grvga.c
@@ -535,7 +535,7 @@ static int grvga_remove(struct platform_device *device)
 	return 0;
 }
 
-static struct of_device_id svgactrl_of_match[] = {
+static const struct of_device_id svgactrl_of_match[] = {
 	{
 		.name = "GAISLER_SVGACTRL",
 	},
diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index 9b8bebd..f56dbea 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -821,7 +821,7 @@ static int of_platform_mb862xx_remove(struct platform_device *ofdev)
 /*
  * common types
  */
-static struct of_device_id of_platform_mb862xx_tbl[] = {
+static const struct of_device_id of_platform_mb862xx_tbl[] = {
 	{ .compatible = "fujitsu,MB86276", },
 	{ .compatible = "fujitsu,lime", },
 	{ .compatible = "fujitsu,MB86277", },
diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index de98196..718ad60 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -395,7 +395,7 @@ static int ocfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id ocfb_match[] = {
+static const struct of_device_id ocfb_match[] = {
 	{ .compatible = "opencores,ocfb", },
 	{},
 };
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 518d1fd..37a77bc 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -667,7 +667,7 @@ static int platinumfb_remove(struct platform_device* odev)
 	return 0;
 }
 
-static struct of_device_id platinumfb_match[] = 
+static const struct of_device_id platinumfb_match[] =
 {
 	{
 	.name 		= "platinum",
diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 17dc119..fe2673b 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -482,7 +482,7 @@ static int xilinxfb_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id xilinxfb_of_match[] = {
+static const struct of_device_id xilinxfb_of_match[] = {
 	{ .compatible = "xlnx,xps-tft-1.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.00.a", },
 	{ .compatible = "xlnx,xps-tft-2.01.a", },
-- 
2.1.0
