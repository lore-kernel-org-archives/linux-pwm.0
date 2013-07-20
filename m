Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 12/20] pwm: samsung: Rename to pwm-samsung-legacy
Date: Sat, 20 Jul 2013 02:04:25 +0200
Message-Id: <1374278673-25615-14-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

This patch renames the old pwm-samsung driver to pwm-samsung-legacy to
create place for the new, rewritten, DT-aware pwm-samsung driver using
Samsung PWM/timer master driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pwm/Makefile                                | 2 +-
 drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} (100%)

diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 77a8c18..aa94807 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
-obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung-legacy.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung-legacy.c
similarity index 100%
rename from drivers/pwm/pwm-samsung.c
rename to drivers/pwm/pwm-samsung-legacy.c
-- 
1.8.3.2
