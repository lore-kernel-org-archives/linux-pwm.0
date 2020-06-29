From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when validating duty cycle
Date: Mon, 29 Jun 2020 13:47:49 +0100
Message-ID: <20200629124752.1018358-2-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgF2Sho (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8AC00F82F
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so15272640wmj.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, bcm-kernel-feedback-list@broadcom.com

'duty' here is an unsigned int, thus checking for <0 will always
evaluate to false.

Fixes the following W=1 warning:

 drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-bcm-iproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee70..46f0a45e9049c 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -143,8 +143,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		value = rate * state->duty_cycle;
 		duty = div64_u64(value, div);
 
-		if (period < IPROC_PWM_PERIOD_MIN ||
-		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
+		if (period < IPROC_PWM_PERIOD_MIN)
 			return -EINVAL;
 
 		if (period <= IPROC_PWM_PERIOD_MAX &&
-- 
2.25.1
