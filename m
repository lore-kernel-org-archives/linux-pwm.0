From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Wed, 14 Aug 2019 18:01:50 +0800
Message-ID: <CAMz4ku+3txx5kO-u_+_pxFwoovnX81WFF-moNBasUUgEpvQb+Q@mail.gmail.com>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de> <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
 <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, 14 Aug 2019 at 17:23, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> > On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > > [...]
> > Not really, our hardware's method is, when you changed a new
> > configuration (MOD or duty is changed) , the hardware will wait for a
> > while to complete current period, then change to the new period.
>
> Can you describe that in more detail? This doesn't explain why MOD must b=
e
> configured before DUTY. Is there another reason for that?

Sorry, I did not explain this explicitly. When we change a new PWM
configuration, the PWM controller will make sure the current period is
completed before changing to a new period. Once setting the MOD
register (since we always set MOD firstly), that will tell the
hardware that a new period need to change.

The reason MOD must be configured before DUTY is that, if we
configured DUTY firstly, the PWM can work abnormally if the current
DUTY is larger than previous MOD. That is also our hardware's
limitation.

>
> > > > +static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> > > > +                       struct pwm_state *state)
> > > > +{
> > > > +     struct sprd_pwm_chip *spc =3D
> > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > +     struct pwm_state cstate;
> > > > +     int ret;
> > > > +
> > > > +     pwm_get_state(pwm, &cstate);
> > >
> > > I don't like it when pwm drivers call pwm_get_state(). If ever
> > > pwm_get_state would take a lock, this would deadlock as the lock is
> > > probably already taken when your .apply() callback is running. Moreov=
er
> > > the (expensive) calculations are not used appropriately. See below.
> >
> > I do not think so, see:
> >
> > static inline void pwm_get_state(const struct pwm_device *pwm, struct
> > pwm_state *state)
> > {
> >         *state =3D pwm->state;
> > }
>
> OK, the PWM framework currently caches this for you. Still I would
> prefer if you didn't call PWM API functions in your lowlevel driver.
> There is (up to now) nothing bad that will happen if you do it anyhow,
> but when the PWM framework evolves it might (and I want to work on such
> an evolution). You must not call clk_get_rate() in a .set_rate()
> callback of a clock either.

Make sense, I will change to:

struct pwm_state *cstate =3D pwm->state;

>
> > > > +     if (state->enabled) {
> > > > +             if (!cstate.enabled) {
> > >
> > > To just know the value of cstate.enabled you only need to read the
> > > register with the ENABLE flag. That is cheaper than calling get_state=
.
> > >
> > > > +                     /*
> > > > +                      * The clocks to PWM channel has to be enable=
d first
> > > > +                      * before writing to the registers.
> > > > +                      */
> > > > +                     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_=
CLKS,
> > > > +                                                   chn->clks);
> > > > +                     if (ret) {
> > > > +                             dev_err(spc->dev,
> > > > +                                     "failed to enable pwm%u clock=
s\n",
> > > > +                                     pwm->hwpwm);
> > > > +                             return ret;
> > > > +                     }
> > > > +             }
> > > > +
> > > > +             if (state->period !=3D cstate.period ||
> > > > +                 state->duty_cycle !=3D cstate.duty_cycle) {
> > >
> > > This is a coarse check. If state->period and cstate.period only diffe=
r
> > > by one calling sprd_pwm_config(spc, pwm, state->duty_cycle,
> > > state->period) probably results in a noop. So you're doing an expensi=
ve
> > > division to get an unreliable check. It would be better to calculate =
the
> > > register values from the requested state and compare the register
> > > values. The costs are more or less the same than calling .get_state a=
nd
> > > the check is reliable. And you don't need to spend another division t=
o
> > > calculate the new register values.
> >
> > Same as above comment.
>
> When taking the caching into account (which I wouldn't) the check is
> still incomplete. OK, you could argue avoiding the recalculation in 90%
> (to just say some number) of the cases where it is unnecessary is good.

Yes :)

>
> > >
> > > > +                     ret =3D sprd_pwm_config(spc, pwm, state->duty=
_cycle,
> > > > +                                           state->period);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +             }
> > > > +
> > > > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
> > > > +     } else if (cstate.enabled) {
> > > > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
> > > > +
> > > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->cl=
ks);
> > >
> > > Assuming writing SPRD_PWM_ENABLE =3D 0 to the hardware completes the
> > > currently running period and the write doesn't block that long: Does
> > > disabling the clocks interfere with completing the period?
> >
> > Writing SPRD_PWM_ENABLE =3D 0 will stop the PWM immediately, will not
> > waiting for completing the currently period.
>
> The currently active period is supposed to be completed. If you cannot
> implement this please point this out as limitation at the top of the
> driver.

Sure.

>
> Honestly I think most pwm users won't mind and they should get the
> possibility to tell they prefer pwm_apply_state to return immediately
> even if this could result in a spike. But we're not there yet.
> (Actually there are three things a PWM consumer might want:
>
>  a) stop immediately;
>  b) complete the currently running period, then stop and return only
>     when the period is completed; or
>  c) complete the currently running period and then stop, return immediate=
ly if
>     possible.
>
> Currently the expected semantic is b).

Make sense.

>
> > > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > > +{
> > > > +     struct sprd_pwm_chip *spc =3D platform_get_drvdata(pdev);
> > > > +     int ret, i;
> > > > +
> > > > +     ret =3D pwmchip_remove(&spc->chip);
> > > > +
> > > > +     for (i =3D 0; i < spc->num_pwms; i++) {
> > > > +             struct sprd_pwm_chn *chn =3D &spc->chn[i];
> > > > +
> > > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->cl=
ks);
> > >
> > > If a PWM was still running you're effectively stopping it here, right=
?
> > > Are you sure you don't disable once more than you enabled?
> >
> > Yes, you are right. I should check current enable status of the PWM cha=
nnel.
> > Thanks for your comments.
>
> I didn't recheck, but I think the right approach is to not fiddle with
> the clocks at all and rely on the PWM framework to not let someone call
> sprd_pwm_remove when a PWM is still in use.

So you mean just return pwmchip_remove(&spc->chip); ?

--=20
Baolin Wang
Best Regards
