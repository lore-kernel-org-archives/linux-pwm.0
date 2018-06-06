From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
Date: Wed, 6 Jun 2018 10:18:27 +0200
Message-ID: <20180606081827.GD11810@ulmo>
References: <20180525210843.1821071-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 11:08:30PM +0200, Arnd Bergmann wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
>=20
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but no=
t used [-Werror=3Dunused-function]
>=20
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
>=20
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Lee, I applied this on top of your immutable MFD/PWM branch because it
depends on the capture support that you applied. I wasn't sure what your
PR timing was going to be, so I thought I'd do it this way since I'm
pulling in some last minute fixes for v4.18.

Thierry

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXmNMACgkQ3SOs138+
s6EcEBAAqwZUm5dl8ofKzCnB3CIifLjGBte4Yw5gnfyd4+WYlkth7fNMZgdCV+Y6
0wb8O7kD1G3XR8JUFY2va6xkwJ+kZ77MUcxS30tv12y8XFngRIHnqtC8YEh+Yfnm
mPT2Ci5KLl239jRiTgptWRxCzbbXCNpkGl+nzO5nFtvQ7RGGn0uhBzYvwVomnCMk
kF9CXAzPe53zXerh4URh9UeU+64tzr1k9CntsqrKTAraqIlaA4tdGTGUfgvZxLu9
CB7ejodJ5RXz7LbseIAjjoaprECU67Dtl8wrrhIE8GCqbV19TlczkLnUHuurPwMo
0VewxWb2XP3hPGm1XDuflPAvsTvdBS/8JasVLXPN8N4+XyNtJhZLYykUBkaW2M5Q
7OJCsgfh2Z8wVaNZ0n/l4CWyJDt2SkMFz1SNbDAlEbowJ0XCYTiagZsGAcrf32VV
7RGtYlCTq8rZ99jVPUQsLBbbZZMgclG+NFXSGMnjcTdP//Ihf3Dw9KdMA8M3VgDC
jh3DGrp1MAR07/diomHi97CX+9IAPm51VFWcKvonbPgHn7J9mckddCR0onk9h+wC
6W4gZ1MTJpFcXL0nmBKMTU6DQPTzHvpCsdfmCBfbTVLKf0tDDBIHpS/JH8s776Ab
oZ/dyickV62XE4f4C8X/Cf9/P141PmceysLLzotgaoj+HB2GOts=
=/eQ9
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
