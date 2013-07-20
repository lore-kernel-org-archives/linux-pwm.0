Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 01/20] clocksource: samsung_pwm_timer: Do not request PWM mem region
Date: Sat, 20 Jul 2013 02:04:13 +0200
Message-Id: <1374278673-25615-2-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

PWM registers are shared between clocksource and PWM drivers and so can
not be claimed for exclusive use.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 584b547..3fa5b07 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -404,7 +404,6 @@ void __init samsung_pwm_clocksource_init(void __iomem *base,
 static void __init samsung_pwm_alloc(struct device_node *np,
 				     const struct samsung_pwm_variant *variant)
 {
-	struct resource res;
 	struct property *prop;
 	const __be32 *cur;
 	u32 val;
@@ -423,17 +422,9 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 		pwm.variant.output_mask |= 1 << val;
 	}
 
-	of_address_to_resource(np, 0, &res);
-	if (!request_mem_region(res.start,
-				resource_size(&res), "samsung-pwm")) {
-		pr_err("%s: failed to request IO mem region\n", __func__);
-		return;
-	}
-
-	pwm.base = ioremap(res.start, resource_size(&res));
+	pwm.base = of_iomap(np, 0);
 	if (!pwm.base) {
 		pr_err("%s: failed to map PWM registers\n", __func__);
-		release_mem_region(res.start, resource_size(&res));
 		return;
 	}
 
-- 
1.8.3.2
