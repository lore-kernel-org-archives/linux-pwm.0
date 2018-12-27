From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock calculation
Date: Thu, 27 Dec 2018 19:13:06 +0100
Message-ID: <20181227181319.31095-15-paul@crapouillou.net>
References: <20181227181319.31095-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181227181319.31095-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v9: New patch

 drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index c6136bd4434b..dd80a2cf6528 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = jz4740->clks[pwm->hwpwm],
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, new_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
 
 	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	for (;;) {
+		tmp = (unsigned long long)rate * state->period;
+		do_div(tmp, 1000000000);
+
+		if (tmp <= 0xffff)
+			break;
+
+		new_rate = clk_round_rate(clk, rate - 1);
+
+		if (new_rate < rate)
+			rate = new_rate;
+		else
+			return -EINVAL;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	period = tmp;
 
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
-- 
2.11.0
