From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/7] pwm: sun4i: Add support to output
 source clock directly
Date: Thu, 14 Nov 2019 23:47:00 +0100
Message-ID: <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com> <20191108084517.21617-5-peron.clem@gmail.com>
 <20191113085858.76rad3vpszknu4cp@pengutronix.de>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBB4NSW7XAKGQEL7R3RII-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191113085858.76rad3vpszknu4cp-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, 13 Nov 2019 at 09:58, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> On Fri, Nov 08, 2019 at 09:45:14AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > PWM core has an option to bypass whole logic and output unchanged sourc=
e
> > clock as PWM output. This is achieved by enabling bypass bit.
> >
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> >
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip which is integrated into same
> > package as H6 SoC.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index a10022d6c0fd..9cc928ab47bc 100644
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
> > + *   and the currently running period is not guaranteed to be complete=
d
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
> > +         sun4i_pwm->data->has_direct_mod_clk_output) {
> > +             state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate=
);
> > +             state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2);
>
> I first thought you're losing precision here by reusing state->period
> here, but with a divisor of 2 everything is fine.
>
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
> > +
> >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >           sun4i_pwm->data->has_prescaler_bypass)
> >               prescaler =3D 1;
> > @@ -204,6 +223,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> >       u32 ctrl;
> > +     bool bypass =3D false;
> >       int ret;
> >       unsigned int delay_us;
> >       unsigned long now;
> > @@ -218,9 +238,24 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               }
> >       }
> >
> > +     /*
> > +      * Although it would make much more sense to check for bypass in
> > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "en=
abled".
>
> I don't understand this reasoning. sun4i_pwm_calculate knows about
> .enabled and also sun4i_pwm->data->has_direct_mod_clk_output. Maybe just
> add a bool *bypass as parameter and move the logic there?

I asked myself the same question, however the sun4i_pwm_calculate is
only called when period or duty_cycle is updated not when state is
toggled between disabled / enabled.

Should we also call it when the state is switched to enabled ?

Regards,
Cl=C3=A9ment

>
> > +      */
> > +     if (state->enabled) {
> > +             u32 clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > +             bypass =3D (state->period * clk_rate >=3D NSEC_PER_SEC) &=
&
> > +                      (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > +                      (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_=
SEC);
> > +     }
> > +
>
> This looks right now.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAJiuCceYg7WC%3DpeHYeC%3DeE-HOsKH_SdsKyWwkWY5VpeY%2BuzaKA%40ma=
il.gmail.com.
