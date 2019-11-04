From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v2 2/7] pwm: sun4i: Add an optional probe for reset line
Date: Mon, 4 Nov 2019 18:50:04 +0100
Message-ID: <CAJiuCcfEjE9qWqKyv5kyW_hTwO=L8eCuSoBEBvLZYm9JAV0O-w@mail.gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-3-peron.clem@gmail.com>
 <20191104081157.373v22atswsaktbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191104081157.373v22atswsaktbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, 4 Nov 2019 at 09:11, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> adding Philipp Zabel (=3D reset controller maintainer) to Cc: and so I'm
> not stripping the uncommented parts of the patch.
>
> On Sun, Nov 03, 2019 at 09:33:29PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs deasserted reset line in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..d194b8ebdb00 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/time.h>
> > @@ -78,6 +79,7 @@ struct sun4i_pwm_data {
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> >       struct clk *clk;
> > +     struct reset_control *rst;
> >       void __iomem *base;
> >       spinlock_t ctrl_lock;
> >       const struct sun4i_pwm_data *data;
> > @@ -365,6 +367,20 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     pwm->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> > +     if (IS_ERR(pwm->rst)) {
> > +             if (PTR_ERR(pwm->rst) =3D=3D -EPROBE_DEFER)
> > +                     return PTR_ERR(pwm->rst);
> > +             dev_info(&pdev->dev, "no reset control found\n");
>
> I would degrade this to a dev_dbg. Otherwise this spams the log for all
> unaffected machines. devm_reset_control_get_optional() is defined in a
> section that has a comment "These inline function calls will be removed
> once all consumers have been moved over to the new explicit API.", so I
> guess you want devm_reset_control_get_optional_exclusive or even
> devm_reset_control_get_optional_shared here.
Thanks for pointing this, I will change it.

>
> @Philipp: maybe a check in checkpatch that warns about introduction of
> such new instances would be good?!
>
> > +     }
> > +
> > +     /* Deassert reset */
> > +     ret =3D reset_control_deassert(pwm->rst);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot deassert reset control\n");
> > +             return ret;
> > +     }
> > +
> >       pwm->chip.dev =3D &pdev->dev;
> >       pwm->chip.ops =3D &sun4i_pwm_ops;
> >       pwm->chip.base =3D -1;
> > @@ -377,19 +393,31 @@ static int sun4i_pwm_probe(struct platform_device=
 *pdev)
> >       ret =3D pwmchip_add(&pwm->chip);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> > -             return ret;
> > +             goto err_pwm_add;
> >       }
> >
> >       platform_set_drvdata(pdev, pwm);
> >
> >       return 0;
> > +
> > +err_pwm_add:
> > +     reset_control_assert(pwm->rst);
> > +
> > +     return ret;
> >  }
> >
> >  static int sun4i_pwm_remove(struct platform_device *pdev)
> >  {
> >       struct sun4i_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     ret =3D pwmchip_remove(&pwm->chip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     reset_control_assert(pwm->rst);
> >
> > -     return pwmchip_remove(&pwm->chip);
> > +     return 0;
> >  }
> >
> >  static struct platform_driver sun4i_pwm_driver =3D {
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
