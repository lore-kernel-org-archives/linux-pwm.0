From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] pwm: imx: Implement get_state() function for
 hardware readout
Date: Wed, 12 Dec 2018 11:54:32 +0100
Message-ID: <20181212105432.GD17654@ulmo>
References: <1538403588-68850-1-git-send-email-michal.vokac@ysoft.com>
 <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538403588-68850-3-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:48PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Implement the get_state() function and set the initial state to reflect
> real state of the hardware. This allows to keep the PWM running if it was
> enabled in bootloader. It is very similar to the GPIO behavior. GPIO pin
> set as output in bootloader keep the same setting in Linux unless it is
> reconfigured.
>=20
> If we find the PWM block enabled we need to prepare and enable its source
> clock otherwise the clock will be disabled late in the boot as unused.
> That will leave the PWM in enabled state but with disabled clock. That has
> a side effect that the PWM output is left at its current level at which
> the clock was disabled. It is totally non-deterministic and it may be LOW
> or HIGH.
>=20
> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 53 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)

Applied, thanks.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ6OgACgkQ3SOs138+
s6F0JA/+PsKKR4r3IMdSC/zZZHeWTuvGeFHiqatigpM44BbNdvtXxy75Sjb8HYCO
NRHA2+YRUBABYWu7A5lXY7V1TxKizW07UOJu7kduFn09hdjtIUjKPqSHWTX6IZAV
rXW1u8VDfH2DfPHWmpIShK9zw92WVVczYfUkcZMgF6U0LrNbwGmTzuQ4125db3l8
pjgEuQmALtBMEaZS6GzBU6cgTqcdVrTAxYEjTX3YQRKEJqDlpq0YP+wJ2w3yjRGK
aQdGYb0vpyrxHyszflHbPLWFdFj/XcvhSxl1YOUyzkYrtqSx6HOXqamB7fQFzIW5
XFGWcq2xfx3dVVfcBUy6xaqJjP8D8iXvaAY2ko+wAvnUhboR9jKt8JW8fqyOZIx7
TEYqDFgox8yeQl29AnFisYCMVJvXc13TXe6Q128UPOTGf/V9Eoy/MUwzQMIIcSYR
Dbp/mQyQR4qLLdV87IpI9lbdhWAxfuJvk1E6eu+WB8eYkrYlkgKbkg4Uxo1agOZC
LCl9cQLmVhbxkvJqiLvvwS3s1BSTLQEihMuVEyb18PLnhkQtx2BVnHPC7ooVpFF4
3QD5sz+YtcIH1Cu3BEw9Us8YiVnGjOnBpeq80Sebs0xnVrNkkd2K9hvmVnej7t+5
0UQ73gZSAFXxJOg6bO9JpiIiYQ1y9mWXXA5O4JXkAZMrgEWG90s=
=LARO
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
