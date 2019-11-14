From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 3/7] pwm: sun4i: Add an optional probe
 for bus clock
Date: Thu, 14 Nov 2019 23:36:16 +0100
Message-ID: <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com> <20191108084517.21617-4-peron.clem@gmail.com>
 <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBB3NNW7XAKGQEP5HKSSI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191113083524.aqtf2ed4ltuiazjg-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Wed, 13 Nov 2019 at 09:35, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> On Fri, Nov 08, 2019 at 09:45:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it and a fallback for previous
> > bindings without name on module clock.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 2b9a2a78591f..a10022d6c0fd 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> > +     struct clk *bus_clk;
> >       struct clk *clk;
> >       struct reset_control *rst;
> >       void __iomem *base;
> > @@ -363,9 +364,38 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->base))
> >               return PTR_ERR(pwm->base);
> >
> > -     pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > -     if (IS_ERR(pwm->clk))
> > +     /* Get all clocks and reset line */
> > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > +     if (IS_ERR(pwm->clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get clock failed %pe\n",
> > +                             pwm->clk);
> >               return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     /*
> > +      * Fallback for old dtbs with a single clock and no name.
> > +      * If a parent has a clock-name called "mod" whereas the
> > +      * current node is unnamed the clock reference will be
> > +      * incorrectly obtained and will not go into this fallback.
>
> For me "old dtbs" suggests that today a device tree should have a "mod"
> clock. Is this true also for machines other than H6? And I'd put the
> comment before the acquisition of the "mod" clock. Something like:

Agree to remove the "old dtbs" but specifying the SoC instead
of the reason is less clear for me.

I would prefer to have something like this:

A clock is explicitly called "mod" when several clocks are referenced.
However, when only one clock is declared this one is unamed.
So we request "mod" first (and ignore the corner case that a parent
provides a "mod" clock)
and if this is not found we fall back to the first clock of the PWM.

What do you think?

>
>         /*
>          * A clock called "mod" is only required on H6 (for now) and on
>          * other SoCs we expect an unnamed clock. So we request "mod"
>          * first (and ignore the corner case that a parent provides a
>          * "mod" clock) and if this is not found we fall back to the
>          * first clock of the PWM.
>          */
>
> > +      */
> > +     if (!pwm->clk) {
> > +             pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +             if (IS_ERR(pwm->clk)) {
> > +                     if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                             dev_err(&pdev->dev, "get clock failed %pe=
\n",
> > +                                     pwm->clk);
> > +                     return PTR_ERR(pwm->clk);
> > +             }
> > +     }
> > +
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get bus_clock failed %pe\n",
> > +                             pwm->bus_clk);
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> >
> >       pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> >       if (IS_ERR(pwm->rst)) {
> > @@ -382,6 +412,17 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /*
> > +      * We're keeping the bus clock on for the sake of simplicity.
> > +      * Actually it only needs to be on for hardware register
> > +      * accesses.
> > +      */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n"=
);
> > +             goto err_bus;
> > +     }
> > +
>
> Would it make sense to split this patch into "Prefer "mod" clock to
> (unnamed) clock" and "Introduce optional bus clock"?

Yes I will do in v5,

Regards,
Cl=C3=A9ment
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
/linux-sunxi/CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg%40mail.gma=
il.com.
