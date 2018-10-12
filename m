Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 12:00:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181012100000.GB9162@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <20181011203450.muo4eoj4mnqo634a@pengutronix.de>
 <20181012095349.GA9162@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20181012095349.GA9162@ulmo>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:53:49AM +0200, Thierry Reding wrote:
> On Thu, Oct 11, 2018 at 10:34:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > The semantic of pwm_enable in my understanding is:
> >=20
> > 	pwm_enable for an uninverted PWM starts with $duty_cycle
> > 	nanoseconds at 0 and then is 1 for $period - $duty_cycle
> > 	nanoseconds. Then repeat.
> > 	For an inverted it is first 1 for $duty_cycle nanoseconds and
> > 	then 0 for the rest of the period.

Slight correction here: these are actually reversed. If you look at the
kerneldoc for enum pwm_polarity it explains what the expectations are.

Thierry

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAcKAACgkQ3SOs138+
s6G6zA//TTJPpNybdS/n49beBCTmBT2SacCOKX26ERUnrtAGuxxxNT3+6GvP9WQP
2b1nTh6+EuRQF3EslhrIdPMifEy6VSgpkgHZ6M/+I6C94qeEYBmCBWCnP6ZWIm2a
grRxesd+hgfWKz3tsGPZtIPANvNefHufNB0QekDw7ZMG+c938uUCDNYGg5gXRfGg
tm79lG00AXqqHHwG+uyJ29S2MikAH9dF/MHv/AUBjCnZMrEO1baBD/ii//hm66yS
dRTzd8NxOBeNoLDIF2OdvrdWMw5+jGMGuxfnxFBuAghRbNRg4uLR55vkBJmmUeBk
dKBEypiag1khq7eAP9EIdTKcQB8Feoi1WCJjHkLWSDSaQPqkCGv6Fbi2ZoqUrnFV
KAmXxDkDHr2isRTjQy0o8NTVe/8WtSusFElNJ5O6wOxHI7Vt4BOAvwGS9t5dHJ+l
yOQXh6UYk88POZe7ffXj21wLf9ltaVeUqUG6D/0JhyEvlLpKwtN5XZHlOr4vtqqP
NvOQ/JalRG0ZAlP0KPk/EobwgDZGGYYYiqohuOaTFMY8BffJbhoiwftpfmkaSDZw
kMahPVQzZzN81iPPuyWZ0fa8dbDqQOkil1cQ9AGGGySjZyiXpMhfIb0x6vhrcYOm
Y+zTv/YaL7cFKyly0oT4URqHnSg06dD/npo75IJ0tRcY51CFyjg=
=eMAF
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
