Return-Path: <thierry.reding@gmail.com>
Date: Fri, 12 Oct 2018 13:39:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas-tpu: Document r8a7744 support
Message-ID: <20181012113957.GB31561@ulmo>
References: <1538670094-40946-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <1538670094-40946-1-git-send-email-biju.das@bp.renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 05:21:34PM +0100, Biju Das wrote:
> Document r8a7744 specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
>=20
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch is tested against next-20181004
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAiA0ACgkQ3SOs138+
s6Fq2g/8CG/uQVSKaBU25HMR73NViFqaL91JQeLESUbWZpCHbjoxHkxT0+M6zthg
7cUzkva8/7ae9VMfPqTnIeJO5Zt8Ah9sBctfCTUwivaIisWlefj4YY2T4C97secg
yRX0DNyL85FaCzUgjJZxQlmx1AGj5F6Kz/j6p31SeUGPghBYnp9ho6S+dMi1RLiJ
XrS8QSPPbRE43UIxxEoIbEqhghyVhg6rZ9GAODAoKkqbP3QoAxZyzCoWh2eupC3v
k11i9Ci85VkqunqgprqNIT4a37UfA65pNod/T/T85qRtOcgSnfrf9t5Sro5dwcFn
v14A8Up5yfgyEG0PWof93QLxkja34ZKD6gsnaY5u6ORnfqdzakUuRYGzdIk1HzmJ
2kemtXNpklQTayeM7IBas3A3NPPXkFci5UtlDCy8UtYwT7UQhziFhjOQo6goTC8Y
Cet6sT4ZVP68ebfagQojUKG4GugswQ1hJEDl147mi6i2c0sCc5neiO7vD6HFNR2t
ttDI5NkpDMmPIIrBaFvS5CIbbntLEr11DhrwkVXER5/jdM6q18WDrABB0LfpDpjW
AyjMBCvGEsshG78Zkfhnnr6qoqNmFpyTgwy8JE+sYbxdpPJ2iWiSW0QCDqbvUUsj
0xgby8TfyMdA/i2g+5ehupMfIz73NtdptVYGqEKhp0z+0PSIJRg=
=3dk6
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
