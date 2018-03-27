Return-Path: <thierry.reding@gmail.com>
Date: Tue, 27 Mar 2018 23:52:44 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: pwm: renesas-tpu: Document
 r8a774[35] support
Message-ID: <20180327215243.GB28163@mithrandir>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513690500-12165-5-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <1513690500-12165-5-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 01:34:59PM +0000, Fabrizio Castro wrote:
> Document r8a774[35] specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2->v3:
> * No change
>=20
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6vSsACgkQ3SOs138+
s6Hy8w//fP7B993jKyPK4fykXDI+UxLy8mEwMrz8r+AMhVF8zteMlqstp3YTb7Gx
zqY5Z2ZXTr9lpJULgLVeD7vxQ3zU8luLFyed4TwcxPC1lD562nGaoGW1L7POIYEw
Pet+BtZeN1Mu+gVhEdn2GXU71091grnSG4W3AFve4+IaEkQvyXozqi2djIXB8Cag
aJ2aEvES9y0/R6zkbxyjBkmQ6Mew7hmQRosyCm71fAeC+2lhgRsBSiO2/O4PsgQ0
pmuayHiXYpwR9uodRjgLT4gJX3QE1hhkkk2lhanTGTdkzDznxbIFbNZNEqKZNnkg
bXvYamZBDa87rguAa1dTvXcuJDFg+KJyuJifEBnnXI5Z0GF9DioWk54+jziArGrG
/xs9iJ+bCYlc+aoVTTIRkp5lxIZnYjxGsD3RnoL795RI3oCzy7vgyJhdwIOb9jDP
7pUt4bG8WBQs7/9LHg4KdWahN55EwJhISXspRzo6bUwrBA8YJD+eSiTSiHUbYa+5
QtqeRQSOyRsE/X2WQKlpePL7hEbf23Ld3lv2XHAnXv91DK4qxkx9ZSi+zkTT4HDd
RpG4B+n7OB4580SgFyMWA+Wf9KW+/cgqTEWiWkK+jWSYfBOtAleTxxWmN+oMjHRE
NMz8t/8tnjV9wQbHtH63aPRoz6WbSQwJvhOSqybhgPZyV3AYj8U=
=SZM7
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
