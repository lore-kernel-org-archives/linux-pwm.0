From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 06/10] pwm: add the PWM initial state retrieval infra
Date: Mon, 20 Jul 2015 17:32:03 +0200
Message-ID: <1437406327-6207-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56259 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932202AbbGTPcQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 11:32:16 -0400
In-Reply-To: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

Add a ->reset_state() function to the pwm_ops struct to let PWM drivers
initialize the PWM state attached to a PWM device.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/core.c  | 3 +++
 include/linux/pwm.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3e830ce..236a8cf 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -264,6 +264,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm_set_default_polarity(pwm, polarity);
 
+		if (chip->ops->reset_state)
+			chip->ops->reset_state(chip, pwm);
+
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 1e6e9d1..df78211 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -168,6 +168,9 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @reset_state: reset the current PWM state (pwm->state) to the actual
+ *		 hardware state. This function is only called once per
+ *		 PWM device when the PWM chip is registered.
  * @dbg_show: optional routine to show contents in debugfs
  * @owner: helps prevent removal of modules exporting active PWMs
  */
@@ -186,6 +189,8 @@ struct pwm_ops {
 					  struct pwm_device *pwm);
 	void			(*disable)(struct pwm_chip *chip,
 					   struct pwm_device *pwm);
+	void			(*reset_state)(struct pwm_chip *chip,
+					       struct pwm_device *pwm);
 #ifdef CONFIG_DEBUG_FS
 	void			(*dbg_show)(struct pwm_chip *chip,
 					    struct seq_file *s);
-- 
1.9.1
