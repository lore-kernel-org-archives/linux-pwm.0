From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 10/16] pwm: crc: Enable/disable PWM output on enable/disable
Date: Wed,  8 Jul 2020 23:14:26 +0200
Message-ID: <20200708211432.28612-11-hdegoede@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200708211432.28612-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

The pwm-crc code is using 2 different enable bits:
1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
2. bit 0 of the BACKLIGHT_EN register

So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
this commit makes crc_pwm_disable() clear it on disable and makes
crc_pwm_enable() set it again on re-enable.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Remove paragraph about tri-stating the output from the commit message,
  we don't have a datasheet so this was just an unfounded guess
---
 drivers/pwm/pwm-crc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 81232da0c767..b72008c9b072 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -54,7 +54,9 @@ static int crc_pwm_calc_clk_div(int period_ns)
 static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
 
 	return 0;
@@ -63,8 +65,10 @@ static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
 static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
+	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
 
 	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
+	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
 }
 
 static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
-- 
2.26.2
