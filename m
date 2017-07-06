From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/3] pwm: add pwm AO on meson gx
Date: Thu, 6 Jul 2017 08:59:10 +0200
Message-ID: <20170706065910.GJ16144@ulmo.fritz.box>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170608122416.1993-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 02:24:13PM +0200, Jerome Brunet wrote:
> The pwms found in the AO domain of the meson gx family have different
> clock sources than the ones found in the EE domain. The AO pwms only
> have 2 connected clock input which are clk81 and the crytal.
>=20
> This patchset adds the necessary compatible and the clock data for it.
>=20
> Changes since v1: [0]
> * Correct clock source order for gxbb pwm ao. Documenation shows xtal as
>   source #1 while it is actually source #0
> * Add patch 3 to fix pwm calculation. Issue while testing pwm with clk81
>   as clock source.
>=20
> [0]:  https://lkml.kernel.org/r/20170607133013.4766-1-jbrunet@baylibre.com
>=20
> Jerome Brunet (3):
>   dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
>   pwm: meson: add compatible for the gxbb ao pwms
>   pwm: meson: improve pwm calculation precision.
>=20
>  .../devicetree/bindings/pwm/pwm-meson.txt          |  4 +-
>  drivers/pwm/pwm-meson.c                            | 47 ++++++++++++++++=
+-----
>  2 files changed, 41 insertions(+), 10 deletions(-)

For some reason the Author field keeps getting set to:

	jbrunet <jbrunet@baylibre.com>

It seems like the headers are correct, so maybe this is patchwork
messing things up?

Anyway, I've applied the series and manually fixed up the Author field.

Thanks,
Thierry

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld374ACgkQ3SOs138+
s6H0vA/9FMJlwUWybKpBR2fiSUdaqFzc4W7lJVvmi1n+6HuBpDvmT/H1ueZDVXJU
ldTM8M/3pE7BrUtRI+q9KUOJ1+hVhwqGaVuTkdAcIJgFfEj0JrA5SzxRKU+2SzM8
A/uw5/+krXq0WFiX6W3H0DX/Lsv5iR1SvuCrNpBnh/Z5vRR8pm5ct74oDpfBq80z
55anErK4DYF/hdVKwrxILOdTXf6Wg2qayR4kmKN5hscbIqzwOniaYQ2wDLiFigym
8rSBQEXzYcZRdSJyh6wGCsBbI2DRqMs0jAYkkSGZ8B5wD6cL5CW9aKHXy1yofO/Q
oIHFR6JaiBjGLz2Sp3Edfn2BoCl+K14mWyRyWKh25d5/c1jj/9potOVsRgtLQopx
Zqv67mQMLaMqdwmKFXWRcht+LR3U1LpI12B1FBdvaUbDalfiQkLTbpTUSOzn7QQT
TEqLaSPY9W/LboGZJLCKAC18/FQToksnwkthWRgdEknRw3cnCgbCZ5fGSJPj2JBS
OqPvlfUuLsMgZZKW8Uv/ody9pNercidWP6cWt/d+1Z7Tb1VLuvPBtTM6H1hBKks0
Gts2KjLAMoPcE8HmjynMm4ix3v4GOASshrRweU/UkCa/H8tKHlbxdI1QTauIdiS3
3QmI14rtyVfwvGeU2Q77k5u7HdqLBmacfuasj6F2iXZlNVRs+VQ=
=CTmo
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
