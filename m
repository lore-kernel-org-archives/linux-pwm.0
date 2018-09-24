Return-Path: <thierry.reding@gmail.com>
Date: Mon, 24 Sep 2018 13:36:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: renesas: tpu: fix "compatible" prop
 description
Message-ID: <20180924113633.GR21032@ulmo>
References: <7851c2c4-5a5d-dc34-4f00-fa26e80815ea@cogentembedded.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7UIJfHqpdi+oBJdT"
Content-Disposition: inline
In-Reply-To: <7851c2c4-5a5d-dc34-4f00-fa26e80815ea@cogentembedded.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org


--7UIJfHqpdi+oBJdT
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

Yes, that's because it is only updated if there's actually anything that
needs to be fixed during a release cycle. Please use Linus' tree or,
better yet, linux-next as your baseline when sending patches.

Thierry

--7UIJfHqpdi+oBJdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluozEAACgkQ3SOs138+
s6HqoA//QUu3/HCSEFjPBhVhMsqnZDctK1LiHC+NWT3NhlahCQ/gXQSWJPjZTNTI
UuEnIhk4DaIGAhAQ9rCTbTLWT4oEDRHnqDak967YjBP3KDZdX16wYXbJIwzImHRG
0tjae1gWtAczjXn2S8v+BEL0XEKQUhsR+vxheBSpYWo6oVTh+9CShmps/3simuGK
bislJBGEjXQt+hH0FS5KmTFqONFGM4VENlO4ZpKxr+UnAJyS8H/K4SzdrL1rCneM
iu+YkTrWytCrCm4oQpzHc7CUPJTWYJJDIMdmtePjRX7jDA2A+ata9WRGhss/GQMg
ss2v0W3mEgou2/X7HlAgWTc4ZZqt21dv4T6a0wr9RQwp5ZsnCBNT4YqXeIOkAGJU
YYs8G4vqQnfHTUcBeBhVS83P0/7HjjJ1VtgC4hYW5tk4bfgHjGAiR9Jg1Gc8FbTU
uOa4+qjFvTjccUBl7HAasrPYn8bNvPQx6GUobei7fAL3DumFtV7AgQluqYJX2ewJ
mnT8eb/hcxFvJWie2xTxa7UqudvFtdMtxwh3KRVPB7UK3PUQiRA/OqqjeJbOW4Gz
/sKFZEn8na+aiosmlNJ0qfQ/YG0kevSF4WaWr8mO0160Zk8T/7SzgpOXAkusa6+A
WnyDtANlK2BDHGpzjYficKxP6pfXVgoRRz5qj4jYzMrlfOnxx98=
=J5hv
-----END PGP SIGNATURE-----

--7UIJfHqpdi+oBJdT--
