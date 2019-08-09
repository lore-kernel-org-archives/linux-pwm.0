From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 7/7] pwm: jz4740: document known limitations
Date: Fri,  9 Aug 2019 14:30:31 +0200
Message-ID: <20190809123031.24219-8-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The jz4740 PMW implementation doesn't fulfill the (up to now
insufficiently documented) requirements of the PWM API. At least
document them in the driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/pwm-jz4740.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 8df898429d47..b331a73a9d5d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -2,6 +2,10 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  *  JZ4740 platform PWM support
+ *
+ * Limitations:
+ * - The .apply callback doesn't complete the currently running period before
+ *   reconfiguring the hardware.
  */
 
 #include <linux/clk.h>
-- 
2.21.0.593.g511ec345e18
