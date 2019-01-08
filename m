Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:10798 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727535AbfAHDbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jan 2019 22:31:08 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue,  8 Jan 2019 12:28:14 +0900
Message-Id: <1546918094-13960-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH v2 4/4] pwm: rcar: improve calculation of divider
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The rcar_pwm_get_clock_division() has a loop to calculate the divider,
but the value of div should be calculatable without a loop. So,
this patch improves it.

This algorithm is suggested by Uwe Kleine-König and Laurent Pinchart.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 6dbb70c..0498a93 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -68,19 +70,15 @@ static void rcar_pwm_update(struct rcar_pwm_chip *rp, u32 mask, u32 data,
 static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
 {
 	unsigned long clk_rate = clk_get_rate(rp->clk);
-	unsigned long long max; /* max cycle / nanoseconds */
-	unsigned int div;
+	u64 div, tmp;
 
 	if (clk_rate == 0)
 		return -EINVAL;
 
-	for (div = 0; div <= RCAR_PWM_MAX_DIVISION; div++) {
-		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
-			(1 << div);
-		do_div(max, clk_rate);
-		if (period_ns <= max)
-			break;
-	}
+	div = NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
+	tmp = (u64)period_ns * clk_rate + div - 1;
+	tmp = div64_u64(tmp, div);
+	div = ilog2(tmp - 1) + 1;
 
 	return (div <= RCAR_PWM_MAX_DIVISION) ? div : -ERANGE;
 }
-- 
1.9.1
