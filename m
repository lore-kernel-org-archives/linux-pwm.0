From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH v3 2/7] pwm: sun4i: Add an optional probe for reset line
Date: Tue, 5 Nov 2019 15:01:31 +0100
Message-ID: <CAJiuCcesD8kh_BpVLxyhk5UYYwGhp_tQkcsaY-LzxRTT5kO3Qw@mail.gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-3-peron.clem@gmail.com>
 <a8908f1157e862164fb1bea07f8d5e1812325858.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a8908f1157e862164fb1bea07f8d5e1812325858.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

Hi Philipp,

On Tue, 5 Nov 2019 at 14:36, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Tue, 2019-11-05 at 14:14 +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs deasserted reset line in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..9ba83769a478 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> [...]
> > @@ -365,6 +367,21 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> > +     if (IS_ERR(pwm->rst)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get reset failed %ld\n",
> > +                             PTR_ERR(pwm->rst));
> > +             return PTR_ERR(pwm->rst);
> > +     }
> > +
> > +     /* Deassert reset */
>
> Nitpick: isn't the API function name explanatory enough?

Yes I can remove this comment,

Cl=C3=A9ment
>
> regards
> Philipp
>
