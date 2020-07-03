From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Date: Fri, 3 Jul 2020 19:04:03 +0200
Message-ID: <20200703170403.GB2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-6-j.neuschaefer@gmx.net>
 <20200621000220.GB131826@piout.net>
 <20200626235552.7820a999@kemnade.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200626235552.7820a999-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 11:55:52PM +0200, Andreas Kemnade wrote:
> On Sun, 21 Jun 2020 02:02:20 +0200
> Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
[...]
> > Also, do you really need a compatible string to be able to proe the
> > driver? What are the chances that you'll get a similar EC without an
> > RTC?
> >=20
> Tolino Shine 2 HD has the mentioned EC but the vendor kernel does not use
> its RTC (not checked whether it is present or functional).
> As a key for grepping in the vendor sources:=20
> gptNtxHwCfg->m_val.bPCB =3D 0x50

Thanks for checking.

(In the MMC dump from my Shine 2 HD, it's decimal 50 rather than hex)

> Tolino Shine 3  and Kobo Clara HD do not have that EC.

Fortunately, this set of drivers isn't needed at all in that case.


Thanks,
Jonathan

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7/ZPoACgkQCDBEmo7z
X9u0KRAAi+x9zdV1G7QAjFMdps8yowNKZqvPUG67nQfu12vy08hIG/kmkkp4Hegw
Ca2Byi/d7zXOrFzhmzK9gCdb05mFOEsAOtVCDsd9hgx/02Asj8Xk6zc5x+VwxVAk
bLNcwERwIU/nQuxqca1otbava3hzCysevndTcySDdsb+YzhRyYIkcolik006kD5d
DpWFolL8t38dbmalTIxWLz+3YBpnCeNzdyh6i79awbxtzC7E1PgeMwukIxv3uF3B
WeyGN0NAF3YMJxJkRRXtPwGK7htJznbViBkRurN2BAs2Dnmbizy6YO3OhH7J1JsJ
HjmURgE++Io1JCM7U3uCubrkamzj/mkdfR2oD2CKuY8MYFf1HEKmGZryBaO8vL2W
9HwhdkPgQiDZh5hKrFu15yD1Moww2yUKrwhKjXwbMm2qernQWqZilq/AV40UdPJU
7gcUoICqUasE97OlAKCCJHc9lzzOLfwZfv4bZfGMNgDjww/heNGX7MXByrPp0lin
u626AekNKTmDrdyxpWXVzdybtrB9dzv4lR7cv3SY0VPqiA3jAgd5dSSRqdVGMFs/
nUYJDUA1UuSt6ZHnODMxg5dkntQ08mXETVS9aAjLIIJZID/73BLqOVRHn7R8zZwB
vwTIWBBVaSJOD+Ew1V0kr3Vc0o1yI+Io45kHfUAavwW3SZJaaIs=
=9VB3
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
