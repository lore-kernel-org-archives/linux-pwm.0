From: Arthur LAMBERT <lambertarthur22@gmail.com>
Subject: Re: Handle pwm with sysfs with recent kernel
Date: Wed, 9 Jan 2019 10:26:51 +0100
Message-ID: <20190109092651.GA27151@arthur-bzh>
References: <20190108100739.GA9046@arthur-bzh>
 <20190108222102.hwv5oekspifhj7bh@pengutronix.de>
 <20190109092531.71cf52c8@karo-electronics.de>
 <20190109092006.35364dwcfiindd7c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190109092006.35364dwcfiindd7c@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

It is an error due to new check from this commit :

[arthur * dreem-linux-4.19] git show ef2bf4997f7da6efa8540d9cf726c44bf2b863af
commit ef2bf4997f7da6efa8540d9cf726c44bf2b863af
Author: Brian Norris <briannorris@chromium.org>
Date:   Fri May 27 09:45:49 2016 -0700

    pwm: Improve args checking in pwm_apply_state()

    It seems like in the process of refactoring pwm_config() to utilize the
    newly-introduced pwm_apply_state() API, some args/bounds checking was
    dropped.
(...)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index dba3843..ed337a8c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 {
        int err;

-       if (!pwm)
+       if (!pwm || !state || !state->period ||
+           state->duty_cycle > state->period)
                return -EINVAL;

(...)

I guess that I have to configure the period and the duty cycle before
enabling the pwm to be compatible with this kernek. I will update my
userspace code.
