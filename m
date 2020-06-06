From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/16] pwm: crc: Enable/disable PWM output on enable/disable
Date: Sat,  6 Jun 2020 22:25:55 +0200
Message-ID: <20200606202601.48410-11-hdegoede@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The pwm-crc code is using 2 different enable bits:
1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
2. bit 0 of the BACKLIGHT_EN register

So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
this commit makes crc_pwm_disable() clear it on disable and makes
crc_pwm_enable() set it again on re-enable.

This should disable the internal (divided) PWM clock and tri-state the
PWM output pin when disabled, saving some power.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index ef49a6e3c4d6..53734bcf67e1 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -41,10 +41,24 @@ static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
 	return container_of(pc, struct crystalcove_pwm, chip);
 }
 
+static int crc_pwm_calc_clk_div(int period_ns)
+{
+	int clk_div;
+
+	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
+	/* clk_div 1 - 128, maps to register values 0-127 */
+	if (clk_div > 0)
+		clk_div--;
+
+	return clk_div;
+}
+
 static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
 
 	return 0;
@@ -53,8 +67,10 @@ static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
 }
 
 static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
@@ -70,16 +86,10 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 	}
 
 	if (pwm_get_period(pwm) != period_ns) {
-		int clk_div;
+		int clk_div = crc_pwm_calc_clk_div(period_ns);
 
 		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
-
-		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
-		/* clk_div 1 - 128, maps to register values 0-127 */
-		if (clk_div > 0)
-			clk_div--;
-
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
 	}
-- 
2.26.2
