From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v8 5/6] pwm: sun4i: Add support to output
 source clock directly
Date: Sat, 23 Nov 2019 21:00:58 +0100
Message-ID: <20191123200058.kz2farbyvruybtjj@pengutronix.de>
References: <20191121195902.6906-1-peron.clem@gmail.com>
 <20191121195902.6906-6-peron.clem@gmail.com>
 <20191121211630.slgayfbuykwvlvdt@pengutronix.de>
 <CAJiuCcdhH9zbRMMYsZbBYL-H8YWn2kimvJEjZ8Z8kF7Uh9MCpg@mail.gmail.com>
 <CAJiuCcd8VK2xHqRuWTVpNvw4e+rCR9-KjOSF5KsTcN9qQhaNVw@mail.gmail.com>
Reply-To: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCX3TTWUQMPRBDFA43XAKGQEXAVQAYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAJiuCcd8VK2xHqRuWTVpNvw4e+rCR9-KjOSF5KsTcN9qQhaNVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sat, Nov 23, 2019 at 03:05:48PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> Hi Uwe,
>=20
> On Thu, 21 Nov 2019 at 22:21, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
> >
> > Hi Uwe,
> >
> > On Thu, 21 Nov 2019 at 22:16, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 08:59:01PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > > >
> > > > PWM core has an option to bypass whole logic and output unchanged s=
ource
> > > > clock as PWM output. This is achieved by enabling bypass bit.
> > > >
> > > > Note that when bypass is enabled, no other setting has any meaning,=
 not
> > > > even enable bit.
> > > >
> > > > This mode of operation is needed to achieve high enough frequency t=
o
> > > > serve as clock source for AC200 chip which is integrated into same
> > > > package as H6 SoC.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++=
++--
> > > >  1 file changed, 46 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 1fa2057419fb..0fe9c680d6d0 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -3,6 +3,10 @@
> > > >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> > > >   *
> > > >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-el=
ectrons.com>
> > > > + *
> > > > + * Limitations:
> > > > + * - When outputing the source clock directly, the PWM logic will =
be bypassed
> > > > + *   and the currently running period is not guaranteed to be comp=
leted
> > > >   */
> > > >
> > > >  #include <linux/bitops.h>
> > > > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
> > > >
> > > >  struct sun4i_pwm_data {
> > > >       bool has_prescaler_bypass;
> > > > +     bool has_direct_mod_clk_output;
> > > >       unsigned int npwm;
> > > >  };
> > > >
> > > > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chi=
p *chip,
> > > >
> > > >       val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > >
> > > > +     /*
> > > > +      * PWM chapter in H6 manual has a diagram which explains that=
 if bypass
> > > > +      * bit is set, no other setting has any meaning. Even more, e=
xperiment
> > > > +      * proved that also enable bit is ignored in this case.
> > > > +      */
> > > > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > > > +         sun4i_pwm->data->has_direct_mod_clk_output) {
> > > > +             state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_=
rate);
> > > > +             state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period,=
 2);
> > > > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > > > +             state->enabled =3D true;
> > > > +             return;
> > > > +     }
> > > > +
> > > >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK=
) &&
> > > >           sun4i_pwm->data->has_prescaler_bypass)
> > > >               prescaler =3D 1;
> > > > @@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_ch=
ip *chip,
> > > >
> > > >  static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
> > > >                              const struct pwm_state *state,
> > > > -                            u32 *dty, u32 *prd, unsigned int *prsc=
lr)
> > > > +                            u32 *dty, u32 *prd, unsigned int *prsc=
lr,
> > > > +                            bool *bypass)
> > > >  {
> > > >       u64 clk_rate, div =3D 0;
> > > >       unsigned int pval, prescaler =3D 0;
> > > >
> > > >       clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > > >
> > > > +     *bypass =3D sun4i_pwm->data->has_direct_mod_clk_output &&
> > > > +               state->enabled &&
> > > > +               (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > > > +               (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > > > +               (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC=
);
> > > > +
> > > > +     /* Skip calculation of other parameters if we bypass them */
> > > > +     if (*bypass)
> > > > +             return 0;
> > > > +
> > > >       if (sun4i_pwm->data->has_prescaler_bypass) {
> > > >               /* First, test without any prescaler when available *=
/
> > > >               prescaler =3D PWM_PRESCAL_MASK;
> > > > @@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > > >       int ret;
> > > >       unsigned int delay_us, prescaler;
> > > >       unsigned long now;
> > > > +     bool bypass;
> > > >
> > > >       pwm_get_state(pwm, &cstate);
> > > >
> > > > @@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > > >       spin_lock(&sun4i_pwm->ctrl_lock);
> > > >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > >
> > > > -     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period,=
 &prescaler);
> > > > +     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period,=
 &prescaler,
> > > > +                               &bypass);
> > > >       if (ret) {
> > > >               dev_err(chip->dev, "period exceeds the maximum value\=
n");
> > > >               spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > @@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >               return ret;
> > > >       }
> > > >
> > > > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > > > +             if (bypass) {
> > > > +                     ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > > +                     /* We can skip other parameter */
> > > > +                     sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_RE=
G);
> > > > +                     spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > +                     return 0;
> > > > +             } else {
> > > > +                     ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > > +             }
> > > > +     }
> > >
> > > This could be simplified to:
> > >
> > >         if (bypass) {
> > >                 ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > >                 /*
> > >                  * Other parameters are not relevant in this mode and=
 so
> > >                  * writing them can be skipped
> > >                  */
> > >                 sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> > >                 spin_unlock(&sun4i_pwm->ctrl_lock);
> > >                 return 0;
> > >         } else {
> > >                 ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > >         }
> > >
> > > which has the advantage(?) that the bypass bit is also (more obviousl=
y)
> > > cleared for SoCs that don't support it and it reduces the indention
> > > level.
> >
> > This bit is not guaranteed to be reserved for all the SoC variants.
> >
> > I don't think it's a good idea to set to 0 a bit which is undefined.
>=20
> Let me know if you agree or not with this and I send the v9 according
> to your answer.

If my suggestion is not safe according to the documentation, it is
obviously wrong. So only take it into account if a zero can be safely
written.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20191123200058.kz2farbyvruybtjj%40pengutronix.de.
