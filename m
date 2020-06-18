From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 333/388] pwm: Add missing "CONFIG_" prefix
Date: Wed, 17 Jun 2020 21:07:10 -0400
Message-ID: <20200618010805.600873-333-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgFRBPQ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 17 Jun 2020 21:15:16 -0400
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit f5641d053d46a9a18fe13f2ecb4a7b4a66d9cdf7 ]

The IS_ENABLED() use was missing the CONFIG_ prefix which would have
lead to skipping this code.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..6b3cbc0490c6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
 
-		if (IS_ENABLED(PWM_DEBUG))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
 
-- 
2.25.1
