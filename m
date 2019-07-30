Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: jz4740: document known limitations
Date: Tue, 30 Jul 2019 14:32:29 +0200
Message-Id: <20190730123229.31839-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1564435163.6633.4@crapouillou.net>
References: <1564435163.6633.4@crapouillou.net>
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
To: Thierry Reding <thierry.reding@gmail.com>, Paul Cercueil <paul@crapouillou.net>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

The jz4740 PMW implementation doesn't fulfill the (up to now
insufficiently documented) requirements of the PWM API. At least
document them in the driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
I intended to also add a Link to the reference manual, Paul suggested to
use https://zcrc.me/~paul/jz_docs/ in December last year, but this
stopped to work.

The second item is something I noticed when reading through the manual,
but it's not confirmed in practise. A test that this is indeed the case
could be done by configuring a long period (say 5s) and a (in
comparison) small duty-cycle (say 1s). If the pwm output isn't active
when the call returns I'd consider this proven.

@Paul: would you mind doing this test?

Best regards
Uwe

 drivers/pwm/pwm-jz4740.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index f901e8a0d33d..9d444d012f92 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -2,6 +2,11 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  *  JZ4740 platform PWM support
+ *
+ * Limitations:
+ * - The .apply callback doesn't complete the currently running period before
+ *   reconfiguring the hardware.
+ * - Each period starts with the inactive part.
  */
 
 #include <linux/clk.h>
-- 
2.20.1
