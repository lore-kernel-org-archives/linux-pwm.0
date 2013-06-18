Return-Path: <thierry.reding@gmail.com>
Date: Wed, 19 Jun 2013 00:17:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130618221705.GC1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
 <20130617202910.GB5265@mithrandir>
 <1920640.1A218CWh3x@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline
In-Reply-To: <1920640.1A218CWh3x@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 10:50:40PM +0200, Tomasz Figa wrote:
> On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
[...]
> > > +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> > > +static DEFINE_SPINLOCK(samsung_pwm_lock);
> > > +#endif
> >=20
> > Why is this lock global? Shouldn't it more correctly be part of
> > samsung_pwm_chip?
>=20
> There are few registers shared with samsung_pwm_timer clocksource driver=
=20
> and so normally the spinlock is exported from it. However on on some=20
> platforms (namely Exynos >=3D4x12) kernel can be compiled without that=20
> driver, so the lock must be defined locally, just to synchronize multiple=
=20
> PWM channels, as they share registers as well.

Okay, I think this needs further explanation. The clocksource driver is
used for what exactly? From a quick look it seems to be very much PWM-
specific. According to the device tree binding for the PWM driver, the
timer blocks can also be used as clock sources and clock event timers.
So if I understand correctly you have setups where you use one or more
channels as clock source or clock event timer and one or more channels
as PWM outputs.

In that case it's a very bad idea to use a global lock to synchronize
accesses. You need to do much more than that. To properly split this
across several drivers there needs to be a mechanism to allocate
channels for use either as clock source/event timer or PWM. Otherwise,
how do you know that drivers aren't stepping on each other's toes?

> > > +		ret =3D pwm_samsung_parse_dt(chip);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > > +		chip->chip.of_pwm_n_cells =3D 3;
> > > +	} else {
> > > +		if (!pdev->dev.platform_data) {
> > > +			dev_err(&pdev->dev, "no platform data=20
> specified\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		memcpy(&chip->variant, pdev->dev.platform_data,
> > > +							sizeof(chip-
> >variant));
> > > +	}
> >=20
> > Obviously this needs some modification in order for the variant to
> > become constant. But I think you can easily do so by making the driver
> > match using the platform_driver's id_table field, similar to how the
> > matching is done for OF.
>=20
> Generally output_mask is board-dependent and is passed inside a variant=
=20
> struct using platform_data pointer.

That's okay. But output_mask is the only thing that's board-dependent.
Everything else in the variant is SoC dependent judging by the OF device
table. So really only the output_mask should be part of the platform
data.

> Same platform data is used in samsung_pwm_timer clocksource driver, so I=
=20
> just reused it here without adding the need to rename platform device at=
=20
> runtime (see arch/arm/plat-samsung/devs.c).

Looking a bit at git log for the clocksource driver, there's this
commit:

	a3ce54f clocksource: samsung_pwm_timer: Do not request PWM mem region

That's an ugly workaround for sharing registers between two drivers.
There's a reason why drivers do request_mem_region(), and it is
precisely to prevent them from accessing the same registers. As I
already said above, I think you need to come up with some sort of API to
share resources between the drivers.

There was a similar issue a few months back with the pwm-tiehrpwm and
pwm-tiecap drivers, which use a shared block of registers. Initially
something similar was done as you do here, but eventually we came up
with a much better solution that involved introducing a new driver for
the shared functionality and an exported API.

The situation seems to be somewhat different here since you actually
share the same resources for different functionality instead of sharing
one subset of register across multiple drivers, but I think a similar
solution can be applied here.

Thierry

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwNxhAAoJEN0jrNd/PrOhSDQP/3eM4N40ijNsLjtNodmNFQzk
uEtY8CLVSh6LV008OByyirflkUp9pD0toBZ8dMfLIw/nQEom7wAK/iAeyThooau6
npsYmgLThSL9u/JiccPXBifVTSI5hP0TnHM310pyo2sWarzH9ytobwx2+MzCmAoG
ZkWWJz+tRDEI2o0yCCGjcBJ7ShpkdlDqiFPxzhgzlA14DMdLU///sbYT5fZcK389
XWnDVFx+lm2sOhLRXgOhX8deg0qVaFsEc8TM1va7jMZPooLP6h2VHh0VOhZVIHZU
99eUKOnVj3Mu3HdjMSNbNuadFQLx1d2xK6QZb4a2HhNs0AB+N7p/GgSoN5hZT2pU
EAhVkCIg87/ch5LtwxEUtZugcl6Eu7cYS0teUkfZbsEA1ERMb6ve5/Uzoaw0GHE6
TwqxibBqTy7lds2q8eyTp/I1LJUvC5Sf/YYHJ+71Qzx6gLk9EiV460ewLSYdOWUf
a0+p9UCL7pijLR6cXbjP9TbdwE9K0D39q/7Kbq/7Qy667/BTVHZyPfvgwlcqyTTe
IPia2+j12ngswOTw2b352CLwcg/gvm8XTu0yIg444hdsxnKP0xrSZIeGxZQm0Swv
FLiuYE+gZJEN3t+DkbNDNc04b5Uif8VkYcTkuVIYj7eTMVeIQ0YIBDFJCssnq8Xj
cM5vDGRQpQ8B4xCafSrv
=QM2m
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
