Return-Path: <thierry.reding@gmail.com>
Date: Fri, 12 Oct 2018 13:18:48 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: renesas: tpu: fix "compatible" prop
 description
Message-ID: <20181012111848.GC30261@ulmo>
References: <7851c2c4-5a5d-dc34-4f00-fa26e80815ea@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <7851c2c4-5a5d-dc34-4f00-fa26e80815ea@cogentembedded.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2018 at 10:43:24PM +0300, Sergei Shtylyov wrote:
> The "compatible" property description contradicts even the example given:
> it only says that there must be a single value while the example has the
> fallback value too -- which makes much more sense. Moreover, the generic
> property value is misdocumented as being R-Car (and RZ/G1) specific...
>=20
> Fixes: 382457e562bb ("pwm: renesas-tpu: Add DT support")
> Fixes: 3ba111a01822 ("dt-bindings: pwm: renesas-tpu: Document r8a774[35] =
support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> This patch is against Linus' repo -- the 'fixes' branch in Thierry Reding=
's
> 'linux-pwm.git' repo is very outdated...
>=20
> Changes in version 2:
> - fixed the wording of the fallback value description.
>=20
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAgxgACgkQ3SOs138+
s6HUMRAAsHu6D3VfowEcuAYRpu5aMkCySonwVDUFtAKHmjfgGCNe/1EwvcJrn9+D
Vun83keyxdEpacoK3I97PYMJVsDyDPqVEqA35ZIfGxQ1oss2jH8STeTuIT5RkzkJ
DWQe9MU17O3JAubltJcCCqNgUIY3rFHLSw8kU+bqgTaq5tiZYEMJfxni+pfSco2w
SxNr7Vmnz71FgBYIrmx6szI38Fj+suZ+tYIk0JT1p0qgJ88MpuQZ9lYizHmKCkUe
NOVg2eGJtQYsvErqGY4OvzhOHEdk7aiChWZ9AY4Woqu/qxWY6GRgZ8ri/wMdv6AL
bfgUdPOhQ1bmoP/pxbV/mpEmf0VLZ7sT/Z3LkW3Ea3kjNsidLZLtNKZmKkJPnHTq
D2wNywUsc4JLWG6GS5ZaFA+fmJz1yFTHT0bZHh2cTAMI1ClwK8BYZeSeeion7kBV
Re6upBNwZVSdgO7VgqnPn0jsZOgNI1lY1rj1tOIasLkeFOg2uPZHZGrdrzPF1nLF
qjpF7esYuD1drqnQR/wJlJRYqBfC1Lv4JV20Xi2oGhP/Wn0KpjsHSFLVRM99gN+J
pZ4LxfOEE4uK9zQj5UHTYhirNLs8zp+WiRT9klMbb/Fx+VcUk3KklGvCLtMrqD5t
r1mVEUY9oqqOjoQMb25K0IpD6VtGSyUS8aP3e4XXiSqqx63M6XM=
=JDBI
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
