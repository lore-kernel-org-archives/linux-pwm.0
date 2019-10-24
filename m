Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] pwm: rcar: Drop useless call to pwm_get_state
Date: Thu, 24 Oct 2019 09:14:09 +0200
Message-Id: <20191024071410.30620-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

pwm_get_state has no side effects and the resulting pwm_state is unused.
So drop the call to pwm_get_state and the local variable from
rcar_pwm_apply().

The call was introduced in commit 7f68ce8287d3 ("pwm: rcar: Add support
"atomic" API") and already then was useless.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 852eb2347954..6fac8eb98d54 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -161,11 +161,9 @@ static int rcar_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-	struct pwm_state cur_state;
 	int div, ret;
 
 	/* This HW/driver only supports normal polarity */
-	pwm_get_state(pwm, &cur_state);
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -ENOTSUPP;
 
-- 
2.23.0
