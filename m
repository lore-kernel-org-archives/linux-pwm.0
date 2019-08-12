From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Mon, 12 Aug 2019 17:11:56 +0800
Message-ID: <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de> <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
 <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, 12 Aug 2019 at 16:36, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> > Hi Uwe,
> >
> > On Fri, 9 Aug 2019 at 22:41, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Aug 09, 2019 at 06:06:21PM +0800, Baolin Wang wrote:
> > > > On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > > > > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct p=
wm_device *pwm,
> > > > > > +                            struct pwm_state *state)
> > > > > > +{
> > > > > > +     struct sprd_pwm_chip *spc =3D
> > > > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > > > +     u32 enabled, duty, prescale;
> > > > > > +     u64 tmp;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret =3D clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->c=
lks);
> > > > > > +     if (ret) {
> > > > > > +             dev_err(spc->dev, "failed to enable pwm%u clocks\=
n",
> > > > > > +                     pwm->hwpwm);
> > > > > > +             return;
> > > > > > +     }
> > > > > > +
> > > > > > +     chn->clk_enabled =3D true;
> > > > > > +
> > > > > > +     duty =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & =
SPRD_PWM_REG_MSK;
> > > > > > +     prescale =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRES=
CALE) & SPRD_PWM_REG_MSK;
> > > > > > +     enabled =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABL=
E) & SPRD_PWM_ENABLE_BIT;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * According to the datasheet, the period_ns and duty_ns =
calculation
> > > > > > +      * formula should be:
> > > > > > +      * period_ns =3D 10^9 * (prescale + 1) * mod / clk_rate
> > > > > > +      * duty_ns =3D 10^9 * (prescale + 1) * duty / clk_rate
> > > > > > +      */
> > > > > > +     tmp =3D (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX=
;
> > > > > > +     state->period =3D div64_u64(tmp, chn->clk_rate);
> > > > >
> > > > > This is not idempotent. If you apply the configuration that is re=
turned
> > > > > here this shouldn't result in a reconfiguration.
> > > >
> > > > Since we may configure the  PWM in bootloader, so in kernel part we
> > > > should get current PWM state to avoid reconfiguration if state
> > > > configuration are same.
> > >
> > > This is also important as some consumers might do something like:
> > >
> > >         state =3D pwm_get_state(mypwm)
> > >         if (something):
> > >                 state->duty =3D 0
> > >         else:
> > >                 state->duty =3D state->period / 2
> > >         pwm_set_state(mypwm, state)
> > >
> > > and then period shouldn't get smaller in each step.
> > > (This won't happen as of now because the PWM framework caches the las=
t
> > > state that was set and returns this for pwm_get_state. Still getting
> > > this right would be good.)
> >
> > I understood your concern, but the period can be configured in
> > bootloader, we have no software things to save the accurate period.
>
> I don't understand what you're saying here. The bootloader configuring
> the hardware is a usual use-case. That's why we have the .get_state
> callback in the first place.

Ah, sorry for confusing. I think I get your point now with below explanatio=
n.

>
> > Moreover I think I can change to use DIV_ROUND_CLOSET_ULL to keep the
> > accuracy.
>
> DIV_ROUND_CLOSEST_ULL still doesn't match what the apply callback uses.
> With the lack of an official statement from the maintainer I'd prefer
> .apply to round down and implement .get_state such that
>
>         pwm_apply(pwm, pwm_get_state(pwm))
>
> is a no-op.

OK.

>
> > > > > > +
> > > > > > +                     dev_err(spc->dev, "failed to get channel =
clocks\n");
> > > > > > +                     return ret;
> > > > > > +             }
> > > > > > +
> > > > > > +             clk_pwm =3D chn->clks[1].clk;
> > > > >
> > > > > This 1 looks suspicious. Are you using all clocks provided in the=
 dtb at
> > > > > all? You're not using i in the loop at all, this doesn't look rig=
ht.
> > > >
> > > > Like I said above, each channel has 2 clocks: enable clock and pwm
> > > > clock, the 2nd clock of each channel's bulk clocks is the pwm clock=
,
> > > > which is used to set the source clock. I know this's not easy to re=
ad,
> > > > so do you have any good suggestion?
> > >
> > > Not sure this is easily possible to rework to make this clearer.
> > >
> > > Do these clks have different uses? e.g. one to enable register access
> > > and the other to enable the pwm output? If so just using
> >
> > Yes.
>
> So assuming one of the clocks is for operation of the output and the
> other for accessing the registers, the latter can be disabled at the end

Right.

> of each callback?

We can not disable the latter one when using the PWM channel, we must
enable the pwm-enable clock, then enable pwm-output clock to make PWM
work. When disabling PWM channel, we should disable the pwm-output
clock, then pwm-enable clock.

>
> > > devm_clk_bulk_get isn't the right thing because you should be able kn=
ow
> > > if clks[0] or clks[1] is the one you need to enable the output (or
> > > register access).
> >
> > We've fixed the clock order in bulk clocks by the array
> > 'sprd_pwm_clks', maybe I should define one readable macro instead of
> > magic number.
>
> ack.
>
> > > > > > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > > > > > +                     chn->clk_rate =3D clk_get_rate(clk_pwm);
> > > > > > +             else
> > > > > > +                     chn->clk_rate =3D SPRD_PWM_DEFAULT_CLK;
> > > > >
> > > > > I don't know all the clock framework details, but I think there a=
re
> > > > > better ways to ensure that a given clock is used as parent for an=
other
> > > > > given clock. Please read the chapter about "Assigned clock parent=
s and
> > > > > rates" in the clock bindings and check if this could be used for =
the
> > > > > purpose here and so simplify the driver.
> > > >
> > > > Actually there are many other drivers set the parent clock like thi=
s,
> > > > and we want a default clock if failed to set the parent clock.
> > >
> > > These might be older than the clk framework capabilities, or the
> > > reviewers didn't pay attention to this detail; both shouldn't be a
> > > reason to not make it better here.
> >
> > The clock framework supplies 'assigned-clocks' and
> > 'assigned-clock-parents' properties to set parent, but for our case we
> > still want to set a default clock rate if failed to set parent when
> > met some abnormal things.
>
> Without understanding the complete problem I'd say this is out of the
> area the driver should care about.

Fair enough, I will try to use 'assigned-clocks' and
'assigned-clock-parents' to simplify the code.

Thanks.

--=20
Baolin Wang
Best Regards
