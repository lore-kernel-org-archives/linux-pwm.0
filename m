From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/5] add support for the new SAM9X60's PWM controller
Date: Mon, 4 Mar 2019 11:58:49 +0100
Message-ID: <20190304105849.GA5121@ulmo>
References: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551113039-937-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 04:44:30PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> This series adds support for PWM controller of the new SAM9X60. The diffe=
rence
> b/w this one and the provious AT91SAM9X5 is the counter size (32 bits com=
pared
> with 16 bits on the previous version) thus, allowing to generate signals =
with
> bigger periods and duty cycles. This series, modifies the driver to take =
into
> account per IP counter size by embedding this information into driver's d=
ata.
>=20
> Changes in v3:
> - collect Acked-by tags
> - introduced patch 3/5 which changes the name of objects of type
>   atmel_pwm_data
> - changed a bit commit message for patches 1/5 and 2/5
> - use mchp_sam9x60_pwm_data instead of atmel_pwm_data_v3 for SAM9X60
>   compatible data
>=20
> Changes in v2:
> - add reviewed-by tag to DT inding patch
> - move PWM_MAXV2_PRD from patch 2/4 in patch 3/4
> - change commit description for patch 3/4
>=20
> Claudiu Beznea (5):
>   pwm: atmel: add struct atmel_pwm_data
>   pwm: atmel: add support for controllers with 32 bit counters
>   pwm: atmel: rename objects of type atmel_pwm_data
>   pwm: atmel: add support for SAM9X60's PWM controller
>   pwm: atmel: add PWM binding for SAM9X60
>=20
>  .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
>  drivers/pwm/pwm-atmel.c                            | 117 ++++++++++++++-=
------
>  2 files changed, 79 insertions(+), 39 deletions(-)

Applied, thanks.

Thierry

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9BOYACgkQ3SOs138+
s6FU+A//S48LmAI/PMbxIqvim0FueiPd58rs3d5awKFxYQmsJOUbOZuYE+jlTB6H
zQkvYuYm1X881bbfPJN3TqhYAE3UeZu/+IOr1UEXrbV2y0Df5FIPCv5OF/YjU3WX
071mp9UBWAPyTAr72mFP0+sh9wBQV0cvnRKthVd1PdvFKDiSJQLRoPw9s1+Wcjy7
Q5kU/4+/v0bShwM/yx0IEuwmTUCECs6LQM0y1IPV+iDBwIDCCUNO0/Yn1R+b+vcb
IaGRp5mB6Lv4Ksl1jjJcgMQO6hWZewFnXIrxXgXnzx2GOxRJs4rKvAhBAG9cICvx
UxuKlM6biK6/Hr6Sy474jn0toy7hM+Ud3pLFFMd9I/aecd2nTflOXXDy9922/ETf
1fd4RKk2zTeuOZR684nofLno6uogDKDcAWeeZaADjJowNHH6UTzCazkKCKaYr9Ha
kvuLEsjvTbttTFvfD7H9RxjMg+EIVGYEYBmJJJ3+5oQ95wcqR+JqLJ5loKN7XsM2
j01xkwe8jbfE3v5Hu7qdTilorSgEy5hJV11O+RyDEKoGW50ZRCLtFRAj22wNj/0l
mRjShtoTM42LWaX1rjZrCZnVsvEShEO36ai/Yx/h4Zz9cmd2Eq/WKBxvdHjRiMtP
/gdKsiMkofCDRgIx8X9P+Mv+qISp2hza4mn4OJxo8n5xcEQu1O0=
=5rG+
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
