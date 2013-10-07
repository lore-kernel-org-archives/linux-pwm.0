Return-Path: <thierry.reding@gmail.com>
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 09/12] unicore32: Initialize PWM backlight enable_gpio field
Date: Mon,  7 Oct 2013 13:37:43 +0200
Message-Id: <1381145866-445-10-git-send-email-treding@nvidia.com>
In-Reply-To: <1381145866-445-1-git-send-email-treding@nvidia.com>
References: <1381145866-445-1-git-send-email-treding@nvidia.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

The GPIO API defines 0 as being a valid GPIO number, so this field needs
to be initialized explicitly.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/unicore32/kernel/puv3-nb0916.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/unicore32/kernel/puv3-nb0916.c b/arch/unicore32/kernel/puv3-nb0916.c
index 181108b..0c6618e 100644
--- a/arch/unicore32/kernel/puv3-nb0916.c
+++ b/arch/unicore32/kernel/puv3-nb0916.c
@@ -54,6 +54,7 @@ static struct platform_pwm_backlight_data nb0916_backlight_data = {
 	.max_brightness	= 100,
 	.dft_brightness	= 100,
 	.pwm_period_ns	= 70 * 1024,
+	.enable_gpio	= -1,
 };
 
 static struct gpio_keys_button nb0916_gpio_keys[] = {
-- 
1.8.4
