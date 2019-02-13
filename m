From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 13 Feb 2019 13:37:03 +0100
Message-ID: <20190213123703.GE647@ulmo>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjcmjzIkjQU2rmur"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--zjcmjzIkjQU2rmur
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 11:16:57AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
[...]
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
[...]
> > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCM=
P);
> > +
> > +	val &=3D ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
> > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > +
> > +	pwm_sifive_get_state(chip, dev, state);
>=20
> Thierry: This changes the pwm_state. Is this how this should be done?

Yes, I think that's fine. The PWM state should always reflect the
current hardware state. If the configuration that we program does not
reflect the state that was requested, that should be reflected in the
PWM state.

Thierry

--zjcmjzIkjQU2rmur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxkD24ACgkQ3SOs138+
s6EJYQ/+PKXGl1Os9kb2ygrrqtwNAdMUKWPznwwYxi0Nba1r8Z1Yt3XBPDh8m3lO
JTqBUX6Cc6ePyQRlyMoMzrD41+OEWW2ueUG6i1VfFZJ3Yx1FyV+qGOjyh1ajfc+b
s4+8fPXzQ6VHrryvA0bYn8QHk2+DKeQgXTwd8i0FOxazVJ5eaE97aTiqoL5TSW7e
WpCmTuBj53sRoMO3qnYAJtKi/XElp/so+6gOz6zzz92SKnFVxlb7LskyRO4xVJt0
csGSkj2GVDnbTRGAfge8u5o/fTLzTI61TpNZSZfufGnpt5YjMG6y9T3lNUh7WSyz
E8PhNHH3WnFeegmUpj6zu8h+p2gJBa8H8wh6YjipVuUhhVBZVq/5AqYbavtrLlAb
FLxUcCltLcAaClAoAx9aLYyuq2fvkUjBd9ghNvASrxq9F28fYNCOz38vACpGCExq
s5rLgsClYTjTOPipRKUj+8vUJoQnjtGV+miQTeD4+MkUJLrOvCvimaVfda+68Phe
zq3huhk0+etRLAwkKY2MmRi6nJTneESXq8gE0pb+QtMzlWs71Pqa/lqC/MPsAo5E
IZoh6keN0VBUpxltE8UoGMu6QJXaxTtVtmfOS8dZjT4xKvef40boBdl0jVt6KGMt
d3RRmQQDGiYwusML2HCpJUY9RcipWOn2oEYbtGxGHm2SM9dg6M4=
=UK4T
-----END PGP SIGNATURE-----

--zjcmjzIkjQU2rmur--
