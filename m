Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] pwm: rcar: Document inability to set duty_cycle = 0
Date: Thu, 24 Oct 2019 09:14:10 +0200
Message-Id: <20191024071410.30620-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
References: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
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
To: Thierry Reding <thierry.reding@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

When .apply is called with state->duty_cycle = 0 the duty_ns parameter
to rcar_pwm_set_counter() is 0 which results in ph being 0 and
rcar_pwm_set_counter() returning -EINVAL.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 6fac8eb98d54..2685577b6dd4 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -3,6 +3,9 @@
  * R-Car PWM Timer driver
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * Limitations:
+ * - The hardware cannot generate a 0% duty cycle.
  */
 
 #include <linux/clk.h>
-- 
2.23.0
