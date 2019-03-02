From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date: Sat,  2 Mar 2019 20:34:00 -0300
Message-ID: <20190302233413.14813-15-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v9: New patch
    
        v10: - New algorithm. Instead of starting with the maximum clock rate
               and using clk_round_rate(rate - 1) to get the next (smaller)
    	   clock, we compute the maximum rate we can use before the
    	   register overflows, and apply it with clk_set_max_rate.
    	   Then we read the new clock rate and compute the register values
    	   of the period and duty from that.
    	 - Use NSEC_PER_SEC instead of magic 1000000000 value

 drivers/pwm/pwm-jz4740.c | 49 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index c6136bd4434b..f497388fc818 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -110,24 +110,45 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = jz4740->clks[pwm->hwpwm],
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
+	int ret;
 
-	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	parent_rate = clk_get_rate(parent_clk);
+
+	jz4740_pwm_disable(chip, pwm);
+
+	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
+	ret = clk_set_rate(clk, parent_rate);
+	if (ret)
+		return ret;
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	/* Limit the clock to a maximum rate that still gives us a period value
+	 * which fits in 16 bits.
+	 */
+	tmp = 0xffffull * NSEC_PER_SEC;
+	do_div(tmp, state->period);
+
+	ret = clk_set_max_rate(clk, tmp);
+	if (ret) {
+		dev_err(chip->dev, "Unable to set max rate: %i\n", ret);
+		return ret;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	/* Read back the clock rate, as it may have been modified by
+	 * clk_set_max_rate()
+	 */
+	rate = clk_get_rate(clk);
 
+	if (rate != parent_rate)
+		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
+
+	/* Calculate period value */
+	tmp = (unsigned long long)rate * state->period;
+	do_div(tmp, NSEC_PER_SEC);
+	period = (unsigned long)tmp;
+
+	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
 	duty = period - tmp;
@@ -135,14 +156,10 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty >= period)
 		duty = period - 1;
 
-	jz4740_pwm_disable(chip, pwm);
-
 	/* Set abrupt shutdown */
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	clk_set_rate(clk, rate);
-
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-- 
2.11.0
