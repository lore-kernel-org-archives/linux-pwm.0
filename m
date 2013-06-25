Return-Path: <thierry.reding@gmail.com>
Date: Tue, 25 Jun 2013 12:26:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Message-ID: <20130625102646.GC21137@manwe>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <3059286.XLVAQe4lge@flatron>
 <20130624205342.GE7163@mithrandir>
 <1405696.in3RSSDWnX@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <1405696.in3RSSDWnX@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 11:17:03PM +0200, Tomasz Figa wrote:
> On Monday 24 of June 2013 22:53:42 Thierry Reding wrote:
> > On Mon, Jun 24, 2013 at 10:32:55PM +0200, Tomasz Figa wrote:
[...]
> > > What about:
> > >=20
> > > /*
> > >=20
> > >  * PWM block is shared between pwm-samsung and samsung_pwm_timer
> > >  drivers
> > >  * and some registers need access synchronization. If both drivers are
> > >  * compiled in, the spinlock is defined in the clocksource driver,
> > >  * otherwise following definition is used.
> > >  *
> > >  * Currently we do not need any more complex synchronization method
> > >  * because all the supported SoCs contain only one instance of the PWM
> > >  * IP. Should this change, both drivers will need to be modified to
> > >  * properly synchronize accesses to particular instances.
> > >  */
> >=20
> > I see that you can't be persuaded. And everybody else seems to be okay
> > with it so... have it your way. I'm probably going to regret this.
>=20
> This was just a proposal. Do you want anything else to be added to the=20
> comment or anything to be changed?

For reference, I still don't like this but since I'm the only one
complaining, go ahead. With that comment added to the driver:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyXBmAAoJEN0jrNd/PrOhFy8P/3xhEv2GrP+vy9GtLk6pA5LH
tVQeXbJznmbDf9gk+eRwLhM5qKx0VQdLCbv9FrdA+yj3ckAZfpuqcq+oUZSlPTt6
Y124cR3qiueMLpXlGSkJhDljN8Vvk0Mq1TvpkHEgzMWH6Y80TpNaVTdVuuf5NqFS
BcTbFickLCHPhFNLJqsjrI+Drcb+Qcvf52mzjru9JzOzF3f/dQ77raeWVSNVKUYG
YDnNpgdLICRA6egR3xdaeY88gKvmoJIsbFceAzL/2pqzuRxs445rcJoftcum9NdS
E4P7Qw0TmIbS3y4m1qMveiLA+w+xWa2OvFAu4GlIWJ+BMKGf8bmjdQX83vGeo3zs
tSTzvqyM2rukSPeKXe6qTIGqH0cKUCX5GWAnydZUuWaSAUqu9qUirKBQu4nRfHn4
wxA5PZe7+MY+jiux6arU+MapYnFzLXOyVTNbDAMEDLTBisazLG7YhSR6okrwgPAw
9/EUvejVuJL97oJmab/LzRiAaAFYgWJV0kZ4qK+DQitRezCT616hn93zVZYiz5bB
LQXZFpv55ezf79+/NSltUL6uCnQX5VNGnR1YeIevJ3mL50C0/kSFvaxq9Hl1e5jA
A3Pvst96e8bSV9Bak1Go7lPzVlkRfqpVbqrxMj99WSEWXpb7xCCrjyWvH8oCo+bI
XkpWvH3DZCd9e1zFNQri
=RG6G
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
