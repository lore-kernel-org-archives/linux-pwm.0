Return-Path: <thierry.reding@gmail.com>
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 05/12] ARM: OMAP: Initialize PWM backlight enable_gpio field
Date: Mon,  7 Oct 2013 13:37:39 +0200
Message-Id: <1381145866-445-6-git-send-email-treding@nvidia.com>
In-Reply-To: <1381145866-445-1-git-send-email-treding@nvidia.com>
References: <1381145866-445-1-git-send-email-treding@nvidia.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index a90375d..5ed2884 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -227,6 +227,7 @@ static struct platform_pwm_backlight_data zoom_backlight_data = {
 	.max_brightness = 127,
 	.dft_brightness = 127,
 	.pwm_period_ns = 7812500,
+	.enable_gpio = -1,
 };
 
 static struct platform_device zoom_backlight_pwm = {
-- 
1.8.4
