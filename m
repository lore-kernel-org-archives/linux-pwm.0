Return-Path: <thierry.reding@gmail.com>
Date: Mon, 24 Jun 2013 22:28:03 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130624202802.GC7163@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <24964129.e56nj79VjR@flatron>
 <20130624195020.GA7163@mithrandir>
 <8756440.8o3uDlCqg5@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <8756440.8o3uDlCqg5@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2013 at 10:03:12PM +0200, Tomasz Figa wrote:
[...]
> OK. So we just need to prevent people from blindly copying this.
>=20
> Wouldn't adding a big comment about why this is enough for this platform=
=20
> and why anything more sophisticated would be just overengineering in this=
=20
> case be enough?

That'd be sugarcoating. I don't think this is a good idea at all and
using a properly encapsulated driver with proper shared API to access
shared registers wouldn't be overengineering in my opinion. It would
in fact be good engineering.

> This driver is already a lot better than previous one, because as opposed=
=20
> to the old one, it gives synchronization that is technically correct. Not=
=20
> even saying about a lot of other things fixed, like multiplatform-
> awareness, OF support, coding style, proper handling of dividers, etc.,=
=20
> etc. It would be really bad if all this was put to waste...

I certainly wouldn't want any of this going to waste, and quite frankly
letting you get away with just the comment is already more compromise
than I really like.

The TI drivers used to have a similar problem and I required them to
come up with a good solution. It'd be fair to require the same of you.
But maybe I'm getting soft.

Thierry

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyKvSAAoJEN0jrNd/PrOhQLMQAKIWVK5+aqi83VOytEbHTHJ/
DVzC40f0TWzzjgiaToUJEqeusBdeFM7F40GxbUUDqI8QWN02NpKzsCzbCQfNSL5p
DBbIJ2PzPVp6R9FlYv9Mlw/XjDw0/rQDyksOSdMAt5DHujX+IPuXCarnD5hDDwFr
9d7NMg0OUt3BExQbPz1py3y8nU3w8dYq2xpHNiK3UuEeeBePP0IlIswlGDYQWpLY
Yy5zhqc71uQQkJ0SmEkVpcKM6OgbEp6ikWud9UObs5HTwTsvTtYnKj7s0C8MF9wF
3RedVxocpHxg0hqnAaaBKCDIhVknYH3ZGGweqJMqqBrATigxzstJqZ1KKrEZqPPr
Jgmq/ibpyiI7SzVj2ETCJFnmXs8BMKXzEnb/RuLxUR/IN5vKKkEKivG9G2Dg+2Rt
xFdpL2iQbRUUxSVj6aNVfUf5eN09O9o/6B8pDYWFP20DHvtLuWIAxe6MyerpjRxj
X1PEkW4DX9+I/lqNA4nUAjIpFGvy41Ijtb99MetVVrR8ouyQ8ygXhDdim9u8v+vz
4iOV4dBsvXTqPW6GZiYx7KVVVjO23OxP0f8cwDN8TdFneSswZ6d61piceF4mC5Zp
1K4RvRmqENrgHTRG3NS4JjukfKSPmqcZWNXsoLsVzMqjzV44IYEAPt9ZiqYyVUZU
ZmmaRwb9Px4g0un2xdOa
=2WhO
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
