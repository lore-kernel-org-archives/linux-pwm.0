From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: imx27: fix clk handling in pwm_imx27_apply()
Date: Sun,  9 Feb 2020 22:31:06 +0100
Message-ID: <20200209213106.5067-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34661 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgBIVbT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Feb 2020 16:31:19 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

pwm_imx27_apply() enables the clocks if the previous PWM state was
disabled. Given that the clocks are supposed to be left on iff the PWM
is running, the decision to disable the clocks at the end of the
function must not depend on the previous state.

Without this fix the enable count of the two affected clocks increases
by one whenever pwm_apply changes from one disabled state to another.

Fixes: bd88d319abe9 ("pwm: imx27: Unconditionally write state to hardware")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 35a7ac42269c..7e5ed0152977 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
-	if (!state->enabled && cstate.enabled)
+	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(chip);
 
 	return 0;
-- 
2.24.0
