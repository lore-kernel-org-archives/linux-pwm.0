From: Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [RFC PATCH 2/4] pwm: sun4i: Disable pwm before turning off clock gate
Date: Tue, 17 Mar 2020 16:59:04 +0100
Message-ID: <20200317155906.31288-3-dev@pascalroeleven.nl>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from web0081.zxcs.nl ([185.104.29.10]:54908 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgCQQAC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:02 -0400
In-Reply-To: <20200317155906.31288-1-dev@pascalroeleven.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-sunxi@googlegroups.com, Pascal Roeleven <dev@pascalroeleven.nl>

The clock gate must stay on when disabling to ensure proper turning off.
After one period it will still be disabled anyway.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/pwm/pwm-sun4i.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 5c677c563..56942036b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -292,13 +292,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 
-	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-
 	if (state->enabled) {
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+		ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	} else {
+		/* Turn gate off after delay to ensure proper turning off */
 		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-- 
2.20.1
