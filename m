From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to
 simplify code
Date: Thu, 9 May 2019 16:55:12 +0200
Message-ID: <20190509145512.GB8907@ulmo>
References: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RacQGezy2Y99S6cT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org


--RacQGezy2Y99S6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 05:24:02AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-imx27.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--RacQGezy2Y99S6cT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzUP1AACgkQ3SOs138+
s6G0tw//agEcPC0fIAFdWa9AvRrl3E+d0tfQxSd+oiQ9H775nxrULNP4gVV2dBiy
qyW5SsswVKV6Rl+S0Q6JvhEjo/j9ttZrwNe/f9jOTWvX/mQzqVufbAIhBikAP3r+
6yiFICJ/idWQClOG6bkuaFBDNy/gPIIO82U+womvNEMB4fIkUEKl3wn0ZeEfJ8lN
cxnNdFpTG8f098WBVeQSsoxJ97jzbQQNOkmIbEhBL75o5/gh5rqky8B6O2vD2Ncv
rI04e1aQ7svRv2bVJIPpeHkAcNg0McMmjKvJQmnjCMD2FomkFbWDpcheIgCwIXJb
yg77VXfdIbwUlIeMy9JOS6kOj/m3dbQbUoyMDr8H6J9RZ43+Xv1Neyv15+rX/cJX
fHP1ZIIJUJy8QD0aal2ybA6jxFknAmE3loPYfCkiVwj+tj/m9Eb2Vjfi3ca1eFj+
lXZoiZG1rYaplFjCOedZcY0DwgnOcBmbLhITnc8IOBd1QPPScNmYj8ceZr5qn9SL
XNLpCj7cBULCJqIOKvWR2g9EY3/vEg208Sy/B8O7kbjT67uwDCEKYpuof7SzXe+/
VvS7MHaw4uJzxuBn5ES7thUf0R7EYS/HkaMsdlPqCjnHeSHNQTxMwLOSF+cSE+G7
QNazMfE0RaE0HX9rW9CrG3PSfv1GKq35/K7tZ1r90Q1OKVeddSg=
=TiNT
-----END PGP SIGNATURE-----

--RacQGezy2Y99S6cT--
