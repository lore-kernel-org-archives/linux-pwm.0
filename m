From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/4] pwm: jz4740: Improve algorithm of clock calculation
Date: Mon, 23 Mar 2020 15:24:19 +0100
Message-ID: <20200323142421.42817-2-paul@crapouillou.net>
References: <20200323142421.42817-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:44088 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWOYf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 10:24:35 -0400
In-Reply-To: <20200323142421.42817-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

This code relies on the fact that clk_round_rate() will always round
down, which is not a valid assumption given by the clk API, but only
happens to be true with the clk drivers used for Ingenic SoCs.

Right now, there is no alternative as the clk API does not have a
round-down function (and won't have one for a while), but if it ever
comes to light, a round-down function should be used instead.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v4: New patch

 drivers/pwm/pwm-jz4740.c | 44 ++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index ee50ac5fabb6..0b41baf40e4a 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -111,28 +111,42 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
-	struct clk *clk = pwm_get_chip_data(pwm),
-		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
-	unsigned long long tmp;
-	unsigned int prescaler = 0;
+	struct clk *clk = pwm_get_chip_data(pwm);
+	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
+	unsigned long period, duty;
 	uint16_t ctrl;
+	long rate;
 	int err;
 
-	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	/*
+	 * Limit the clock to a maximum rate that still gives us a period value
+	 * which fits in 16 bits.
+	 */
+	do_div(tmp, state->period);
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	/*
+	 * /!\ IMPORTANT NOTE:
+	 * -------------------
+	 * This code relies on the fact that clk_round_rate() will always round
+	 * down, which is not a valid assumption given by the clk API, but only
+	 * happens to be true with the clk drivers used for Ingenic SoCs.
+	 *
+	 * Right now, there is no alternative as the clk API does not have a
+	 * round-down function (and won't have one for a while), but if it ever
+	 * comes to light, a round-down function should be used instead.
+	 */
+	rate = clk_round_rate(clk, tmp);
+	if (rate < 0) {
+		dev_err(chip->dev, "Unable to round rate: %ld", rate);
+		return rate;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	/* Calculate period value */
+	tmp = (unsigned long long)rate * state->period;
+	do_div(tmp, NSEC_PER_SEC);
+	period = (unsigned long)tmp;
 
+	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
 	duty = period - tmp;
-- 
2.25.1
