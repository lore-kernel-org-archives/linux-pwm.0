From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
Date: Mon, 4 Nov 2019 19:07:00 +0100
Message-ID: <CAJiuCcdxHDwoQYBsrjK5dcOtMDie62DzJ84NH+bZzYHHv49fEQ@mail.gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-4-peron.clem@gmail.com>
 <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>, Pengutronix Kernel Team <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Mon, 4 Nov 2019 at 09:24, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sun, Nov 03, 2019 at 09:33:30PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it and a fallback for previous
> > bindings without name on module clock.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index d194b8ebdb00..b5e7ac364f59 100644
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
> > @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
>
> Adding more context here:
>
> |       pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     /* Get all clocks and reset line */
> > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > +     if (IS_ERR(pwm->clk)) {
> > +             dev_err(&pdev->dev, "get clock failed %ld\n",
> > +                     PTR_ERR(pwm->clk));
> > +             return PTR_ERR(pwm->clk);
> > +     }
>
> I guess you want to drop the first assignment to pwm->clk.

devm_clk_get_optional will return NULL if there is no entry, I don't
get where I need to drop it assignment.

>
> > +     /* Fallback for old dtbs with a single clock and no name */
> > +     if (!pwm->clk) {
> > +             pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +             if (IS_ERR(pwm->clk)) {
> > +                     dev_err(&pdev->dev, "get clock failed %ld\n",
> > +                             PTR_ERR(pwm->clk));
> > +                     return PTR_ERR(pwm->clk);
> > +             }
> > +     }
>
> There is a slight change of behaviour if I'm not mistaken. If you have
> this:
>
>         clocks =3D <&clk1>;
>         clock-names =3D "mod";
>
>         pwm {
>                 compatible =3D "allwinner,sun4i-a10-pwm"
>                 clocks =3D <&clk2>;
>         }
>
> you now use clk1 instead of clk2 before.
>
> Assuming this is only a theoretical problem, at least pointing this out
> in the commit log would be good I think.

Yes it's correct and as you said the driver don't check for a correct
device tree,
that why it's now optional probe.
Let's assume that's the device-tree is correct, I will add a comment
in the commit log.

>
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             dev_err(&pdev->dev, "get bus_clock failed %ld\n",
> > +                     PTR_ERR(pwm->bus_clk));
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> > +
> >       pwm->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> >       if (IS_ERR(pwm->rst)) {
> >               if (PTR_ERR(pwm->rst) =3D=3D -EPROBE_DEFER)
> > @@ -381,6 +407,13 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /* Enable bus clock */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare_enable bus_clk\n");
>
> I'd do s/prepare_enable/prepare and enable/ here.
Ok

>
> > +             goto err_bus;
> > +     }
> > +
> >       pwm->chip.dev =3D &pdev->dev;
> >       pwm->chip.ops =3D &sun4i_pwm_ops;
> >       pwm->chip.base =3D -1;
> > @@ -401,6 +434,8 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
> >       return 0;
> >
> >  err_pwm_add:
> > +     clk_disable_unprepare(pwm->bus_clk);
> > +err_bus:
> >       reset_control_assert(pwm->rst);
> >
> >       return ret;
>
> What is that clock used for? Is it required to access the hardware
> registers? Or is it only required while the PWM is enabled? If so you
> could enable the clock more finegrainded.

Regarding the datasheet it's required to access the hardware.
page 261 : https://linux-sunxi.org/File:Allwinner_H6_V200_User_Manual_V1.1.=
pdf

Regards,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
