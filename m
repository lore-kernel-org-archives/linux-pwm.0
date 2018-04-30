Return-Path: <thierry.reding@gmail.com>
Date: Mon, 30 Apr 2018 10:34:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: meson: fix allocation of meson_pwm_channel array
Message-ID: <20180430083447.GJ2484@ulmo>
References: <20180428212521.29328-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline
In-Reply-To: <20180428212521.29328-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, narmstrong@baylibre.com, khilman@baylibre.com, carlo@caione.org


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 28, 2018 at 11:25:21PM +0200, Martin Blumenstingl wrote:
> Using the pwm-meson driver on the 32-bit SoCs causes memory corruption.
> The result are some hard-to-explain errors, for example
> devm_clk_register crashes with a NULL dereference somewhere deep in the
> common clock framework code.
> In some cases the kernel even refused to boot when any of the PWM
> controllers were enables on Meson8b.
>=20
> The root cause seems to be an incorrect memory size in the devm_kcalloc
> call in meson_pwm_probe. The code allocates an array of meson_pwm_channel
> structs, but the size given is the size of the meson_pwm struct (which
> seems like a small copy-and-paste error, as meson_pwm is allocated a few
> lines above).
> Even with this typo the code seemed to work fine on the 64-bit GX SoCs
> (maybe due to the structs having the same size in the compiled result,
> but I haven't checked this further).
>=20
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm1ScACgkQ3SOs138+
s6EYkQ/+KygMKcOQWqiDjl7JCtrk2tqDYpkQuzvXSyFUpscyxNNpzIIVy3ErkTDU
7E0G7SA6MSEBnaTcJ2fZkh53ADzediVRL4AOk4zBC9zKuOL+1GR7FXTb1tWClq6t
z9WI7EzzR/6XPNw8u3SoaqvRsyQMAeDm2X7whKjm8lJtaCamMvqslYxhDHR4pbHQ
hdGArVunRWdMs6ztVreucnbQ5edn1D81fRlwQ1mses8Zsr3mYvsLDhc3dNkiBOOo
70XMViCyaz31guZW4P4kfRiqdf4G8C+kJyTKX2HaN0ffe+pX9JqIwULKNPMBAwEj
1BUofOP9jV1dYphj7CnlL5smPmWHN3gY1/8lFTa+tgK7hL4ZjDr1HNznQUYbEzdb
j0AlBAKm9K8by6bjukl2OhHvpD50b4ROliNpSFJm5hqrd9mDHpU2S9xBcl6oDmGL
h0oiIBF+OTbLMSSBrAelIIh7RxSN63A5/5iH6vgWFA8N4g/PzQ519ey0I/NunpeZ
9lHEvfMENgrgl3DPme5CVEVxkLFrxNaRqOXhg7w7REIXYLXvmju/mXJqfQrAxuzi
7poecf0qugag1/OwG79RfIP5ke+TuE+m9VG3UV/amJGSPeg6uSZtqDBVqTK43RJ3
dKOMkyiCyszFaeKdaO2q3Dx0pFVzw/yMuRV4bIgECciKO0zJ7FA=
=A8mL
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
