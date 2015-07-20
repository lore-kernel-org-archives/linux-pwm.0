From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
Date: Mon, 20 Jul 2015 10:03:14 +0200
Message-ID: <20150720080313.GF29614@ulmo>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
 <20150702064445.GC11824@pengutronix.de>
 <20150702094955.4b1c9254@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150702094955.4b1c9254@bbrezillon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2015 at 09:49:55AM +0200, Boris Brezillon wrote:
> On Thu, 2 Jul 2015 08:44:45 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>=20
> > On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > > When requested by a user, the PWM is assigned a default period and po=
larity
> > > extracted from the DT, the platform data or statically set by the dri=
ver.
> > > Those default values are currently stored in the period and polarity
> > > fields of the pwm_device struct, but they will be stored somewhere el=
se
> > > once we have introduced the architecture allowing for hardware state
> > > retrieval.
> > >=20
> > > The pwm_set_default_polarity and pwm_set_default_period should only be
> > > used by PWM drivers or the PWM core infrastructure to specify the
> > > default period and polarity values.
> > Would it make sense to put the prototypes of
> > pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
> > then?
> >=20
>=20
> Yes, definitely. I was thinking about moving those functions/prototypes
> into include/linux/pwm-provider.h, but I'm fine with
> drivers/pwm/pwm-private.h too.
>=20
> Thierry, any opinion ?

I'm not sure I see the need for this. If they are the default values and
drivers have no need to change them, then storing them in the regular
period and polarity fields seems just fine (they'll be propagated into
new state objects as they get created).

And if the driver has a need to change them, then why would it ever care
about the default values?

Thierry

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrKtAAAoJEN0jrNd/PrOh07YP+gJdRmrnyzGZCFOVyxrD1h1t
ssAomCs1PeCvAKhHI5UjO6RIMlLhLpkvvFBX2fSdj0o8wxUB/P9pdLbIHTsBkYc4
udmHuhjVP9pXnA/xl0Qn5bUjluoLQ0RSuDJ4KdQXYuEceJB3Yz7nGn4xCGi9DhUS
7pfi3mwH0BxKATg5XSAioDbUxCZDo6yGwEOOamMpsADmBeDj6mbf5+LsNl2AF8Bv
ao1IXuVpbOlc9FaPXWyI844p1lGSG7xv8uG4gD7wnQfwauBGf4WNapSUzADzPw4l
ZOINyH3k9FDMiSiDPxTOEA0s6m5EPbbvtEkM6Tkc95GANIfiBBbS5uPUzzh7LQIk
AdrhClnNyXxsBipXPOSLlVqAh8HPB5o/ekx82Keqw0katlIxfdr6Mxy7Tt+rifKx
jYykr94cwn8l0Tg1LMyZHy+5NnPs+GFHYgRZPePiGZ2UvqYbRlXyJIH15odkI4Qk
hGL25KPe3gjaemIpyN9CS1ajqjNEKgN7MWk8PUc/5dD3TC2/83lEUZBMO6p8h3q0
C9cc1vWSNDC8D6DyXQ5gMDLMkKeggi3VRWc7dKhLsUjMbmR/q+BNxf92GbW1M2FC
flJ6uvc09XSbQXldnD1W/MDRKAosP8aXGj5Ce0tg9E6V0yWvx482AluJpsCpxz8w
GDnEyT/hWXIndxUTF0+U
=EZ02
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--
