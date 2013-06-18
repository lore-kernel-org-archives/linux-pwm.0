Date: Tue, 18 Jun 2013 23:40:23 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 08/15] pwm: Add new pwm-samsung driver
Message-ID: <20130618214023.GB1926@mithrandir>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1370467100-10820-9-git-send-email-tomasz.figa@gmail.com>
 <20130617202910.GB5265@mithrandir>
 <6439807.SaPozSx51p@flatron>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <6439807.SaPozSx51p@flatron>
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 09:41:09PM +0200, Tomasz Figa wrote:
> On Monday 17 of June 2013 22:29:11 Thierry Reding wrote:
> > On Wed, Jun 05, 2013 at 11:18:13PM +0200, Tomasz Figa wrote:
[...]
> > > +struct samsung_pwm_channel {
> > > +	unsigned long period_ns;
> > > +	unsigned long duty_ns;
> > > +	unsigned long tin_ns;
> > > +};
> > > +
> > > +struct samsung_pwm_chip {
> > > +	struct pwm_chip chip;
> > > +	struct samsung_pwm_variant variant;
> > > +	struct samsung_pwm_channel channels[SAMSUNG_PWM_NUM];
> >=20
> > The new driver for Renesas did something similar, but I want to
> > discourage storing per-channel data within the chip structure.
> >=20
> > The PWM framework provides a way to store this information along with
> > the PWM device (see pwm_{set,get}_chip_data()).
>=20
> OK, this looks good, but in my case is not really useful. I need to acces=
s=20
> those channel data in my suspend/resume callbacks and obviously I don't=
=20
> have access to any pwm_device there. Any suggestions?

You do have access to the struct pwm_chip, and that already has an array
of struct pwm_devices, so you could obtain the driver-specific data from
those (see pwm_chip.pwms).

Thierry

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwNPHAAoJEN0jrNd/PrOhSt4QAICy6VxsLSvXRg7L0yqjJy/G
31pCfThwffYAm/Lmlr7EFdRLXjwNtv5mb8m4LIL+6GDeZ0e4inEfdpGkrO76aRqR
Uv7eFX/Zw7Dr8VWjcUhJDleG1hyM4upYxdvsoY+8QVDShyudIdaAZfUFVkCmkb05
dzHeyJIz4EJwfW0o3AwJwjGyxRgzU3gso1vMMcP7LgKHmb4P4Kn9pxFrWxSrB8WP
/h2A5sYBUncNtI8DK94o1KyJPa1G8hK0qJ3CVQ/uCn+Cea8h1bUelvKwlG1E881R
gr1BSA8po9aYnJ7Fo1o2y/Xmk+S78RohDEOYXyDfBAWwVsGuiIsNifKEO9drhAj8
NR1gjL0FaxypFltjJAOasY7HGoZy8a4Jqt5mzFv4yLbxN90Q18Nyf81o2NkdraV0
acJqG5Zyih8bSRIe/1EgmSj9xyhyWSV/wM3uuRP59xLcuhBdaEViDry08zYhDbYm
44af47q3rfgi0ndMbnX1k0ya/D1exyL6bEIsTuOBqZLZtnMJp5E/iemLEyhd4s73
uBuGg+o+kZptPadLmYYoDmPTr6/+Ha2dhVGzFeCgtJvXJCdOJfDmqBljO62kFMMS
rTvSLzbjAYuH5UJ6+UvFtwz9lwxd0km/h7+yp8IeqpDWApb/h8Nzq2Fm34+CAsFS
TP24HPFEADkexm4M3vEa
=OhOa
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
