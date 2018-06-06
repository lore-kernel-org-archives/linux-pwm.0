From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: stm32: enforce dependency on CONFIG_MFD_STM32_TIMERS
Date: Wed, 6 Jun 2018 10:04:47 +0200
Message-ID: <20180606080447.GB11810@ulmo>
References: <20180525160523.29124-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525160523.29124-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 06:04:54PM +0200, Arnd Bergmann wrote:
> When compile-testing the pwm driver without also enabling the
> stm32_timers MFD, we run into a link error:
>=20
> drivers/pwm/pwm-stm32.o: In function `stm32_pwm_raw_capture.isra.6':
> pwm-stm32.c:(.text+0xcb0): undefined reference to `stm32_timers_dma_burst=
_read'
>=20
> We don't need the '|| COMPILE_TEST' here, since stm32_timers itself
> can be built with CONFIG_COMPILE_TEST on all architectures, so we do
> get the coverage through allmodconfig and randconfig builds even
> when we make it a hard dependency.
>=20
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXlZ8ACgkQ3SOs138+
s6GHOxAAjzrOSS+vSZ5YUbmkDs7Kq6nIMWvjXX3UFfn1ooi7tXZA4WZ81SCn08O2
ytwxtdlIfsnQ/TgWjMY0jSpk94Dh4XPoHeKSsJUOYfQKirN6x5CLj3P2rviYFBIZ
2z/F+nRwsaJ9hax2ILZawcknPOSi7oZY2orwC7laOfaASvA8X2Rw1j5fWcU7OsMA
4euQStPfpAHGgyZusP/5N4zFlB4fzoHF7us4RMYBIpZcn3I/g4lDKJnjhmQEpO77
5WVi+U0wRO7UIjXQKariocS4I3a7ZH/iAZWLRnuUJhtxBER0hwUuKd5qcgCRedUr
5nlzdRB0lPk31YYsHJYdBZ5n4WpYUqddZZBPUxo2AwpwzLLfsgU2Pn8MDrTXZPN4
x2ur1UMw43LQn2A5L5xgg7hOsKr4/YLo+xrxfs5hto/gki/i5ulYvnLF4PWKyADn
AV/0oBB5GLxQIYObqVKltva54q+P2K67tTqQjayEiViDjVYuIEtrM8aBFyUYQSwR
BjWJCC0pDRCbTiSd/ww48tTtN/G/ChC7bSY4DYc8tZiMlbvKL9MWGdjthhAYnl5L
OQumW7cc5DlIsac7QV3tWY/0EVG+r3eyGk/9Kqs+a/ExL8kTIdp3f5/BUwzObKIR
0jnR4dg8n6iYA6d0pJHX0oOSLcxSMQCV8etI2NNXK001ti8qqrY=
=ZYFI
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
