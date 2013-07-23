Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v6 02/20] clocksource: samsung_pwm_timer: Correct definition of AUTORELOAD bit
Date: Wed, 24 Jul 2013 01:32:31 +0200
Message-ID: <2416336.ny4L9Sf7Ts@flatron>
In-Reply-To: <51EDA3EA.9020502@linaro.org>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <1658534.7nG6RFjcTc@flatron> <51EDA3EA.9020502@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

PWM channel 4 has its autoreload bit located at different position. This
patch fixes the driver to account for that.

This fixes a problem with the clocksource hanging after it overflows because
it is not reloaded any more.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Changes since v5:
 - Added more detailed comment about bit layout in TCON register.

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 3fa5b07..5d0049f 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -44,10 +44,21 @@
 #define TCFG1_SHIFT(x)	  		((x) * 4)
 #define TCFG1_MUX_MASK	  		0xf
 
+/*
+ * Each channel occupies 4 bits in TCON register, but there is a gap of 4
+ * bits (one channel) after channel 0, so channels have different numbering
+ * when accessing TCON register.
+ *
+ * In addition, the location of autoreload bit for channel 4 (TCON channel 5)
+ * in its set of bits is 2 as opposed to 3 for other channels.
+ */
 #define TCON_START(chan)		(1 << (4 * (chan) + 0))
 #define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
 #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
-#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+#define _TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
+#define _TCON_AUTORELOAD4(chan)		(1 << (4 * (chan) + 2))
+#define TCON_AUTORELOAD(chan)		\
+	((chan < 5) ? _TCON_AUTORELOAD(chan) : _TCON_AUTORELOAD4(chan))
 
 DEFINE_SPINLOCK(samsung_pwm_lock);
 EXPORT_SYMBOL(samsung_pwm_lock);
-- 
1.8.3.2
