From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Date: Thu, 9 Jan 2020 10:14:00 +0100
Message-ID: <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
References: <20200109072735.GA22886@embeddedor> <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe, Gustavo,

On Thu, 9 Jan 2020 at 08:44, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Gustavo,
>
> On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> > Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> >
> > The proper pointers to be passed as arguments are pwm->clk and pwm->bus=
_clk.

Thanks for the catch.

As these patches are still in next should we update them or apply a fix ?

Regards,
Clement

> >
> > This bug was detected with the help of Coccinelle.
> >
> > Fixes: b8d74644f34a ("pwm: sun4i: Prefer "mod" clock to unnamed")
> > Fixes: 5b090b430d75 ("pwm: sun4i: Add an optional probe for bus clock")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1afd41ebd3fd..a805c347ee84 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -423,7 +423,7 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
> >        */
> >       pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> >       if (IS_ERR(pwm->clk)) {
> > -             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +             if (PTR_ERR(pwm->clk) !=3D -EPROBE_DEFER)
>
> How embarrassing that I didn't notice these. Thanks for catching.
>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
