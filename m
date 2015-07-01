From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [RFC PATCH 10/15] pwm: add the PWM initial state retrieval infra
Date: Wed,  1 Jul 2015 10:21:56 +0200
Message-ID: <1435738921-25027-11-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Add a ->init_state() function to the pwm_ops struct to let PWM drivers
initialize the PWM state attached to a PWM device.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 3 +++
 include/linux/pwm.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3e830ce..30631f5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -264,6 +264,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm_set_default_polarity(pwm, polarity);
 
+		if (chip->ops->init_state)
+			chip->ops->init_state(chip, pwm);
+
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0f36a06..b47244a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -177,6 +177,8 @@ struct pwm_ops {
 					  struct pwm_device *pwm);
 	void			(*disable)(struct pwm_chip *chip,
 					   struct pwm_device *pwm);
+	void			(*init_state)(struct pwm_chip *chip,
+					      struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
 	void			(*dbg_show)(struct pwm_chip *chip,
 					    struct seq_file *s);
-- 
1.9.1
