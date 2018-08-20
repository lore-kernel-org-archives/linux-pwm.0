Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] pwm: warn callers of pwm_apply_state() that expect a
 certain level after disabling
Date: Mon, 20 Aug 2018 16:43:57 +0200
Message-Id: <20180820144357.7206-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
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
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

If a pwm-API user changes the duty cycle to 0% or 100% and setting the
state to disabled, probably the old implicit behaviour is expected that
the pin state stays where it is after pwm_disable().

While there might be some users that trigger this warning as false
positive, it is probably good to have this anyhow at least until the
newly introduced undefined behaviour sunk in a bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..a076d58127ac 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -475,6 +475,18 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	if (!memcmp(state, &pwm->state, sizeof(*state)))
 		return 0;
 
+	/*
+	 * If period, duty_cycle and/or polarity changes and the pwm should be
+	 * disabled the user might expect something that is explicitly undefined
+	 * (i.e. a certain state of the pin in disabled state).
+	 */
+	WARN_ONCE((state->period != pwm->state.period ||
+		   state->duty_cycle != pwm->state.duty_cycle ||
+		   state->polarity != pwm->state.polarity) &&
+		  (state->duty_cycle == 0 ||
+		   state->duty_cycle == state->period) &&
+		  state->enabled == false, "%s: config changed for disabled pin", pwm->label);
+
 	if (pwm->chip->ops->apply) {
 		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
 		if (err)
-- 
2.18.0
