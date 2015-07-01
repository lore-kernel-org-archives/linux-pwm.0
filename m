From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 02/15] pwm: fix pwm_get_period and pwm_get_duty_cycle prototypes
Date: Wed,  1 Jul 2015 10:21:48 +0200
Message-ID: <1435738921-25027-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

The pwm argument is not modified in pwm_get helpers, make it a const
argument so that they can be used from the sysfs functions.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/pwm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index ec34f4d..d8f6913 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -103,7 +103,7 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 		pwm->period = period;
 }
 
-static inline unsigned int pwm_get_period(struct pwm_device *pwm)
+static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->period : 0;
 }
@@ -114,7 +114,7 @@ static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 		pwm->duty_cycle = duty;
 }
 
-static inline unsigned int pwm_get_duty_cycle(struct pwm_device *pwm)
+static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	return pwm ? pwm->duty_cycle : 0;
 }
-- 
1.9.1
