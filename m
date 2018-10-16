Return-Path: <thierry.reding@gmail.com>
Date: Tue, 16 Oct 2018 12:46:51 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: renesas: pwm-rcar: document
 R8A779{7|8}0 bindings
Message-ID: <20181016104651.GA8852@ulmo>
References: <7f2ce332-a128-073a-762e-fb268780a145@cogentembedded.com>
 <20181012112114.GE30261@ulmo>
 <20181015185713.GA15344@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20181015185713.GA15344@bogus>
List-ID: <linux-pwm.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 01:57:13PM -0500, Rob Herring wrote:
> On Fri, Oct 12, 2018 at 01:21:14PM +0200, Thierry Reding wrote:
> > On Mon, Oct 01, 2018 at 10:57:39PM +0300, Sergei Shtylyov wrote:
> > > Document the R-Car V3{M|H} (R8A779{7|8}0) SoC in the  Renesas R-Car P=
WM
> > > bindings. R8A77970's hardware is a generic R-Car gen3 PWM, while R8A7=
7980
> > > has an extra error injection register...
> > >=20
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > >=20
> > > ---
> > > This patch is against the 'for-next' branch of Thierry Reding's 'linu=
x-pwm.git'
> > > repo.
> > >=20
> > >  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt |    2 ++
> > >  1 file changed, 2 insertions(+)
> >=20
> > Applied, thanks.
>=20
> Some reason your tree isn't updated for linux-next?

No particular reason, I just had not pushed it out yet because the build
tests were taking longer than expected and I had to clean up a couple of
minor things.

It's pushed out now.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFwZgACgkQ3SOs138+
s6FzSw/9FeyQp9q1T6sOloRSEknt6BjV8JEmsCx7FZobkCWgK6N5P6RwJG4JPPrJ
7tJ0k24fJLwMzg6gXBoPwdPwkrAJnpoPeU3YWPoLG51c9mrsNsVN/mQoCsq9zYvb
rv+g6XbvLFkBGfKM8BnHSBSMxbSub5T9vmedyoIMMAq9UBByvAH1JmCETYbkjo2t
Cq+FGsanNrKm8eIIUYiiLTbqY3kgIV2jlhkZSAcZuv45SwST5VfoWCgQeYfpBLmO
pPQs+wNQyhLvfJj+9uPE42mUoKXj7Di9XEnj5nIdEQgLrfkcClCx6RjI2wt3giQM
yGf+73BspGIntRVKscj4nwdhU4ZQM+nl3kwRJB6qVMNOdMCPRhMNZ2PFTCGGE0NY
UvmBWv+AbSYdZ8/VivDPJNLTou4gg0G7wC4CV4ikLSmLTjy9xXm12aAQM53fB4qC
Ipl+qaEoZeyAzJsxronngS+0fzIUj67ZIiCWditaiUKbeaOT4vdv1dgCCYbL3FOP
yLfFtu2Cv0t3gJHYG7zI5Uu2ina9aQlwedtIl77CLa2q+lCXnbJOMBWjFgT49pr5
/LN63p3e21PjMLp4FMhf77SkzzE8/N6WeoVXjimC7fE6WgDXaR8/EGzyzpACc5gn
0PbFcyKaYkaLlHOxqr18kc94+/3PYohh7Vz1ssJunknNwIGOeXw=
=rTY8
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
