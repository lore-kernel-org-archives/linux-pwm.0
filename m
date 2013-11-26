Return-Path: <broonie@sirena.org.uk>
Date: Tue, 26 Nov 2013 13:18:21 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131126131821.GM14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
 <CAOMZO5CtNnma8Sv35P3jeNYQiLV=jdmN0Q7w2_LFMOj-nTbPZg@mail.gmail.com>
 <20131125133659.GA30476@S2101-09.ap.freescale.net>
 <CAOMZO5DW3pSxPGe6N0CRiCEc+iVV9X_13JbzAvuFbb4jide+zw@mail.gmail.com>
 <20131125172904.GP14725@sirena.org.uk>
 <CAOMZO5D1qR8+RH=w67=2LVQVJXiuPSo7BDXWt+KaBf5sOUFuPQ@mail.gmail.com>
 <CAOMZO5BM5Tfyfi05D3cyYHAVeR5X9R_5H2ceo_tfcb7Qn_-W7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="43A0Eiy/SPt9g0V5"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BM5Tfyfi05D3cyYHAVeR5X9R_5H2ceo_tfcb7Qn_-W7A@mail.gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
List-ID: <linux-pwm.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org


--43A0Eiy/SPt9g0V5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 06:58:30PM -0200, Fabio Estevam wrote:

> -late_initcall(regulator_init_complete);
> +core_initcall(regulator_init_complete);

No, like I said previously fiddling about with the initcall order is not
going to help.

--43A0Eiy/SPt9g0V5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJ+ZAAoJELSic+t+oim9ay8P/2Y6XKRrzBlASH6DfyufGfgD
BhVxpaAtjWFLJSGQzOCi04X83PzcteEzMY1WX05aP/nvuGMkva5jtP1+OKpkNGWo
o46NYm5xu9GPuBAuz43zWhQF4IWbAnS30NM0TuoFpoqYuAAO6OC1n7W7+3B0kmH2
DvmuvEBomuz3tjUmQ6zeFMiWFRWpAu8ZPAai/yfYndHJA2+gtEftEfI1E/oCNOKq
nUxBNq0mE+SjyDdQNQjow3k3D+RrcBks+HDs4RSwi2qbO6ILXHXQoMKSTmFIcoSY
ERuPAfBZci/CmB3qsjJ67gXhusVmvZO58Ymob9maQt3aCLZliXONMvRv1V0GObaz
R6CB2h/WTuBzUYu/eLHQWZ+4jRTwevl8kEkChaOueIX+p/aTPa+pnC45DbHnvA2M
r8689kHMYnUVip3bESj+10WSGRGOn8lk0YYyfEFWI7JL46zzkSGxJJTqVIhBl8Ug
5JeWqAhu1/TBd8YXsuJZKZQBSu9KfWwzUhbTSY1MSyazwikjd5992ajr+cC+wXSf
W0F8NsHeXuhWlpJFKpqQbEFnpky9Z985S2mZjHYXE83ZsPzgTXq2Y/EiF2lQ0jmL
1gw0N2TisOeJpGItxJ7PuDXn1tv2EyuEBqc+e1mj33Zu1OdEmjvGDEXxhj4W4oOt
cz4INzbamKEBkq541yvc
=pCaD
-----END PGP SIGNATURE-----

--43A0Eiy/SPt9g0V5--
