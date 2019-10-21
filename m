Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37205 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so12290399wmc.2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:42 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 21 Oct 2019 12:57:36 +0200
Message-Id: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 1/4] pwm: Read initial hardware state at request time
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

The PWM core doesn't need to know about the hardware state of a PWM
unless there is a user for it. Defer initial hardware readout until
a PWM is requested.

As a side-effect, this allows the ->get_state() callback to rely on
per-PWM data.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f877e77d9184..e067873c6cc5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -114,6 +114,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		}
 	}
 
+	if (pwm->chip->ops->get_state)
+		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
+
 	set_bit(PWMF_REQUESTED, &pwm->flags);
 	pwm->label = label;
 
@@ -283,9 +286,6 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
 
-		if (chip->ops->get_state)
-			chip->ops->get_state(chip, pwm, &pwm->state);
-
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
-- 
2.23.0
