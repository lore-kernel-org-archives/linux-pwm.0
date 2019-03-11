From: Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH v8 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 11 Mar 2019 17:10:17 +0530
Message-ID: <CAJ2_jOFtg2_MAUYkTQM-=6KE2RN+FMxfEhLjZZfzM0k3A5RQiA@mail.gmail.com>
References: <1551437599-29509-1-git-send-email-yash.shah@sifive.com>
 <1551437599-29509-3-git-send-email-yash.shah@sifive.com> <20190307152745.kaiv6q4ygf2apmuv@pengutronix.de>
 <CAJ2_jOFvr=sw7mWR53JbzMJa1jxwjhJSTibCsKYsxrht+PLPWw@mail.gmail.com> <20190308115726.smgooacsr37fmxwg@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308115726.smgooacsr37fmxwg@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Fri, Mar 8, 2019 at 5:27 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Fri, Mar 08, 2019 at 04:59:36PM +0530, Yash Shah wrote:
> > On Thu, Mar 7, 2019 at 8:57 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > > +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_devi=
ce *dev,
> > > > +                         struct pwm_state *state)
> > > > +{
> > > > +     struct pwm_sifive_ddata *pwm =3D pwm_sifive_chip_to_ddata(chi=
p);
> > > > +     unsigned int duty_cycle, x;
> > > > +     u32 frac;
> > > > +     struct pwm_state cur_state;
> > > > +     bool enabled;
> > > > +     int ret =3D 0;
> > > > +     unsigned long num;
> > > > +
> > > > +     if (state->polarity !=3D PWM_POLARITY_INVERSED)
> > > > +             return -EINVAL;
> > > > +
> > > > +     mutex_lock(&pwm->lock);
> > > > +     pwm_get_state(dev, &cur_state);
> > > > +     enabled =3D cur_state.enabled;
> > > > +
> > > > +     if (state->period !=3D cur_state.period) {
> > >
> > > Did you test this with more than one consumer? For sure the following
> > > should work:
> > >
> > >         pwm1 =3D pwm_get(.. the first ..);
> > >         pwm_apply_state(pwm1, { .enabled =3D true, .period =3D 100000=
00, .... });
> > >
> > >         pwm2 =3D pwm_get(.. the second ..);
> > >         pwm_apply_state(pwm2, { .enabled =3D true, .period =3D 100000=
00, .... });
> > >
> > > but for the second pwm_apply_state() run state->period is likely not
> > > exactly 10000000.
> >
> > Yes, I have tested multiple consumers using sysfs interface. It is work=
ing.
>
> Can you provide details about your testing here? What is the parent clk
> rate? Which settings did you test? Can you confirm my claim that the
> above sequence would fail or point out my error in reasoning?
>

I have tested on HiFive Unleashed board using sysfs interface.
Parent clk rate is around 512 Mhz.
I have tested scenarios as you mentioned above with various period and
duty_cycle values.

After considering your below suggestion,
 | To get the result independent of the prior configuration you better use
 | the real targeted period length as input instead of the last configured
 | approximation
I will introduce approx_period feild, which will be used as the
targeted period length.
Also, in pwm_sifive_get_state, I will make below change
- state->period =3D pwm->real_period;
+ state->period =3D pwm->approx_period.
So with this change in place, I believe the cur_state.period for the
second pwm_apply_state() above (pwm2) will be exactly 10000000

> > > > +     x =3D 1U << PWM_SIFIVE_CMPWIDTH;
> > > > +     num =3D (u64)duty_cycle * x + x / 2;
> > > > +     frac =3D div_u64(num, state->period);
> > >
> > > I don't understand the "+ x / 2" part. Should this better be
> > > "+ state->period / 2"? Something like
> >
> > This eqn is as per your comments against v5 of this patch series.
> >  frac =3D (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 <<
> > PWM_SIFIVE_CMPWIDTH) / 2) / period;
>
> OK, then not only the code is wrong, but also my suggestion was. :-)
>
> > > #define div_u64_round(a, b) ({typeof(b) __b =3D b; div_u64(a + __b / =
2, __b)})
> > >
> > > would make this less error prone.
>
> This still stands. It makes it easier to get the code right and makes it
> easier to understand.

Sure, will implement this.

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
