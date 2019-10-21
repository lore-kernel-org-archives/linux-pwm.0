Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfJUK6e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:58:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so3609679wrs.9
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:58:33 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 21 Oct 2019 12:58:30 +0200
Message-Id: <20191021105830.1357795-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH] Revert "pwm: Let pwm_get_state() return the last implemented state"
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org

It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
the last implemented state") causes backlight failures on a number of
boards. The reason is that some of the drivers do not write the full
state through to the hardware registers, which means that ->get_state()
subsequently does not return the correct state. Consumers which rely on
pwm_get_state() returning the current state will therefore get confused
and subsequently try to program a bad state.

Before this change can be made, existing drivers need to be more
carefully audited and fixed to behave as the framework expects. Until
then, keep the original behaviour of returning the software state that
was applied rather than reading the state back from hardware.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6ad51aa60c03..f877e77d9184 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -472,14 +472,7 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		if (err)
 			return err;
 
-		/*
-		 * .apply might have to round some values in *state, if possible
-		 * read the actually implemented value back.
-		 */
-		if (chip->ops->get_state)
-			chip->ops->get_state(chip, pwm, &pwm->state);
-		else
-			pwm->state = *state;
+		pwm->state = *state;
 	} else {
 		/*
 		 * FIXME: restore the initial state in case of error.
-- 
2.23.0
