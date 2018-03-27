Return-Path: <thierry.reding@gmail.com>
Date: Wed, 28 Mar 2018 00:18:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 RESEND] pwm: imx: Let PWM be active during suspend
Message-ID: <20180327221816.GE28163@mithrandir>
References: <1514898119-19632-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <1514898119-19632-1-git-send-email-fabio.estevam@nxp.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: festevam@gmail.com, linux@arm.linux.org.uk, lw@karo-electronics.de, linux-pwm@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 11:01:59AM -0200, Fabio Estevam wrote:
> On a imx6q-cubox-i board, which has an LED driven by PWM, when the system
> goes into suspend the PWM block is disabled by default, then the PWM pin
> goes to logic level zero and turn on the LED during suspend, which is not
> really the behaviour we want to see.
>=20
> By keeping the PWM enabled during suspend via STOPEN bit, the pwm-leds
> driver sets the brightness to zero in suspend and then the LED is
> turned off as expected.
>=20
> So always set the STOPEN to fix the PWM behaviour in suspend.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Hi Thierry,
>=20
> Resending it in the hope we can still get this in for 4.16.
>=20
> Please not that STOPEN is also unconditionally set in vendor's kernel:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm=
/plat-mxc/pwm.c?h=3Dimx_3.0.35_4.1.0#n106
>=20
>  drivers/pwm/pwm-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6wygACgkQ3SOs138+
s6HoZA//QUASImzmfyqeng3FaCw4zoCXy1ONZBoXxG+DqBYI1hlUpyDbWFcMM3V3
c9HJ/UAghI7+uPirs7M5yqjF+KYTYv1YqtRqlwB9lmrS4jKHRDfJE3StODTNn1Qe
rW5RF29uSDchon/s11KEs0WdN+Pl0CiBW7sA7xR/keZCv7Jq4t5HxeiWU1n8KZzi
p6sHMF90VG2TiPgG6IUjgyzxx0xpv637S0FnlhqH9MTfauWtQ06YiMwKh5xTbgzA
m2i65atRyrcBdJ6uRdEShQur5oJPbrqktDr1899Q+aPMzCJALlGczMqwlAn05sFW
ai5uGWnO/dv6hJe1x/T3CDSMKR7nDl8QpxBzy1SxiheqsDTQ6nY3AUYL/qRu5jTr
t1IV58J0tw/9Z6LwSKjsKuFKXajWV86H6lZ1lHc6TIiY0ujZaSpdLoORBdFkwy8/
PW/9XuUEOB0oeuJGHpkXkrEaEhR+40hLzqj3lVRqr8xQapAHlY+LbzhsZ7sxqcdR
fHBd2zs2sCy21ba7GYr2sEMga5JmcNjpEV9vvcjHWG55bI3l5L77QCQ3zHfZwDIl
0fwG+JabUdUET3TgVw3vn/2ZzD14KzXMz1fToZoGB1Cv6rKpqrUqq3xFTDtkeVrw
mqST+aIdtrjMLeB1KuIUXO0oWdAU6z4DQDgpCwIQ642YOSA3s4k=
=FmXN
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
