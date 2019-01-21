From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 21 Jan 2019 12:30:39 +0100
Message-ID: <20190121113039.GI16756@ulmo>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115220046.etgbno6ymsux75dk@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 11:00:46PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> >=20
> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > [Atish: Various fixes and code cleanup]
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  drivers/pwm/Kconfig      |  10 ++
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 257 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-sifive.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a8f47df..3bcaf6a 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-samsung.
> > =20
> > +config PWM_SIFIVE
> > +	tristate "SiFive PWM support"
> > +	depends on OF
> > +	depends on COMMON_CLK
>=20
> I'd say add:
>=20
> 	depends on MACH_SIFIVE || COMPILE_TEST
>=20
> (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
>=20
> > +	help
> > +	  Generic PWM framework driver for SiFive SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-sifive.
> > +
> >  config PWM_SPEAR
> >  	tristate "STMicroelectronics SPEAr PWM support"
> >  	depends on PLAT_SPEAR
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..30089ca 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > +obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> >  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
> >  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> >  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > new file mode 100644
> > index 0000000..7fee809
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2017-2018 SiFive
> > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>=20
> I wonder if such an instance should be only a single PWM instead of
> four. Then you were more flexible with the period lengths (using
> pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.

I thought this IP only allowed a single period for all PWM channels in
the IP. If so, splitting this into four different devices is going to
complicate things because you'd have to coordinate between all four as
to which period is currently set.

> > +struct sifive_pwm_device {
> > +	struct pwm_chip	chip;
> > +	struct notifier_block notifier;
> > +	struct clk *clk;
> > +	void __iomem *regs;
> > +	unsigned int approx_period;
> > +	unsigned int real_period;
> > +};
>=20
> I'd call this pwm_sifive_ddata. The prefix because the driver is called
> pwm-sifive and ddata because this is driver data and not a device.

I don't think there's a need to have an extra suffix. Just call this
sifive_pwm or pwm_sifive. There's no ambiguity in that name and it's
short and crisp.

> > +	if (state->enabled)
> > +		sifive_pwm_get_state(chip, dev, state);
>=20
> @Thierry: Should we bless this correction of state?

I'm not sure I understand why this correction is necessary. Is it okay
to request a state to be applied and when we're not able to set that
state we just set anything as close as possible? Sounds a bit risky to
me. What if somebody wants to use this in a case where precision
matters?

Now, if you're saying that there can't be such cases and we should
support this, then why restrict the state correction to when the PWM is
enabled? What's wrong with correcting it in either case?

Thierry

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxFrVwACgkQ3SOs138+
s6GDPhAAqq3K+XU1yZmkcnkI1Zx0WumCOVIx3+P1YxoZRny1aaps0RIVvR3FIoFv
1I0P/4cuDQ1nUHh8ejdmqE/0uT/+bpxxWg3srsjaKkaSM3TutdX4EPk929EP91oJ
QIXFTxGm3FBeKbd5wdgqC5zLhC3hDowCpH+vyOB+YiW9bn2EBOQwnCwkeRpOAIVG
q2Er9KwCuKd1wIT+jCvprKOCnwui7ycZ2ycLbxRiBNMwcRBUfSMy6J6dZ0CJKMdD
uoSS1XWSOmLymi1g5Ibdii+VGxhXssfR9+YKvgdqJ0kkNqUZ8zrbHinNn0zuPSZH
SJSNZ0QCAOkvgPFTwFR/QV0DnBu/i8pgybpPawLkwA10QAIe4D5vheHI9YgvTxE3
9GNuFbUR1r52guNBF00ht3Wvxzu8WaoYwIOMhIDUrQJ4QA8c8eq+1GIJwXhvnzOH
xW93VlukNv+TmgzE60/9a6JgelKFUw0Iu+yYWs7kFq4WAgPiz9E5TiwoitZq4j5/
81HxqupXIT1jqI0W3JI6ZdVFk6gYEKts2CLIJKu9IIll59T3R8bS+dRdzp3Zm+JY
xO3+m7Kt97Nnz+e0SakZ64dnQF50QR+hv+Pd5jNPiLFfeU9sVpULG03tph0vg/0Q
Qn472hhDUD0VP1zBZxBl8DX0H/yOMaqnKHYyzIKN+JwOrJ/HH3A=
=aoyh
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
