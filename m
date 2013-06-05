Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 11/15] pwm: Remove superseded pwm-samsung-legacy driver
Date: Wed,  5 Jun 2013 23:18:16 +0200
Message-Id: <1370467100-10820-12-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, thierry.reding@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>

This patch removes the now unused pwm-samsung-legacy driver, which was
replaced by new pwm-samsung driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pwm/Makefile             |   1 -
 drivers/pwm/pwm-samsung-legacy.c | 353 ---------------------------------------
 2 files changed, 354 deletions(-)
 delete mode 100644 drivers/pwm/pwm-samsung-legacy.c

diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 833c3ac..94ba21e 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,7 +8,6 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
-obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung-legacy.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
diff --git a/drivers/pwm/pwm-samsung-legacy.c b/drivers/pwm/pwm-samsung-legacy.c
deleted file mode 100644
index a0ece50..0000000
-- 
1.8.2.1
