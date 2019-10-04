From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 5/6] pwm: mxs: avoid a division in mxs_pwm_apply()
Date: Fri,  4 Oct 2019 15:32:06 +0200
Message-ID: <20191004133207.6663-6-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Since the divisor is not a compile-time constant (unless gcc somehow
decided to unroll the loop PERIOD_CDIV_MAX times), this does a
somewhat expensive 32/32 division. Replace that with a right shift.

We still have a 64/32 division just below, but at least in that
case the divisor is compile-time constant.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 57562221c439..f2e57fcf8f8b 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -33,8 +33,8 @@
 #define  PERIOD_CDIV(div)	(((div) & 0x7) << 20)
 #define  PERIOD_CDIV_MAX	8
 
-static const unsigned int cdiv[PERIOD_CDIV_MAX] = {
-	1, 2, 4, 8, 16, 64, 256, 1024
+static const u8 cdiv_shift[PERIOD_CDIV_MAX] = {
+	0, 1, 2, 3, 4, 6, 8, 10
 };
 
 struct mxs_pwm_chip {
@@ -71,7 +71,7 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	rate = clk_get_rate(mxs->clk);
 	while (1) {
-		c = rate / cdiv[div];
+		c = rate >> cdiv_shift[div];
 		c = c * state->period;
 		do_div(c, 1000000000);
 		if (c < PERIOD_PERIOD_MAX)
-- 
2.20.1
