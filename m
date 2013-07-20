Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v4 02/20] clocksource: samsung_pwm_timer: Correct definition of AUTORELOAD bit
Date: Sat, 20 Jul 2013 02:04:14 +0200
Message-Id: <1374278673-25615-3-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>

PWM channel 4 has its autoreload bit located at different position. This
patch fixes the driver to account for that.

This fixes a problem with the clocksource hanging after it overflows because
it is not reloaded any more.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 3fa5b07..e238fb0 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -47,7 +47,8 @@
 #define TCON_START(chan)		(1 << (4 * (chan) + 0))
 #define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
 #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
-#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) \
+						+ (((chan) < 5) ? 3 : 2)))
 
 DEFINE_SPINLOCK(samsung_pwm_lock);
 EXPORT_SYMBOL(samsung_pwm_lock);
-- 
1.8.3.2
