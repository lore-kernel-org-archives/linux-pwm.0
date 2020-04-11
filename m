From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] pwm: Add missing '\n' in log messages
Date: Sat, 11 Apr 2020 17:35:28 +0200
Message-ID: <20200411153528.30130-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pwm@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9973c442b455..bca04965bfe6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -537,7 +537,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
 		dev_warn(chip->dev,
-			 "requested disabled, but yielded enabled with duty > 0");
+			 "requested disabled, but yielded enabled with duty > 0\n");
 
 	/* reapply the state that the driver reported being configured. */
 	err = chip->ops->apply(chip, pwm, &s1);
-- 
2.20.1
