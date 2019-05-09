From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/1] pwm: meson: use the spin-lock only to protect
 register modifications
Date: Thu, 9 May 2019 16:52:42 +0200
Message-ID: <20190509145242.GZ8907@ulmo>
References: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
 <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LvlcLv3JjFtLV6y2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--LvlcLv3JjFtLV6y2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 07:57:48PM +0200, Martin Blumenstingl wrote:
> Holding the spin-lock for all of the code in meson_pwm_apply() can
> result in a "BUG: scheduling while atomic". This can happen because
> clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
> Only hold the spin-lock when modifying registers to solve this.
>=20
> The reason why we need a spin-lock in the driver is because the
> REG_MISC_AB register is shared between the two channels provided by one
> PWM controller. The only functions where REG_MISC_AB is modified are
> meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
> in there need to be protected by the spin-lock.
>=20
> The original code also used the spin-lock to protect the values in
> struct meson_pwm_channel. This could be necessary if two consumers can
> use the same PWM channel. However, PWM core doesn't allow this so we
> don't need to protect the values in struct meson_pwm_channel with a
> lock.
>=20
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--LvlcLv3JjFtLV6y2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUPrkACgkQ3SOs138+
s6EbQQ//cCrVsIOMfus+LS3hL9db6Yhpor2moT9YI9tTtoyGZjgbCupOilKeMqDu
jj5vflVwl/AWtW6okavjVj+xaUaUxNxHxm9Nx2yWwDo4fmhZ5BcRhg0O4bfo55eY
ED1NvERiM9P5TCCsnakPJxc/VVUt9voqU0C7TR6CzxlucTUAn84GtQNhdyMKJV4Y
3XHr2fYynP3UJbv/WXXSoIO4VPNOHO9/c/FkdPN+51lbum1pxeUXOB4OIqEzSwCh
Y175JhoOMqt7nKy5AnWWm20IpgEOA7MT4/gZDOkeyVni2FzGeHFeA3w41fwdQnl6
aM7mClWdYGY5WqDLpe+8GOhTD+LeNxlLsSPoo6H5M+YahDDULYoX2f0QT2U1UiX7
MFMTjDy2gNWfPdO1y+ynScbFVW6VCuczmOelwMdQdWEf5U7kYxED7zNHDJGmemE8
tQ0vuLZEDPqctCwACswaDYagHgDBFPD575sqJmf5FvA7aMedjFlNNamfK5t1rB/s
lrgYobMqhatckbeeMUVBVipxtL6N6MYbfM8pFO1GULGnC5u9q8plRGsB+X0na0in
gk9+9DAYpQgrkXRsKG0McHbvEWGckogX3FbckxivAj0wRnQwSM/cgswcHGwJs3GR
ZfJBEEqf8UAEQSQPu+gpHm5py7KWRO/taKr98J4unhGfNzh9mow=
=HHny
-----END PGP SIGNATURE-----

--LvlcLv3JjFtLV6y2--
