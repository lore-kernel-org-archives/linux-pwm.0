Return-Path: <thierry.reding@gmail.com>
Date: Tue, 23 Jul 2013 08:30:16 -0700
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 00/20] Samsung PWM support cleanup
Message-ID: <20130723153015.GA2066@dhcp-172-17-186-34.nvidia.com>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
 <9102768.ef8LAvpunv@flatron>
 <0ac901ce867f$638a7530$2a9f5f90$@org>
 <2036745.TWe3OlGh9t@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <2036745.TWe3OlGh9t@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Heiko =?utf-8?B?U3TDvGJuZXIn?= <heiko@sntech.de>, 'Mark Brown' <broonie@kernel.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2013 at 09:49:49AM +0200, Tomasz Figa wrote:
> On Monday 22 of July 2013 11:01:32 Kukjin Kim wrote:
> > Kukjin Kim wrote:
> > > Tomasz Figa wrote:
> > > > On Monday 22 of July 2013 00:22:16 Sylwester Nawrocki wrote:
> > > > > On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> > > > > > Since we now have a proper Samsung PWM clocksource driver in
> > > > > > place,
> > > > > > we can proceed with further cleanup of PWM timers support on
> > > > > > Samsung
> > > > > > SoCs.>
> > > > > >=20
> > > > > > This series attempts to achieve this goal by:
> > > > > >   1) fixing up few things in samsung_pwm_timer clocksource
> > > > > >   driver,
> > > > > >   2) moving remaining Samsung platforms to the new clocksource
> > >=20
> > > driver,
> > >=20
> > > > > >   3) removing old clocksource driver,
> > > > > >   4) adding new multiplatform- and DT-aware PWM driver,
> > > > > >   5) moving all Samsung platforms to use the new PWM driver,
> > > > > >   6) removing old PWM driver,
> > > > > >   7) removing all PWM-related code that is not used anymore.
> > > > > >=20
> > > > > > Cleaning up the PWM driver is a bit tricky, because the design
> > > > > > of
> > > > > > current driver makes it completely unsuitable for DT and
> > > > > > multiplatform and would require a heavy rework to make it
> > > > > > usable,
> > > > > > breaking any existing Samsung PWM users by the way. To avoid any
> > > > > > breakage this series first renames the old driver, then adds new
> > > > > > one
> > > > > > using original name, migrates all platforms to use it and then
> > > > > > finally removes the old driver.
> > > > > >=20
> > > > > > See particular patches for more detailed descriptions.
> > > > > >=20
> > > > > > [On S3C6410-based Tiny6410 (Mini6410-compatible) with
> > > > > > pwm-beeper,
> > > > > > SMDK6410 with PWM backlight and Exynos4210-based Origen board
> > > > > > (with
> > > > > > PWM0 attached to a scope)]
> > > > > > Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> > > > > >=20
> > > > > > [On S3C2440-based Mini2440 board]
> > > > > > Tested-by: Sylwester Nawrocki<sylvester.nawrocki@gmail.com>
> > > > >=20
> > > > > I have retested this series on top of v3.11-rc1 with pwm-backlight
> > >=20
> > > (and
> > >=20
> > > > > buzzer
> > > > > as the output :)) on Mini2440. It seems to work well - generated
> > > > > frequencies are correct. I'll check pulse widths with a scope
> >=20
> > tomorrow,
> >=20
> > > > > as it's a bit late
> > > > > now. FWIW you can add to this series my:
> > > > >=20
> > > > > Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > > >=20
> > > > Thanks. I hope we can finally get this series merged soon.
> > >=20
> > > Yes, this whole patches look good to me, and I'd like to take this
> > > whole patches into the samsung tree...but need to get any response
> > > from PWM guy, Thierry Reding. Let's wait for his response...
> >=20
> > To be clarify, because his ack was on v3 and I remember he had a
> > comment. So would be better if we could get his ack on pwm change
> > again.
>=20
> Sure.

Patches 12, 13 and 16:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR7qGHAAoJEN0jrNd/PrOhap0P+gPikCYxJ1+OhKbEZ6J1ulpA
O5fTHa2Lf+knbq5udxaleRNsTd8v/e5E4YUPSrbB2sAkDHmJbA5Mcz7+K5b7tYfl
wpZJOc4QgwlblbiuiQ+i5p/k+8to9shHDpWH8vESbb5LYIIkAFAo1C67Hi2+jBEh
Pv/VPwjvQtwS7UivWWI3whaCn9e7P/YNTsqbrWclHGSSw8M+MPOvCiLbnDeuF4Bf
UTQOSvdPPQV+u23LyRNeuyC3x4AedDUBvCvOt9v1tftPu6HpJNsS62MeByksVIog
/nPazKbJ7KUI6CKVYqAj8f0duQz7NMfdfrLrmFp5fZ0QmC6Wm6YFlu71ca4NLMAT
RVIjTEYyZh+HubKrO+Kq4LvT4yo/+5tzQxBIFEWLN8A0HIedW5R1lNZJ1KhKEwvQ
2lO+Sp796qP4pzYplPrPYh8sgvEprNYU8UsMJkyNDg4DxDN6zn86MrciPgvFMYLZ
nc9s43n2h0cgw1N4mzK+eifHvOAjiqxN2ABQuz5ZrQihuvHkSlqbj/jpepk6Us1O
asRRHJlCFk3RgY8/xmt1h23edrH/rrOqZBNt8JqcXW6I6EJCBKqbudYqRMm8dPHm
80AyQUjmyCxEwnmNwAlCOs3ve4RPCLl9sAHKMgVAsLmYLVhfyFjgfoSEX56Owupl
OEzS54LS3gGOzugO7dK1
=0lvW
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
