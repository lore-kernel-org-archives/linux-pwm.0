From: Pascal Roeleven <dev@pascalroeleven.nl>
Subject: [RFC PATCH 4/4] pwm: sun4i: Delay after writing the period
Date: Tue, 17 Mar 2020 16:59:06 +0100
Message-ID: <20200317155906.31288-5-dev@pascalroeleven.nl>
References: <20200317155906.31288-1-dev@pascalroeleven.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from web0081.zxcs.nl ([185.104.29.10]:55122 "EHLO web0081.zxcs.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgCQQAJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 17 Mar 2020 12:00:09 -0400
In-Reply-To: <20200317155906.31288-1-dev@pascalroeleven.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-sunxi@googlegroups.com, Pascal Roeleven <dev@pascalroeleven.nl>

When disabling, ensure the period write is complete before continuing.
This fixes an issue on some devices when the write isn't complete before
the panel is turned off but the clock gate is still on.

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
---
 drivers/pwm/pwm-sun4i.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a11d00f96..75250fd4c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -299,6 +299,10 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
 
+	/* When disabling, make sure the period register is written first */
+	if (!state->enabled && cstate.enabled)
+		sun4i_pwm_wait(next_period);
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 	else
@@ -320,6 +324,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 
 	/* We need a full period to elapse before disabling the channel. */
+	next_period = jiffies + usecs_to_jiffies(cstate.period / 1000 + 1);
 	sun4i_pwm_wait(next_period);
 
 	spin_lock(&sun4i_pwm->ctrl_lock);
-- 
2.20.1
