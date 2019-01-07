Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/4] pwm: don't use memcmp to compare struct state variables
Date: Mon,  7 Jan 2019 20:49:37 +0100
Message-Id: <20190107194938.3004-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
References: <20190107194938.3004-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Given that struct pwm_state is sparse (at least on some platforms)
variables of this type might represent the same state because all fields
are pairwise identical but still memcmp returns a difference because some
of the unused bits are different.

To prevent surprises compare member by member instead of the whole occupied
memory.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1581f6ab1b1f..253a459fe0d8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -472,7 +472,10 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 	    state->duty_cycle > state->period)
 		return -EINVAL;
 
-	if (!memcmp(state, &pwm->state, sizeof(*state)))
+	if (state->period == pwm->state.period &&
+	    state->duty_cycle == pwm->state.duty_cycle &&
+	    state->polarity == pwm->state.polarity &&
+	    state->enabled == pwm->state.enabled)
 		return 0;
 
 	if (pwm->chip->ops->apply) {
-- 
2.20.1
