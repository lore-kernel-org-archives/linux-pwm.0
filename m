Return-Path: <thierry.reding@gmail.com>
Date: Fri, 12 Oct 2018 13:21:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas: tpu: document R8A779{7|8}0
 bindings
Message-ID: <20181012112101.GD30261@ulmo>
References: <ea104bc7-ee9a-b638-36da-6c6af1e622be@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <ea104bc7-ee9a-b638-36da-6c6af1e622be@cogentembedded.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2018 at 10:57:29PM +0300, Sergei Shtylyov wrote:
> Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the Renesas TPU bindings;
> the TPU hardware in those is the Renesas standard 4-channel timer pulse
> unit.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> This patch is against Linus' repo plus the bindings fix just reposted...
>=20
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt |    4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

Thierry

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAg50ACgkQ3SOs138+
s6FHUA//e6N5juO43+gd8+wMUnppTelT59lGPlabiVlDrr7hrlQzolj9Dw3skdvl
22EeGrG1ZlioUutXapb8JYbgf6OMFE+2FW9EQ9EXGdoKz/d1tCTvtGOvkHWURHsU
xnGvxznogRVmqR4uS9lp4OaSQSkq5dDw+qxBFCEyfZR0caWtZXT9zBUSlx2LyP+4
hyskqJPX1/B+9+uM8BcfI6P/EroNkYyYSmL81O+pR4M0OkL6pW3XPWky9YXLCNdE
tWxtR5HcTJdVuoYC+LfNWeHkgj4LSTVjDv+oxM3/Y76hcLa130+LDZdaaG00km1T
rBVIHM7cJLJDhrwykk694QxO2AyBlV1vKPbYYVyFxxPf1Pb/hbMgonlaJnd8rVO2
muNGS2HQcx+lB3/xPp8bHH/KWu2uWxKZzcCTHoHyToyMsz+g3THD5SMydQ/Xphnk
RRjRma3/ngbfmfuEz4OMG1vQNmQFgoYX0voto+USl7VPlm2gFl8IJjgB1EfVm8gm
mKxlzIyZgpkbBgI6zOa0bF+hhgP5tg65ITru6ycQAaWieTOJNZnnOD/JmGObv1uK
bsfWJ1v1p3pO9V0Uoi8qiT9Y+cXt5FR8a7bBkvWnF7b/ih+jMBuxTorMJMUzkKTL
UKuQah6cvocbEfE5mfffIm7AcokESVGdJRPiAGqFKRevLkU4xxc=
=bDLK
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
