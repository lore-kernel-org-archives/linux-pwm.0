Return-Path: <thierry.reding@gmail.com>
Date: Fri, 12 Oct 2018 13:21:14 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas: pwm-rcar: document
 R8A779{7|8}0 bindings
Message-ID: <20181012112114.GE30261@ulmo>
References: <7f2ce332-a128-073a-762e-fb268780a145@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <7f2ce332-a128-073a-762e-fb268780a145@cogentembedded.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 10:57:39PM +0300, Sergei Shtylyov wrote:
> Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the  Renesas R-Car PWM
> bindings. R8A77970's hardware is a generic R-Car gen3 PWM, while R8A77980
> has an extra error injection register...
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> This patch is against the 'for-next' branch of Thierry Reding's 'linux-pw=
m.git'
> repo.
>=20
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAg6oACgkQ3SOs138+
s6Hoag//XNjBTxUaH7ekXspfvIl8Qmsef4sJL6vvSVrGYTvUrIYBDAa8gDxeLgtG
HKNfYA1Gn+P4zUwcHUfKvtwBxMS6p447ClyK3cY8WIhh0milwKEuG5EvoIo3UIG/
lGeby1blqDw06mbQXAyPAyEE6DFUFEObu86IVNrAr93GBeQ6+g0h9A/7Bzw3QR5H
vbg98j4mbapaYUuNg/Bn4Gsrso5zRFwdO2MFia4b1Hsfo0dXZoCeCTGWCcdgGUbN
6S1akWMiqxBrSQ9n8JGJkaGm5RZkAAXbDSDEbX9FKfMde5fVoZ2Q2tQoq0Y/gy3f
hfZCkACMkKxXFY6UlcdOKmdD1WosaXOYHuMYci814GLqjXebSZv4slQ+y8VI+b4H
xYiB1Gh/Qh3IXLSOa6azzM3ZIQWfYYHfne8X5cTY3cWvKuLnsuxXGPmmW6Z/VskB
sM6S+RKH+t9dq6DJjFykADo/mbFtAM2pqbYpQoev0bgx0vfjUv1OMHzbrsrW49cT
rxqkQ7HMPNBs/i5uGebHeEbcJ89VvjMcbTKgNpH1kWl7tUPAf1ZQo+epVqJOXhiU
sBrBOvW5Y6T8CmTPKdio7emmP/+dgmUjY6zvh47w7cFGFPIU2b+WPPdaRVCkOLoO
QgYf4QMh1Y4rZg3bMZGF9RbRbCDXwe9IlwEDA0KIwkribgnpi68=
=4rPz
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
