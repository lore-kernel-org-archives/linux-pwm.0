From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 13/27] pwm: jz4740: Use clocks from TCU driver
Date: Sat,  2 Mar 2019 20:33:59 -0300
Message-ID: <20190302233413.14813-14-paul@crapouillou.net>
References: <20190302233413.14813-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pwm@vger.kernel.org

The ingenic-timer "TCU" driver provides us with clocks, that can be
(un)gated, reparented or reclocked from devicetree, instead of having
these settings hardcoded in this driver.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Note that the "select REGMAP" has been dropped because it's
already enabled by the "select INGENIC_TIMER".

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
         v9: New patch
    
         v10: Explain in commit message why "select REGMAP" was dropped

 drivers/pwm/Kconfig      |  3 ++-
 drivers/pwm/pwm-jz4740.c | 39 ++++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ace8ea4b6247..4e201e970509 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -204,7 +204,8 @@ config PWM_IMX
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
-	select REGMAP
+	depends on COMMON_CLK
+	select INGENIC_TIMER
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 8dfac5ffd71c..c6136bd4434b 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -28,7 +28,7 @@
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
-	struct clk *clk;
+	struct clk *clks[NUM_PWM];
 	struct regmap *map;
 };
 
@@ -40,6 +40,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk;
+	char clk_name[16];
+	int ret;
 
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
@@ -48,16 +51,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
 
+	clk = clk_get(chip->dev, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		clk_put(clk);
+		return ret;
+	}
+
+	jz->clks[pwm->hwpwm] = clk;
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = jz->clks[pwm->hwpwm];
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -92,16 +108,20 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct clk *clk = jz4740->clks[pwm->hwpwm],
+		   *parent_clk = clk_get_parent(clk);
+	unsigned long rate, period, duty;
 	unsigned long long tmp;
-	unsigned long period, duty;
 	unsigned int prescaler = 0;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
+	rate = clk_get_rate(parent_clk);
+	tmp = (unsigned long long)rate * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
 	while (period > 0xffff && prescaler < 6) {
 		period >>= 2;
+		rate >>= 2;
 		++prescaler;
 	}
 
@@ -121,10 +141,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	/* Set clock prescale */
-	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PRESCALE_MASK,
-			   prescaler << TCU_TCSR_PRESCALE_LSB);
+	clk_set_rate(clk, rate);
 
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
@@ -170,10 +187,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
-	if (IS_ERR(jz4740->clk))
-		return PTR_ERR(jz4740->clk);
-
 	jz4740->map = dev_get_regmap(dev->parent, NULL);
 	if (!jz4740->map) {
 		dev_err(dev, "regmap not found\n");
-- 
2.11.0
