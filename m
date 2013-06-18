Date: Wed, 19 Jun 2013 00:20:00 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130618222000.GD1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <6439807.SaPozSx51p@flatron>
 <20130618214023.GB1926@mithrandir>
 <1834122.aETH5FyPtO@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <1834122.aETH5FyPtO@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 11:42:37PM +0200, Tomasz Figa wrote:
> On Tuesday 18 of June 2013 23:40:23 Thierry Reding wrote:
> > On Tue, Jun 18, 2013 at 09:41:09PM +0200, Tomasz Figa wrote:
> > > On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > > > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
> > [...]
> >=20
> > > > > +struct samsung_pwm_channel {
> > > > > +	unsigned long period_ns;
> > > > > +	unsigned long duty_ns;
> > > > > +	unsigned long tin_ns;
> > > > > +};
> > > > > +
> > > > > +struct samsung_pwm_chip {
> > > > > +	struct pwm_chip chip;
> > > > > +	struct samsung_pwm_variant variant;
> > > > > +	struct samsung_pwm_channel channels[SAMSUNG_PWM_NUM];
> > > >=20
> > > > The new driver for Renesas did something similar, but I want to
> > > > discourage storing per-channel data within the chip structure.
> > > >=20
> > > > The PWM framework provides a way to store this information along
> > > > with
> > > > the PWM device (see pwm_{set,get}_chip_data()).
> > >=20
> > > OK, this looks good, but in my case is not really useful. I need to
> > > access those channel data in my suspend/resume callbacks and
> > > obviously I don't have access to any pwm_device there. Any
> > > suggestions?
> >=20
> > You do have access to the struct pwm_chip, and that already has an array
> > of struct pwm_devices, so you could obtain the driver-specific data
> > from those (see pwm_chip.pwms).
>=20
> Well, if it's legal to access internals of pwm_chip from PWM drivers then=
=20
> there is no problem. Based on other subsystems, like regulators or clocks=
=20
> I have concluded that this structure should be dereferenced only inside=
=20
> PWM core.

It's quite alright to do that. As a matter of fact you already do the
same within the .probe() callback to set things up.

Thierry

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwN0QAAoJEN0jrNd/PrOhlXwQALHOobBpc0KaPyMoSHCiCK8f
OOqwI65EdynLedwFr8T05rl6uCJuVDhXEyxDiFLdCv3JPKLr0131lAKb5b3cag4A
7BRdLhsWadUu9NRXKgP4V5Cslz9qtcCY6rr74pKtcEdeHduIke3FZINJ7rxgbDkm
n6FVAP7YKsg+iS/6OrSHBhzNo1+hGVEgmR1wxa2NYn7NP9Yaq+T3I48qwci0FBfF
BFVeDQus0oVNBrP6gfUoBYfItLqUrfvUnRyxERy/x62sDHSTxGO+31is1aTvbvjg
9GcTeTnd4hoKZQa6G0UzdYlnWkMsuJKSGG1EB0mr6wIQiLPv9+jarTVSrlKn7tBR
0bbl4cKQNOEozwGhqLR9+BvtnMd9Mwz74FeOJKYfQYLiTUBhHr6xbta2w0ghTcgd
EcnSA6gCDSIDNXq5lvyvPG3M6sKemBMncDohzABxjqJ22qXeYWl5vvOtyZYptj4q
XU98TE0cVTMVBoxzHgd14njQZ8pdCdeP6i1xvLfdgE4hTlcp6N5K0k+hn1E3ps8l
fTCSWrMSFeOUlnAnoElKOTY71InEkqeZ2fNMYSiKAYtkg3lnX1eKA0JupdcV0e5A
rM2l3MI6y+dtytztMIdIXm03WBNrZxc3l7PAqIdTSktd8o+MRxdBxtqag6lLlPn3
JFyqK3kd4TrfYYnQ2pB1
=NnVT
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
