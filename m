From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 4/7] pwm: sun4i: Add support to output source clock directly
Date: Mon, 4 Nov 2019 22:28:54 +0100
Message-ID: <CAJiuCccjgtMcJa-pZCB_DGN6L8m9bDTgQRoV6WUKPSjv8kn8vA@mail.gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-5-peron.clem@gmail.com>
 <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe

On Mon, 4 Nov 2019 at 09:38, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Sun, Nov 03, 2019 at 09:33:31PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > PWM core has an option to bypass whole logic and output unchanged sourc=
e
> > clock as PWM output. This is achieved by enabling bypass bit.
> >
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> >
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip, which is integrated into same
> > package as H6 SoC.
>
> I think the , should be dropped.
>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index b5e7ac364f59..2441574674d9 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -3,6 +3,10 @@
> >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> >   *
> >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electr=
ons.com>
> > + *
> > + * Limitations:
> > + * - When outputing the source clock directly, the PWM logic will be b=
ypassed
> > + *   and the currently running period is not guaranted to be completed
>
> Typo: guaranted  -> guaranteed
>
> >   */
> >
> >  #include <linux/bitops.h>
> > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
> >
> >  struct sun4i_pwm_data {
> >       bool has_prescaler_bypass;
> > +     bool has_direct_mod_clk_output;
> >       unsigned int npwm;
> >  };
> >
> > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *c=
hip,
> >
> >       val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
> > +     /*
> > +      * PWM chapter in H6 manual has a diagram which explains that if =
bypass
> > +      * bit is set, no other setting has any meaning. Even more, exper=
iment
> > +      * proved that also enable bit is ignored in this case.
> > +      */
> > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > +         data->has_direct_mod_clk_output) {
> > +             state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk=
_rate);
> > +             state->duty_cycle =3D state->period / 2;
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
>
> Not sure how the rest of sun4i_pwm_get_state behaves, but I would prefer
> to let .get_state() round up which together with .apply_state() rounding
> down yields sound behaviour.
Ok
>
> > +
> >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >           sun4i_pwm->data->has_prescaler_bypass)
> >               prescaler =3D 1;
> > @@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  {
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> > -     u32 ctrl;
> > +     u32 ctrl, clk_rate;
> > +     bool bypass;
> >       int ret;
> >       unsigned int delay_us;
> >       unsigned long now;
> > @@ -218,6 +238,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               }
> >       }
> >
> > +     /*
> > +      * Although it would make much more sense to check for bypass in
> > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "en=
abled".
> > +      * Period is allowed to be rounded up or down.
> > +      */
> > +     clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > +     bypass =3D ((state->period * clk_rate >=3D NSEC_PER_SEC &&
> > +                state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
> > +               state->enabled);
>
> I guess the compiler is smart enough here, but checking for
> state->enabled is cheaper than the other checks, so putting this at the
> start of the expression seems sensible.
>
> The comment doesn't match the code. You don't round up state->period.
> (This is good, please fix the comment.) I think dropping the check
>
>         state->period * clk_rate < NSEC_PER_SEC + clk_rate
>
> would be fine, too.
Ok

>
> I'd like to have a check for
>
>         state->duty_cycle * clk_rate >=3D NSEC_PER_SEC / 2 &&
>         state->duty_cycle * clk_rate < NSEC_PER_SEC
>
> here. If this isn't true rather disable the PWM or output a 100% duty
> cycle with a larger period.

Why not just having the duty_cycle is 50% only ?
state->duty_cycle * 2 =3D=3D state->period;

Regards,
Clement

>
> > +
> >       spin_lock(&sun4i_pwm->ctrl_lock);
> >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
