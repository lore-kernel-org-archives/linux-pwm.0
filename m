From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: mediatek: remove redundant MODULE_ALIAS entries
Date: Wed, 28 Mar 2018 00:33:35 +0200
Message-ID: <20180327223334.GI28163@mithrandir>
References: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0fbf589c69bc584c46c683ee7fa38d80e04624f6.1522055092.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 06:02:01PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
>=20
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlq6xr4ACgkQ3SOs138+
s6HUog//f+3ccuA89P6SIyORWUG74S0LCkEFUo0yAzEpfSqFrFbYOpuQx380RRo0
iVf/bO2ie2weVIwwJjkQJxL1ShAnln774jL9wlEz6//zBtmhVEaMXm27vvP6dZrJ
o3K4JGyTrrJaf4CeVCNWXGWNhtlox3Rm5977g3iRudHNYOUmJSX5BMXCwdfBY8Id
3IQBBSZaz3D7xBCmIH9zDj2WoXdaJKAyCrkqtdIBpht71ykSk7kG11BsKL0D3N5K
7kg6ox9xXK4/5ZOwbki/LCkxGMY+2O1E7MkYAZvpc7CxXimvJjzHogXsxQAQ5ABt
/X16xq+GBKptkwonpPAtlucDdc/TGp2VEpR7s2+Rha9PVqli+UvErWMsZ2wLLJm1
QM5PrXCRdH4tKloFQubMt8vT09QzeKCnsJvEEV2frGmv3LXgV0fkk6Eo/3Irswfc
9rP+n8brwJREXdrBmhQjSKBjJWWCB8qDPYpA3BKj9TyquAMQiiGhB3Ei3wKDlP/5
ysjowi8d7dFvOQQC5uKtu4pnt1U+Tvuev7fFQR37Y/ioDuKocOnK1CrQ5jxsBHP7
UDaUqJ7bEeDgqLQ4u2WLq0OVlqWApaOXeEiCog5L+orLNE6SLVN4hrA9a0WmPsdc
pYXy4IbcnzPVEebBgvbvUDJi2OeXSwHiXu1x7YLDUGfzhkNse2o=
=hf8s
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
