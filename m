Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/4] pwm: omap-dmtimer: Allow compiling with COMPILE_TEST
Date: Mon, 11 Nov 2019 10:03:57 +0100
Message-Id: <20191111090357.13903-4-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, kernel@pengutronix.de, Markus Elfring <elfring@users.sourceforge.net>
List-ID: <linux-pwm.vger.kernel.org>

The dependency on OMAP_DM_TIMER is only a runtime dependency. Also
OMAP_DM_TIMER cannot be enabled without ARCH_OMAP being enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e3a2518503ed..e49cbdb1ce29 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -328,7 +328,8 @@ config PWM_MXS
 
 config PWM_OMAP_DMTIMER
 	tristate "OMAP Dual-Mode Timer PWM support"
-	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
+	depends on OF
+	depends on OMAP_DM_TIMER || COMPILE_TEST
 	help
 	  Generic PWM framework driver for OMAP Dual-Mode Timer PWM output
 
-- 
2.23.0
