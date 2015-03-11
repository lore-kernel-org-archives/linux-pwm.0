From: Gaetan Hug <ghug@induct.be>
Subject: [PATCH RESEND] pwm: mxs: fix period divider computation
Date: Wed, 11 Mar 2015 13:08:12 +0100
Message-ID: <1426075692-19340-1-git-send-email-ghug@induct.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db3on0117.outbound.protection.outlook.com ([157.55.234.117]:51072
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750960AbbCKMIe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 11 Mar 2015 08:08:34 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, fabio.estevam@freescale.com, Gaetan Hug <ghug@induct.be>

The driver computes which clock divider it sould be using from the
requested period. This computation assumes that the link between the
register value and the actual divider value is raising 2 to the power of
the registry value.

    div = 1 << regvalue

This is true only for the first 5 values out of 8. Next values are 64,
256 and, 1024 - instead of 32, 64, 128.
This affects only the users requesting a period > 0.04369s.

Replace the computation with a look-up table.

Signed-off-by: Gaetan Hug <ghug@induct.be>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/pwm-mxs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index f75ecb0..c65e183 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -35,6 +35,8 @@
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
+static unsigned const int cdiv[PERIOD_CDIV_MAX] = {1, 2, 4, 8, 16, 64, 256, 1024};
+
 struct mxs_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
@@ -54,13 +56,13 @@ static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	rate = clk_get_rate(mxs->clk);
 	while (1) {
-		c = rate / (1 << div);
+		c = rate / cdiv[div];
 		c = c * period_ns;
 		do_div(c, 1000000000);
 		if (c < PERIOD_PERIOD_MAX)
 			break;
 		div++;
-		if (div > PERIOD_CDIV_MAX)
+		if (div >= PERIOD_CDIV_MAX)
 			return -EINVAL;
 	}
 
-- 
1.7.10.4

