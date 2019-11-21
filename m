From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/6] pwm: sun4i: Add an optional probe
 for bus clock
Date: Thu, 21 Nov 2019 22:31:31 +0100
Message-ID: <CAJiuCcfj7rngTgbZQDwjKoLgRGcqsYscBvrCP095zzyASKSqdQ@mail.gmail.com>
References: <20191121195902.6906-1-peron.clem@gmail.com> <20191121195902.6906-4-peron.clem@gmail.com>
 <20191121210559.pz3nsyomqfrjuoe4@pengutronix.de>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBP4E3TXAKGQED4JQQHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191121210559.pz3nsyomqfrjuoe4-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, 21 Nov 2019 at 22:06, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> On Thu, Nov 21, 2019 at 08:58:59PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 369990ae7d09..66befd8d6f9c 100644
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
> > @@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               }
> >       }
> >
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get bus clock failed %pe\n",
> > +                             pwm->bus_clk);
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> > +
> >       pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> >       if (IS_ERR(pwm->rst)) {
> >               if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > @@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /*
> > +      * We're keeping the bus clock on for the sake of simplicity.
> > +      * Actually it only needs to be on for hardware register accesses=
.
> > +      */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare and enable bus_clk %d=
\n",
> > +                     ret);
>
> nitpick: other error messages in this driver start with a lower case
> letter.
>
> Until there is an equivalent for %pe that consumes an int, I suggest to
> use
>
>         dev_err(&pdev->dev, "Cannot prepare and enable bus_clk: %pe\n",
>                 ERR_PTR(ret));
>
> to benefit from a symbolic error name instead of an error constant.

Ok i will fix both

Thanks,
Clement

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
/linux-sunxi/CAJiuCcfj7rngTgbZQDwjKoLgRGcqsYscBvrCP095zzyASKSqdQ%40mail.gma=
il.com.
