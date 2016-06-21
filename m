From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Tue, 21 Jun 2016 23:22:58 +0200
Message-ID: <20160621232258.62105f7a@bbrezillon>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
	<CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
	<20160621183730.GA130978@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160621183730.GA130978@google.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

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

I think this is partly caused by this commit:

a8c3862551e0 ("pwm: Keep PWM state in sync with hardware state")

But again, we need that one if we don't want to override the current
PWM period with the pwm_args one when the driver support hardware
readout.

This leaves 2 choices:

1/ assign the period to pargs->period if ->get_state() is not
   implemented
2/ remove the !period check in pwm_apply_state() when state->enabled is
   false (do we really care if period = 0 when all we want to do is
   disable the PWM?)

Thierry, what's you're opinion.
