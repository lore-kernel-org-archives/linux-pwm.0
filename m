From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Wed, 22 Jun 2016 10:04:22 +0200
Message-ID: <20160622100422.5c34f975@bbrezillon>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
	<CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
	<20160621183730.GA130978@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:56633 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbcFVIPE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2016 04:15:04 -0400
In-Reply-To: <20160621183730.GA130978@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tue, 21 Jun 2016 11:37:31 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Hi Geert,
> 
> On Tue, Jun 21, 2016 at 04:42:04PM +0200, Geert Uytterhoeven wrote:
> > On Fri, May 27, 2016 at 6:45 PM, Brian Norris <briannorris@chromium.org> wrote:  
> > > It seems like in the process of refactoring pwm_config() to utilize the
> > > newly-introduced pwm_apply_state() API, some args/bounds checking was
> > > dropped.
> > >
> > > In particular, I noted that we are now allowing invalid period
> > > selections. e.g.:
> > >
> > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > >   100
> > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > >   [... driver may or may not reject the value, or trigger some logic bug ...]
> > >
> > > It's better to see:
> > >
> > >   # echo 1 > /sys/class/pwm/pwmchip0/export
> > >   # cat /sys/class/pwm/pwmchip0/pwm1/period
> > >   100
> > >   # echo 101 > /sys/class/pwm/pwmchip0/pwm1/duty_cycle
> > >   -bash: echo: write error: Invalid argument
> > >
> > > This patch reintroduces some bounds checks in both pwm_config() (for its
> > > signed parameters; we don't want to convert negative values into large
> > > unsigned values) and in pwm_apply_state() (which fix the above described
> > > behavior, as well as other potential API misuses).
> > >
> > > Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > v2:
> > >  * changed subject, as this covers more scope now
> > >  * add Fixes tag, as this is a v4.7-rc regression
> > >  * add more bounds/args checks in pwm_apply_state() and pwm_config()
> > >
> > >  drivers/pwm/core.c  | 3 ++-
> > >  include/linux/pwm.h | 3 +++
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index dba3843c53b8..ed337a8c34ab 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -457,7 +457,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> > >  {
> > >         int err;
> > >
> > > -       if (!pwm)
> > > +       if (!pwm || !state || !state->period ||
> > > +           state->duty_cycle > state->period)
> > >                 return -EINVAL;  
> > 
> > This check breaks the LCD backlight on r8a7740/armadillo.
> > Apparently both period and duty_cycle are zero during the first invocation.
> > Later, these are initialized from DT, cfr.
> > 
> >         pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
> > 
> > in arch/arm/boot/dts/r8a7740-armadillo800eva.dts.  
> 
> Hmm, this isn't super obvious how to best fix. On one hand, the
> pwm_config() API used to reject period<=0, but on the other hand, I
> think its replacement (pwm_apply_state()) is getting used in more places
> than it used to be, and not all of them are really handling the "atomic
> update" concept yet. Seems like a product of Boris's multi-phase attempt
> to convert the PWM APIs to support atomic updates -- and many users
> haven't really converted yet.
> 
> > With added debug printing, the difference between failure and success is:
> > 
> >  renesas-tpu-pwm e6600000.pwm: TPU PWM -1 registered
> >  tpu_pwm_request:223
> >  pwm_apply_state:460: pwm backlight/2: period 0, duty_cycle 0
> > +Ignoring failure
> > +pwm_apply_state:479: polarity 0 -> 1
> > +tpu_pwm_set_polarity:343
> > +pwm_apply_state:502: period 0 -> 0
> > +pwm_apply_state:503: duty_cycle 0 -> 0
> > +pwm_apply_state:516: enabled 0 -> 0
> >  pwm_config:238: pwm backlight/2: duty_ns 33333, period_ns 33333
> >  pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
> > -pwm_apply_state:479: polarity 0 -> 0
> > +pwm_apply_state:479: polarity 1 -> 1
> >  pwm_apply_state:502: period 0 -> 33333
> >  pwm_apply_state:503: duty_cycle 0 -> 33333
> >  tpu_pwm_config:267
> >  pwm_apply_state:516: enabled 0 -> 0
> >  pwm_apply_state:460: pwm backlight/2: period 33333, duty_cycle 33333
> > -pwm_apply_state:479: polarity 0 -> 0
> > +pwm_apply_state:479: polarity 1 -> 1
> >  pwm_apply_state:502: period 33333 -> 33333
> >  pwm_apply_state:503: duty_cycle 33333 -> 33333
> >  pwm_apply_state:516: enabled 0 -> 1
> >  tpu_pwm_enable:354  
> 
> I'm not sure I 100% understand this debug log, but I think maybe the
> problem is in pwm_apply_args(), which calls pwm_disable() and
> pwm_set_polarity() sequentially, without ever configuring a period? What
> if pwm_apply_args() were to configure the period for us?
> 
> Boris, any thoughts?
> 

I had second thoughts and I think you're right: pwm_apply_args()
should set the pargs.period period for us.

Here is a patch addressing that.

Geert, can you test it?

--->8---
From 0610f7e24976e176054bce20445ff42d8aea9513 Mon Sep 17 00:00:00 2001
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Wed, 22 Jun 2016 09:25:14 +0200
Subject: [PATCH] pwm: Fix pwm_apply_args()

Commit 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic
updates"), implemented pwm_disable() as a wrapper around
pwm_apply_state(), and then, commit ef2bf4997f7d ("pwm: Improve args
checking in pwm_apply_state()") added missing checks on the ->period
value in pwm_apply_state() to ensure we were not passing inappropriate
values to the ->config() or ->apply() methods.

The conjunction of these 2 commits led to a case where pwm_disable()
was no longer succeeding, thus preventing the polarity setting done
in pwm_apply_args().

Set a valid period in pwm_apply_args() to ensure polarity setting
won't be rejected.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Brian Norris <briannorris@chromium.org>
Fixes: 5ec803edcb70 ("pwm: Add core infrastructure to allow atomic updates")
---
 include/linux/pwm.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 908b67c847cd..c038ae36b10e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -464,6 +464,8 @@ static inline bool pwm_can_sleep(struct pwm_device *pwm)
 
 static inline void pwm_apply_args(struct pwm_device *pwm)
 {
+	struct pwm_state state = { };
+
 	/*
 	 * PWM users calling pwm_apply_args() expect to have a fresh config
 	 * where the polarity and period are set according to pwm_args info.
@@ -476,18 +478,20 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	 * at startup (even if they are actually enabled), thus authorizing
 	 * polarity setting.
 	 *
-	 * Instead of setting ->enabled to false, we call pwm_disable()
-	 * before pwm_set_polarity() to ensure that everything is configured
-	 * as expected, and the PWM is really disabled when the user request
-	 * it.
+	 * To fulfill this requirement, we apply a new state which disables
+	 * the PWM device and set the reference period and polarity config.
 	 *
 	 * Note that PWM users requiring a smooth handover between the
 	 * bootloader and the kernel (like critical regulators controlled by
 	 * PWM devices) will have to switch to the atomic API and avoid calling
 	 * pwm_apply_args().
 	 */
-	pwm_disable(pwm);
-	pwm_set_polarity(pwm, pwm->args.polarity);
+
+	state.enabled = false;
+	state.polarity = pwm->args.polarity;
+	state.period = pwm->args.period;
+
+	pwm_apply_state(pwm, &state);
 }
 
 struct pwm_lookup {
-- 
2.7.4
