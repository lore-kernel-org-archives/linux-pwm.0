Return-Path: <thierry.reding@gmail.com>
Date: Tue, 25 Jun 2013 12:21:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH -next] pwm: renesas-tpu: fix return value check in
 tpu_probe()
Message-ID: <20130625102155.GB21137@manwe>
References: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <CAPgLHd8x180B9OxscFeiLrnYT4dUf66hZCxSJO_1E+uE5udx0A@mail.gmail.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, axel.lin@ingics.com, yongjun_wei@trendmicro.com.cn, linux-pwm@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 10:09:57AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied with the change that Laurent squashed in. Thanks.

Thierry

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyW9DAAoJEN0jrNd/PrOhwrEQAML6jM6rRPmF7XvbUvWUAggp
kTJVsKoRE3UB+iHZnDshrQAUUHcHIg9BiCTrjM4hmRbLnt8YCu/DPI/msPshgOBb
R0qsrG6Gs+o6t6Y1RwIzH7BXY8TDw0zaZJXyOgmTNXYXemyMmaWDHgRjs+Fv99I6
jmDtxUcEmJOtz4PJcLpxea2TfCngw+/EmRaQYNcP7P4O/4IRobo5I5AzCf9NpHf1
4c/zWmIJCjhQ4IFuT67xHEW3230BR5Eg0O0pUwyrD/2D9/vIAGTCr9oX6l1+NdTQ
9QcN7455RQgndSit/1p4hWmdxW4WWkl8zXChERxWZu2y5AQnehXLfeY2c7lvpc+1
9b+QkHeb6tQ5kh0QVEYLsO97KAhboi0DMfenANd9047Xcnjzklr/Z74styEyL3W0
XZpiqijBJolT5VGg/sjgbDtW7Tkd7I6d/sBMnmNzh1jZwjaPBoOvCSzo03eeCLN/
vlUwvvp6BLGiMI0HLcLRp5Xkf+kPyWuZJDh+EyMqifZupzk8dZhn/0ZFmN7r+lGV
DBhtStyvuHksLp1NYsw8brVTaXADfdy0tJzPWlLrlIzVVFh5aFtAphPNpkrQmIty
+QNtsrWSx6ku7/5Z/lVUMbjkmJzsIFO5abOA6UvKiyrZYcvE0212yfIS39MHbr5d
JMKkUXAKyOmLtOWj1pF1
=nCcY
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
