Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] MAINTAINERS: add a selection of pwm related keywords to
 the PWM entry
Date: Mon, 23 Sep 2019 10:49:35 +0200
Message-Id: <20190923084937.20358-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

This is just a small subset of the relevant functions, but should at
least catch all new code as every consumer has to call pwm_apply_state
(or the legacy function pwm_config) and every PWM provider has to
implement pwm_ops.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b85f2abfe69b..2e8dd2ea4eaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13254,6 +13254,7 @@ F:	drivers/video/backlight/pwm_bl.c
 F:	include/linux/pwm_backlight.h
 F:	drivers/gpio/gpio-mvebu.c
 F:	Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+K:	pwm_(config|apply_state|ops)
 
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
-- 
2.23.0
