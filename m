From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 1/2] ARM: SAMSUNG: remove gpio flags in dev-backlight
Date: Thu, 27 Feb 2014 14:53:33 +0900
Message-ID: <1393480414-19473-2-git-send-email-acourbot@nvidia.com>
References: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393480414-19473-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-pwm@vger.kernel.org

The pwm-backlight driver is moving to use the gpiod interface,
which has its own mapping mechanism for platform data GPIOs.
These mappings carry GPIO properties like active low so they don't have
to be explicitly handled by GPIO consumers.

Because of this change, the enable_gpio_flags member of
platform_pwm_backlight_data is going away. dev-backlight was passing
this member, but had no user making use of it, so it can safely be
removed. Further GPIOs used by pwm-backlight are expected to be
defined using the mechanisms provided by the gpiod API.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/plat-samsung/dev-backlight.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index be4ad0b21c08..2157c5b539e6 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -124,8 +124,6 @@ void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 		samsung_bl_data->pwm_period_ns = bl_data->pwm_period_ns;
 	if (bl_data->enable_gpio >= 0)
 		samsung_bl_data->enable_gpio = bl_data->enable_gpio;
-	if (bl_data->enable_gpio_flags)
-		samsung_bl_data->enable_gpio_flags = bl_data->enable_gpio_flags;
 	if (bl_data->init)
 		samsung_bl_data->init = bl_data->init;
 	if (bl_data->notify)
-- 
1.9.0
