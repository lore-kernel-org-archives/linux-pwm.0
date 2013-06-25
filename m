Return-Path: <thierry.reding@gmail.com>
Date: Tue, 25 Jun 2013 12:18:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH -next] pwm: renesas-tpu: fix return value check in
 tpu_probe()
Message-ID: <20130625101824.GA21137@manwe>
References: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
 <19060081.EBSPSCq8RF@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <19060081.EBSPSCq8RF@avalon>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, axel.lin@ingics.com, yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 10:59:49AM +0200, Laurent Pinchart wrote:
> Hi Wei,
>=20
> Thank you for the patch.
>=20
> On Tuesday 25 June 2013 10:09:57 Wei Yongjun wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >=20
> > In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> > and never returns NULL. The NULL test in the return value check should
> > be replaced with IS_ERR().
> >=20
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> With the change noted below,
>=20
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> Thierry, do you need a v2, or can you fix the patch while applying ?

No that's fine, I'll fix it up when applying. I should've noticed in the
first place anyway since I wrote devm_ioremap_resource() specifically so
that it never returns NULL and the error message wasn't required. =3D\

Thanks,
Thierry

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyW5wAAoJEN0jrNd/PrOhRGoQAJiOyJ4GIIOfLRNlW+wI6kYX
fx7ruPL1Egs2+pUBlrLC5USkZ+YdtX5buBk3OIP5bU7qhsrYIamVKktnMWRRt57J
2ZVWUzB2IQMtH4GrIGLb8gmvZhF8fFli7uvoV63i/E2ZiPlbQjV+qMZX1E+E7YbQ
G+Jla7pOnh5tH467FQCAs29n98j6sekXoJg8ZI+I1eJcviEFo0EB+oQDBvp72JtK
Jq73GFGMVSQDb//85tYvVY8oBulZY4ANPDD5O9/TwD4IudZuDDh+Z25grWAKu336
dTZaXQuhRoS+/I0DAYNzzHS4ew0eSFiQ84I/34i9ZLZMaqXdJRl6601hzjjqrONF
ZHakQwAunIv7XrhCW27mLHI+yyfj9t3vvAqFoky9jYQa9WhFXBdReRMjaCame/ul
uL0nikIoiDPeXCclM9Q9NIl20d5JejTRf6IPE94C2KDNzm9wu7pxwPzkdIqh1ToO
UwYezFEi7YtV2TAThtxQolWxW5SdLlf5FIe/x5shWEKSqCySGzCX+lbFYr8K+TI9
SVdZZrmGaJl/GQ3dVFscguyiZ8rehT+vU/lH9G2wKURYyMnigVmrGsT/PEyl/JfE
oLdG3271TajzGqUtelM+Z2883hC8rVbvV0tLkNUUwZ2AlsH4uwDx4xfFLsOM4Vfw
ycKtt/T4eRMmtAkJHa8F
=0raP
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
