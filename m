Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:61244 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbeLGIcC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Dec 2018 03:32:02 -0500
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri,  7 Dec 2018 17:29:29 +0900
Message-Id: <1544171373-29618-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1544171373-29618-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 1/5] pwm: rcar: add rcar_pwm_calc_counter() to calculate PWMCNT value only
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To add a workaround in the future, this patch adds a function
rcar_pwm_calc_counter() from rcar_pwm_set_counter().
The rcar_pwm_calc_counter() calculates PWMCNT value only, and
rcar_pwm_set_counter() set the PWMCNT register by using
the calculated value. No change in behavior.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pwm/pwm-rcar.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index a41812f..9cf4567 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -36,6 +36,7 @@ struct rcar_pwm_chip {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
+	u32 pwmcnt;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
@@ -102,8 +103,8 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
-				int period_ns)
+static void rcar_pwm_calc_counter(struct rcar_pwm_chip *rp, int div,
+				  int duty_ns, int period_ns)
 {
 	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */
 	unsigned long clk_rate = clk_get_rate(rp->clk);
@@ -120,11 +121,17 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 	do_div(tmp, one_cycle);
 	ph = tmp & RCAR_PWMCNT_PH0_MASK;
 
+	rp->pwmcnt = cyc | ph;
+}
+
+static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp)
+{
 	/* Avoid prohibited setting */
-	if (cyc == 0 || ph == 0)
+	if ((rp->pwmcnt & RCAR_PWMCNT_CYC0_MASK) == 0 ||
+	    (rp->pwmcnt & RCAR_PWMCNT_PH0_MASK) == 0)
 		return -EINVAL;
 
-	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+	rcar_pwm_write(rp, rp->pwmcnt, RCAR_PWMCNT);
 
 	return 0;
 }
@@ -159,7 +166,8 @@ static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
 
-	ret = rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
+	rcar_pwm_calc_counter(rp, div, duty_ns, period_ns);
+	ret = rcar_pwm_set_counter(rp);
 	if (!ret)
 		rcar_pwm_set_clock_control(rp, div);
 
-- 
1.9.1
