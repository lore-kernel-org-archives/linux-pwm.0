Return-Path: <thierry.reding@gmail.com>
Date: Tue, 18 Jun 2013 23:33:45 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130618213344.GA1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1430661.RSssKEDPJD@flatron>
 <51C0A1A7.60309@samsung.com>
 <1494539.CqPx2jpKaT@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <1494539.CqPx2jpKaT@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 08:13:51PM +0200, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 03:06:31 Kukjin Kim wrote:
> > On 06/19/13 02:59, Tomasz Figa wrote:
> > > Hi Thierry,
> >=20
> > [...]
> >=20
> > >>> +static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> > >>> +					unsigned int channel, u8 divisor)
> > >>=20
> > >> Nit: please align arguments on subsequent lines with the first
> > >> argument
> > >> of the first line. There's many more of these but I haven't mentioned
> > >> them all explicitly.
> > >=20
> > > Hmm, I'm addressing all your comments that aren't addressed yet in v2
> > > at the moment and I'm wondering if this is really the correct way of
> > > breaking function headers...
> >=20
> > static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
> > 				    unsigned int channel, u8 divisor)
> >=20
> >=20
> > I also would preferred to use above style :)
>=20
> Personally I find it looking better as well, but this is about being=20
> compliant with kernel coding style guidelines (which also says that=20
> indentation should be done using tabs). Please correct my understanding o=
f=20
> the quote below if it is incorrect.

"placed substantially to the right" doesn't imply right-aligned. My
understanding is that it should be indented enough to make it stand
apart. I don't recall ever seeing right-aligned code.

And regarding tabs, you should be indenting using tabs as far as
possible and use spaces for the final alignment, so:

static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
				    unsigned int channel, u8 divisor)

In case your emailer doesn't highlight it, that's four tabs and four
spaces.

Thierry

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwNI4AAoJEN0jrNd/PrOhpNIP/1wc86Z3D6/rtEJWyCJbN/Hj
FUFFsAVcyYHAFbECPh00ctVIBhEddp5PmGZ/6DloTyI4HJ7NFhYy7qvizTph5pk6
WE4weF/Qmh2VyBWQCyhLgnpXDzzxeCAE0mzVYaVSG46uzEqj4dsxBDd+Cmd6E3EM
2WE6nSG8ZiRukWfcacVrnXZbidfm0rMj5lbxbDKHg2ykpSMgcnVuvnyaC0CEqTDv
/NihAjR4wiVae3tjWOf79YpMxgigPBuopAxB/LTu9GmXdDX4y8w3Mrv8rTl0qg58
CNQ8NyWSiEuY3VzIU1N3jEDXgw16tMXLi1oV4TX79UcfIL9bPp9oYpHIXiPcdL/p
RSJuDDbjHkeC9l59wger2XgJqYQ3IaeYwTOHVWFp+Ib+OQvQYuw+SKtzTgHEq0j/
LJtcfQ0e7LavtdablrQ7ARAPzuQzrcRd1JMwf6jQ5nfeIAoLpkZX7WbIx8Kjtyhg
ENVIEZzNaMWOILrCF3Svtfef93gVnsbzo1VPvL4/kVGMU9fNbbqh8tPJRqQiO6xw
Qpbx+DTNBdGRdOI/fhjfeXsv/4OVXcZwLrjcM27obbBX0Vcih2mL/xj/LjJtwYNe
e7BS3KjIhPHrmrTg9/j/3wlQqrvj5gD+5NaVuNdsrdK0z260H8WjwdF0fBiUFw5z
8J+5AT3sN1fbd9VkSoF/
=ivBC
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
