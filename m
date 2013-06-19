Return-Path: <thierry.reding@gmail.com>
Date: Wed, 19 Jun 2013 11:43:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130619094355.GB2911@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1920640.1A218CWh3x@flatron>
 <20130618221705.GC1926@mithrandir>
 <1433668.INLZy9nfLF@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <1433668.INLZy9nfLF@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 12:45:02AM +0200, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 00:17:06 Thierry Reding wrote:
> > On Mon, Jun 17, 2013 at 10:50:40PM +0200, Tomasz Figa wrote:
> > > On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > > > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
> > [...]
> >=20
> > > > > +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> > > > > +static DEFINE_SPINLOCK(samsung_pwm_lock);
> > > > > +#endif
> > > >=20
> > > > Why is this lock global? Shouldn't it more correctly be part of
> > > > samsung_pwm_chip?
> > >=20
> > > There are few registers shared with samsung_pwm_timer clocksource
> > > driver and so normally the spinlock is exported from it. However on
> > > on some platforms (namely Exynos >=3D4x12) kernel can be compiled
> > > without that driver, so the lock must be defined locally, just to
> > > synchronize multiple PWM channels, as they share registers as well.
> >=20
> > Okay, I think this needs further explanation. The clocksource driver is
> > used for what exactly? From a quick look it seems to be very much PWM-
> > specific. According to the device tree binding for the PWM driver, the
> > timer blocks can also be used as clock sources and clock event timers.
> > So if I understand correctly you have setups where you use one or more
> > channels as clock source or clock event timer and one or more channels
> > as PWM outputs.
> >=20
> > In that case it's a very bad idea to use a global lock to synchronize
> > accesses. You need to do much more than that. To properly split this
> > across several drivers there needs to be a mechanism to allocate
> > channels for use either as clock source/event timer or PWM. Otherwise,
> > how do you know that drivers aren't stepping on each other's toes?
> >=20
> > > > > +		ret =3D pwm_samsung_parse_dt(chip);
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +
> > > > > +		chip->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > > > > +		chip->chip.of_pwm_n_cells =3D 3;
> > > > > +	} else {
> > > > > +		if (!pdev->dev.platform_data) {
> > > > > +			dev_err(&pdev->dev, "no platform data
> > >=20
> > > specified\n");
> > >=20
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +
> > > > > +		memcpy(&chip->variant, pdev->dev.platform_data,
> > > > > +						=09
> sizeof(chip-
> > > >
> > > >variant));
> > > >
> > > > > +	}
> > > >=20
> > > > Obviously this needs some modification in order for the variant to
> > > > become constant. But I think you can easily do so by making the
> > > > driver
> > > > match using the platform_driver's id_table field, similar to how the
> > > > matching is done for OF.
> > >=20
> > > Generally output_mask is board-dependent and is passed inside a
> > > variant
> > > struct using platform_data pointer.
> >=20
> > That's okay. But output_mask is the only thing that's board-dependent.
> > Everything else in the variant is SoC dependent judging by the OF device
> > table. So really only the output_mask should be part of the platform
> > data.
> >=20
> > > Same platform data is used in samsung_pwm_timer clocksource driver, so
> > > I just reused it here without adding the need to rename platform
> > > device at runtime (see arch/arm/plat-samsung/devs.c).
> >=20
> > Looking a bit at git log for the clocksource driver, there's this
> > commit:
> >=20
> > 	a3ce54f clocksource: samsung_pwm_timer: Do not request PWM mem=20
> region
> >=20
> > That's an ugly workaround for sharing registers between two drivers.
> > There's a reason why drivers do request_mem_region(), and it is
> > precisely to prevent them from accessing the same registers. As I
> > already said above, I think you need to come up with some sort of API to
> > share resources between the drivers.
> >=20
> > There was a similar issue a few months back with the pwm-tiehrpwm and
> > pwm-tiecap drivers, which use a shared block of registers. Initially
> > something similar was done as you do here, but eventually we came up
> > with a much better solution that involved introducing a new driver for
> > the shared functionality and an exported API.
> >=20
> > The situation seems to be somewhat different here since you actually
> > share the same resources for different functionality instead of sharing
> > one subset of register across multiple drivers, but I think a similar
> > solution can be applied here.
>=20
> Well, current design, or rather lack of thereof, has been established=20
> after a significant amount of discussion, mostly with ARM SoC and MFD=20
> maintainers.
>=20
> It started from a simple reorganization of the clocksource driver to be=
=20
> multiplatform friendly, without any means of synchronizing both drivers=
=20
> other than local_irq_save() and _restore() that used to be there=20
> originally, before I started my work on this. This was enough to work=20
> correctly, because both drivers at the same time are used only on=20
> uniprocessor systems.
>=20
> Here's the thread with patches:
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16664/focus=3D17267
>=20
> Then I opened a Pandora's Box by asking for opinion in this thread:
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16480/focus=3D16500
>=20
> After that I started working on a complex framework for sharing this IP=
=20
> block that would solve all the problems with synchronization, channel=20
> allocation, device tree parsing, variant management, etc.
>=20
> Here's an initial version, which started as an MFD master driver, which=
=20
> would let 2 client drivers use the hardware (only the clocksource part wa=
s=20
> implemented in that series):
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/17464/focus=3D2292=
50
>=20
> Still, that version didn't receive too good feedback, with comments=20
> pointing me to change the architecture to master-slave, with the=20
> clocksource driver being the master and PWM driver being the slave. And s=
o=20
> v5 was made:
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/17864

Yeah, this seemed to be going in the right direction.

> This version was generally accepted, but then we discussed on IRC (mostly=
=20
> me and Arnd) whether such complex infrastructure is really needed and=20
> concluded that for this platform a simple shared spinlock would be enough=
,=20
> based on following reasons:
> - on all SoCs on which the clocksource driver is going to be used there i=
s=20
> only one instance of the PWM block, with 5 channels

You say that now. But then at some point somebody decides that it might
be useful to have a second instance.

> - on all existing boards there are always at least two channels that don'=
t=20
> have outputs

I don't see how that's relevant here.

> - operations on particular PWM channels must be synchronized anyway,=20
> because there are registers shared by all PWM channels (TCON being most=
=20
> important where enable, autoreload and invert bits are located for all=20
> channels).

And that's precisely why there should be a more explicit way of
synchronizing than just acquiring a lock. Otherwise you have no
possibility whatsoever to detect when a board tries to use both the
clocksource and PWM drivers in incompatible ways. The lock may prevent
concurrent accesses to the shared registers, but that won't help you if
the PWM driver suddenly decides to use an output that was originally
meant to be used as clock source.

> And so we got to current design which is basically a shared spinlock and=
=20
> per-board output_mask, which specifies which channels have outputs on=20
> particular boards. If you look to the clocksource driver, you can see tha=
t=20
> it tries to allocate two output-less channels for timekeeping purposes an=
d=20
> if it fails to do so, it simply panics.
>=20
> IMHO this solution is fine, because it's simple, has little overhead and=
=20
> it just works in case of platforms for which it is needed.

Okay, I like simple. But I see too much potential for this to break
in the future. There are just too many assumptions for my taste. It
isn't anything that I'm looking forward to have to maintain.

Thierry

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwX1bAAoJEN0jrNd/PrOhn6QP/1OAwtvZUYN+l9JEcsQKN3ER
J4FVRhiD9wyRbEidBZS9rr2qAYiWQzZcpzOrjsBLHPC/Nts0gWTwEP+3NnprIac9
0uvpsg9Szpk9bvurO7Jv+PqVX1BFyg4NQEwhl7NAvk58YMpKRL6eQLvop4kYr59t
jfo3tXjdZEsN7Irp1cSP4U1ICsk4DxuERDobTO7YInijVrgJyGp0wmR6ujsSrwDj
99Ay2L1RqRz9PP5u/ugm2iNwKnt7qtQpEEqgY+oduW7VfzVXNqKlLn8vSQr2xMiW
sO7OdONpYRc33Vu1YoPMoM6Prkn6tmTIVDokPnuI2wW4zcIF9evbGNEaIaSaNZMa
21Pg64gPAIuPUarKfkoWndgA5hH6nKjXGqV98x6IrU5xNk5h3kaBsjtq0okacJ2r
U9FKKmwebtPI8aDHyo6+Yjj86CElT/nnQHCkaLsfN8297JFlEHyYsronkmDWhwpr
HdM8VcH7zQ5z4ZyjAikv8Bn7XSyRzjnuVTHcLZGl6DjLu66nK5Dfc21YtklLQA7v
iPlsqHIcVJuGIB8IJIi1D+BzHy1bSLO4vlwa44dmjUAC/bG6OqOFeh9KL730O0aq
veafjO7Ewfiaw6Ll6FnMC/SWH3Mjzl8sc+ncs1I5czfS0idjNXybcOP1d4phjVYo
oz8pyPz7KUOKd/KkkfaP
=64zy
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
