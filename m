From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Thu, 15 Aug 2019 17:34:02 +0800
Message-ID: <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de> <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de> <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
 <20190815085452.2cipewq3l3krnwzv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815085452.2cipewq3l3krnwzv@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Thu, 15 Aug 2019 at 16:54, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> > On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> > > > > > +     /*
> > > > > > +      * The hardware provides a counter that is feed by the so=
urce clock.
> > > > > > +      * The period length is (PRESCALE + 1) * MOD counter step=
s.
> > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter=
 steps.
> > > > > > +      * Thus the period_ns and duty_ns calculation formula sho=
uld be:
> > > > > > +      * period_ns =3D NSEC_PER_SEC * (prescale + 1) * mod / cl=
k_rate
> > > > > > +      * duty_ns =3D NSEC_PER_SEC * (prescale + 1) * duty / clk=
_rate
> > > > > > +      */
> > > > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE)=
;
> > > > > > +     prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> > > > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > > > > +     state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rat=
e);
> > > > > > +
> > > > > > +     val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > > > > > +     duty =3D val & SPRD_PWM_DUTY_MSK;
> > > > > > +     tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > > > > > +     state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk=
_rate);
> > > > > > +
> > > > > > +     /* Disable PWM clocks if the PWM channel is not in enable=
 state. */
> > > > > > +     if (!state->enabled)
> > > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM,=
 chn->clks);
> > > > > > +}
> > > > > > +
> > > > > > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct p=
wm_device *pwm,
> > > > > > +                        int duty_ns, int period_ns)
> > > > > > +{
> > > > > > +     struct sprd_pwm_chn *chn =3D &spc->chn[pwm->hwpwm];
> > > > > > +     u32 prescale, duty;
> > > > > > +     u64 tmp;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * The hardware provides a counter that is feed by the so=
urce clock.
> > > > > > +      * The period length is (PRESCALE + 1) * MOD counter step=
s.
> > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter=
 steps.
> > > > > > +      *
> > > > > > +      * To keep the maths simple we're always using MOD =3D SP=
RD_PWM_MOD_MAX.
> > > > >
> > > > > Did you spend some thoughts about how wrong your period can get b=
ecause
> > > > > of that "lazyness"?
> > > > >
> > > > > Let's assume a clk rate of 100/3 MHz. Then the available period l=
engths
> > > > > are:
> > > > >
> > > > >         PRESCALE =3D  0  ->  period =3D   7.65 =C2=B5s
> > > > >         PRESCALE =3D  1  ->  period =3D  15.30 =C2=B5s
> > > > >         ...
> > > > >         PRESCALE =3D 17  ->  period =3D 137.70 =C2=B5s
> > > > >         PRESCALE =3D 18  ->  period =3D 145.35 =C2=B5s
> > > > >
> > > > > So the error can be up to (nearly) 7.65 =C2=B5s (or in general
> > > >
> > > > Yes, but for our use case (pwm backlight), the precision can meet o=
ur
> > > > requirement. Moreover, we usually do not change the period, just
> > > > adjust the duty to change the back light.
> > >
> > > Is this a license requirement for you SoC to only drive a backlight w=
ith
> > > the PWM? The idea of having a PWM driver on your platform is that it =
can
> > > also be used to control a step motor or a laser.
> >
> > Not a license requirement. Until now we have not got any higher
> > precision requirements, and we've run this driver for many years in
> > our downstream kernel.
>
> I understood that you're not ambitious to do something better than "it
> worked for years".

How do you know that? If there are some cases expect a higher
precision, then we can analyze how precision asked by the user, then
we have a goal to improve it, even improve the hardware. But now, I
said there are no these use cases, why I should add more mathematics
to increase load and complication.

> > > > > PRESCALE =3D 18 and MOD =3D 254 you get a period of 144.78 =C2=B5=
s and so the
> > > > > error is only 0.56 =C2=B5s which is a factor of 13 better.
> > > > >
> > > > > Hmm.
> > > > >
> > > > > > +      * The value for PRESCALE is selected such that the resul=
ting period
> > > > > > +      * gets the maximal length not bigger than the requested =
one with the
> > > > > > +      * given settings (MOD =3D SPRD_PWM_MOD_MAX and input clo=
ck).
> > > > > > +      */
> > > > > > +     duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > > > >
> > > > > I wonder if you loose some precision here as you use period_ns bu=
t might
> > > > > actually implement a shorter period.
> > > > >
> > > > > Quick example, again consider clk_rate =3D 100 / 3 MHz,
> > > > > period_ns =3D 145340, duty_ns =3D 72670. Then you end up with
> > > > >
> > > > >         PRESCALE =3D 17
> > > > >         MOD =3D 255
> > > > >         DUTY =3D 127
> > > >
> > > > Incorrect, we will get PRESCALE =3D 18,  MOD =3D 255, DUTY =3D 127.
> > > >
> > > > > That corresponds to period_ns =3D 137700, duty_ns =3D 68580. With=
 DUTY =3D 134
> > > > > you get 72360 ns which is still smaller than the requested 72670 =
ns.
> > > >
> > > > Incorrect, with DUTY =3D 134 (PRESCALE =3D 18  ->  period =3D 145.3=
5 =C2=B5s),
> > > > duty_ns =3D 76380ns
> > >
> > > Yes, as above. When using rounding-closest your error is not in [0, 7=
.65
> > > =C2=B5s] but in [-3.825 =C2=B5s, 3.825 =C2=B5s]. Doesn't make it bett=
er.
> >
> > Actually our use case really dose not care about this error.
>
> I assume that Thierry will apply your patch anyhow. But be prepared that
> you get a patch from me then to improve precision. It would be a waste
> of resources not to do that after doing all the necessary math already.

Glad to see your improvement without introducing complicated and more
mathematics.

>
> > > > > (But then again it is not obvious which of the two is the "better=
"
> > > > > approximation because Thierry doesn't seem to see the necessity t=
o
> > > > > discuss or define a policy here.)
> > > >
> > > > Like I said, this is the simple calculation formula which can meet =
our
> > > > requirement (we limit our DUTY value can only be 0 - 254).
> > > > duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > >
> > > simple is often good but sometimes different from correct. And even w=
ith
> >
> > I do not think this is incorrect.
>
> Well, "correct" is probably not the right term. The problem is that my
> efforts to improve the PWM framework are not going forward. And so the
> suggestions I made here are not normative (yet) and undocumented.

OK.

>
> > > rounding closest instead of rounding down you're giving away precisio=
n
> > > here and the size of the error interval is the same, it is just cente=
red
> > > around 0 instead of only positive. If I hadn't spend so much time wit=
h
> > > pwm reviews this week I'd try to come up with an example.
> >
> > I am very appreciated for your comments.
> >
> > > > > (And to pick up the thoughts about not using SPRD_PWM_MOD_MAX
> > > > > unconditionally, you could also use
> > > > >
> > > > >         PRESCALE =3D 18
> > > > >         MOD =3D 254
> > > > >         DUTY =3D 127
> > > > >
> > > > > yielding period_ns =3D 144780 and duty_ns =3D 72390. Summary:
> > > > >
> > > > >         Request:                 72670 / 145340
> > > > >         your result:             68580 / 137700
> > > > >         also possible:           72390 / 144780
> > > > >
> > > > > Judge yourself.)
> > > > >
> > > > > > +     tmp =3D (u64)chn->clk_rate * period_ns;
> > > > > > +     do_div(tmp, NSEC_PER_SEC);
> > > > > > +     prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX)=
 - 1;
> > > > >
> > > > > Now that you use DIV_ROUND_CLOSEST_ULL the comment is wrong becau=
se you
> > > > > might provide a period bigger than the requested one. Also you di=
vide
> > > >
> > > > Again, that's the precision can meet our requirement.
> > >
> > > If you go back to rounding down, use the matching rounding up in
> > > .get_state and adapt your comment describing you're sticking to MOD=
=3D255
> > > to say explicitly that you're loosing precision I can live with that.=
 I
> > > even did the math for .get_state in my previous mail for you.
> > >
> > > The idea of the requirement to round down is that I want to introduce
> > > this as policy for the PWM framework to get some uniform behaviour fr=
om
> >
> > Have you made a consensus about this? Documented it?
>
> I tried. Check the pwm patchwork, there are uncommented patches that
> first try to document the current status quo. When these are "in" I
> intend to discuss the improvements I have in mind. But don't expect this
> to be quickly done as even the (AFAICT) noncontroversial documentation
> patches[1] fail to get applied.

OK.

>
> > > all lowlevel drivers. If you do this now I won't bother you later whe=
n
> > > the requirement is implemented in your driver. And the comment helps
> > > someone who evaluates your SoC to judge if there is still work to do =
if
> > > they have higher requirements for the PWM.
> >
> > So what you asked is something like below, right?
> > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > index 96f8aa0..1d3db94 100644
> > --- a/drivers/pwm/pwm-sprd.c
> > +++ b/drivers/pwm/pwm-sprd.c
> > @@ -103,12 +103,12 @@ static void sprd_pwm_get_state(struct pwm_chip
> > *chip, struct pwm_device *pwm,
> >         val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> >         prescale =3D val & SPRD_PWM_PRESCALE_MSK;
> >         tmp =3D (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > -       state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > +       state->period =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> >
> >         val =3D sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> >         duty =3D val & SPRD_PWM_DUTY_MSK;
> >         tmp =3D (prescale + 1) * NSEC_PER_SEC * duty;
> > -       state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate)=
;
> > +       state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> >
> >         /* Disable PWM clocks if the PWM channel is not in enable state=
. */
> >         if (!state->enabled)
> > @@ -135,8 +135,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip
> > *spc, struct pwm_device *pwm,
> >         duty =3D duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> >
> >         tmp =3D (u64)chn->clk_rate * period_ns;
> > -       do_div(tmp, NSEC_PER_SEC);
> > -       prescale =3D DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
> > +       div =3D 1000000000ULL * SPRD_PWM_MOD_MAX;
> > +       prescale =3D div64_u64(tmp, div) - 1;
> >         if (prescale > SPRD_PWM_PRESCALE_MSK)
> >                 prescale =3D SPRD_PWM_PRESCALE_MSK;
>
> This goes in the right direction for sure.
>
> Without taking paper and pencil I wouldn't be surprised if the
> calculation of duty_cycle in .get_state didn't match the calculation of
> DUTY in .apply yet though.
>
> > But our MOD is constant, it did not help to improve the precision.
> > Instead, like you said, when period_ns =3D 145340, we will set PRESCALE
> > =3D 17, so in .get_state(), user will get period_ns =3D 137700 (error
> > is145340 -  137700).
> >
> > But if we use DIV_ROUND_CLOSEST, in .get_state(), user will get
> > period_ns =3D 145350 (error is 145350 -  145340).
>
> In this case DIV_ROUND_CLOSEST seems to get nearer to the requested
> value than when rounding down. But this example was constructed to show
> your original algorithm to be bad, and just because you modify your
> algorithm to perform better on that constructed example doesn't imply
> the new one is better. Moreover you implement a bigger period than
> requested which is something I intend to forbid in the future.
>
> And note that with PWMs there is no "objective" metric that can tell you
> which of two implementable outputs better match a given request. It
> depends on the use case, so the best we can do is to tell our users our
> metric and with that in mind they can create a request that then fits
> their needs.

Yes, that should be asked by the use case, some cases do not care a
little bigger period than requested.

As you said, what you asked did not get a consensus yet, so I'd like
to wait for Thierry's suggestion.

> > > > > twice instead of once before. (I don't know what architecture you=
r SoC
> > > > > uses, but compared to a multiplication a division is usually expe=
nsive.)
> > > > > Also the math is more complicated now as you have a round-down di=
v and a
> > > > > round-closest div.
> > > > >
> > > > > My preference for how to fix that is to restore the behaviour of =
v2 that
> > > > > matches the comment and adapt .get_state() instead.
> > > >
> > > > Using DIV_ROUND_CLOSEST_ULL can get a same prescale which matches w=
ith
> > > > .get_state().
> > >
> > > I don't get you here. Do you say that with DIV_ROUND_CLOSEST_ULL you =
get
> > > the same result but DIV_ROUND_CLOSEST_ULL matches .get_state while
> > > rounding down doesn't? I cannot follow.
> >
> > Yes, that's what I mean.
>
> But that is logically broken. If both approaches yield the same
> results it cannot be true that exactly one of them matches the inverse
> of .get_state.

What I mean is use DIV_ROUND_CLOSEST_ULL we can get a nearer value to
the requested like above example.

--=20
Baolin Wang
Best Regards
