Return-Path: <laurent.pinchart+renesas@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 2/4] pwm: Use the DT macro directly when parsing PWM DT flags
Date: Thu, 18 Jul 2013 00:54:22 +0200
Message-Id: <1374101664-21112-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>

Don't redefine a PWM_SPEC_POLARITY macro with a value identical to
PWM_POLARITY_INVERTED, use the PWM DT macro directly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pwm/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dfbfbc5..2ca9504 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -30,10 +30,9 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-#define MAX_PWMS 1024
+#include <dt-bindings/pwm/pwm.h>
 
-/* flags in the third cell of the DT PWM specifier */
-#define PWM_SPEC_POLARITY	(1 << 0)
+#define MAX_PWMS 1024
 
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
@@ -149,7 +148,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 
 	pwm_set_period(pwm, args->args[1]);
 
-	if (args->args[2] & PWM_SPEC_POLARITY)
+	if (args->args[2] & PWM_POLARITY_INVERTED)
 		pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
 	else
 		pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
-- 
1.8.1.5
