Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fallback22.m.smailru.net ([94.100.176.132]:46160 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeLSKji (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Dec 2018 05:39:38 -0500
Received: from [10.161.64.55] (port=50798 helo=smtp47.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <shc_work@mail.ru>)
        id 1gZZGJ-0000d5-Pe
        for linux-pwm@vger.kernel.org; Wed, 19 Dec 2018 13:39:36 +0300
From: Alexander Shiyan <shc_work@mail.ru>
Date: Wed, 19 Dec 2018 13:39:24 +0300
Message-Id: <20181219103925.28360-1-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: [PATCH 1/2] pwm: clps711x: Fix period calculation
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Commit e39c0df1be5a ("pwm: Introduce the pwm_args concept") has
changed the variable for the period for clps711x-pwm driver, so now
pwm_get/set_period() works with pwm->state.period variable instead
of pwm->args.period.
This patch changes the period variable in other places where it is used.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/pwm/pwm-clps711x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 26ec24e457b1..7e16b7def0dc 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -48,7 +48,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm_get_period(pwm));
+	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -71,7 +71,7 @@ static int clps711x_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct clps711x_chip *priv = to_clps711x_chip(chip);
 	unsigned int duty;
 
-	if (period_ns != pwm_get_period(pwm))
+	if (period_ns != pwm->args.period)
 		return -EINVAL;
 
 	duty = clps711x_get_duty(pwm, duty_ns);
-- 
2.13.0
