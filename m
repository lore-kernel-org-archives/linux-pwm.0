From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/6] pwm: omap-dmtimer: Update description for pwm omap dm timer
Date: Fri, 28 Feb 2020 15:26:47 +0530
Message-ID: <20200228095651.32464-3-lokeshvutla@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228095651.32464-1-lokeshvutla@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pwm@vger.kernel.org

Update the description with a brief about how pwm is generated
using OMAP DM timer. Also add link to the Reference Manual.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index e4f5f710bfaa..a24a630ccdb9 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -10,7 +10,11 @@
  *
  * Description:
  *   This file is the core OMAP support for the generic, Linux
- *   PWM driver / controller, using the OMAP's dual-mode timers.
+ *   PWM driver / controller, using the OMAP's dual-mode timers
+ *   with a timer counter that goes up. When it overflows it gets
+ *   reloaded with the load value and the pwm output goes up.
+ *   When counter matches with match register, the output goes down.
+ *   Reference Manual: http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
  */
 
 #include <linux/clk.h>
-- 
2.23.0
