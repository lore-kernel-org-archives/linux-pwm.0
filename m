Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] pwm: document the pin state after pwm_disable() to be
 undefined
Date: Mon, 20 Aug 2018 16:43:56 +0200
Message-Id: <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
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

Contrarily to the common assumption that pwm_disable() stops the
output at the state where it just happens to be, this isn't what the
hardware does on some machines. For example on i.MX6 the pin goes to
0 level instead.

Note this doesn't reduce the expressiveness of the pwm-API because if
you want the PWM-Pin to stay at a given state, you are supposed to
configure it to 0% or 100% duty cycle without calling pwm_disable().
The backend driver is free to implement potential power savings
already when the duty cycle changes to one of these two cases so this
doesn't come at an increased runtime power cost (once the respective
drivers are fixed).

In return this allows to adhere to the API more easily for drivers that
currently cannot know if it's ok to disable the hardware on
pwm_disable() because the caller might or might not rely on the pin
stopping at a certain level.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/pwm.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
index 8fbf0aa3ba2d..36cbcd353e37 100644
--- a/Documentation/pwm.txt
+++ b/Documentation/pwm.txt
@@ -49,11 +49,15 @@ After being requested, a PWM has to be configured using::
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
 
+Note that it is explicitly undefined what happens to the PWM pin when the
+pwm-device is disabled, even if the duty cycle was configured to 0% or 100%
+before. It might stay at the last configured state, it might go to 0 or High-Z.
+
 The pwm_config(), pwm_enable() and pwm_disable() functions are just wrappers
 around pwm_apply_state() and should not be used if the user wants to change
 several parameter at once. For example, if you see pwm_config() and
-pwm_{enable,disable}() calls in the same function, this probably means you
-should switch to pwm_apply_state().
+pwm_enable() calls in the same function, this probably means you should switch
+to pwm_apply_state().
 
 The PWM user API also allows one to query the PWM state with pwm_get_state().
 
-- 
2.18.0
