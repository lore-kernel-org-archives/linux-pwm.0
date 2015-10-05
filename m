From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: pwm: add MediaTek display PWM
 bindings
Date: Mon, 5 Oct 2015 17:58:43 +0200
Message-ID: <20151005155843.GD17612@ulmo>
References: <1439882875-19596-1-git-send-email-yh.huang@mediatek.com>
 <1439882875-19596-2-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439882875-19596-2-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2015 at 03:27:53PM +0800, YH Huang wrote:
> Document the device-tree binding of MediaTek display PWM.
> The PWM has one channel to control the backlight brightness for display.
> It supports MT8173 and MT6595.
>=20
> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   42 ++++++++++++++=
++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

Applied, thanks.

Thierry

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEp4wAAoJEN0jrNd/PrOhgjEP/0PeXNAY/3AsRyB7tGmDzDAK
qEWnOTcehKNmVWoZ7ULJYGLlfP8hUAsBTQLYxgOERXY/VKPTucjCoNos4hW9OdYL
+a/8R/K2UxLfTXJhHcmilBxKGbgL/kt0hHu6NzU3hp+wCRxto/u+LrBM1Pq/W7NZ
Bw0A/Xw865nON2Btv6bo5lxqaiaNV5WfCK/LxBSz9dcIqO0qlZntQiJUMp+lMP9Z
VexRhieNzriIeRtx6cKHgBIifNuDfjh2uHa00i+CFWvTNeA5kn6UO63dRJdDJN8Y
9L3MbTgFMnoAfdBo8JPqCVaZD2ndLwEblzvQn3auRrB/zGmBXiCle37Jb4NKqPza
G5gb3znegsM/LL+/eT44nqXhcUcKIjbyeRoJZsZl24EjLR+YR+/vuzPpeMLVYBwd
0R5Qxdl8t6HCkwTT36l0jUUa0NTfTI2pKMe+1MjgDwOfGQuBQqRTTEUqSkUu+Hh6
nelr8PH0+2V1CZzaXqzFO7nFidyfHN2tPkXnZinu/EdeuaKPNP4UxgnHQxGmrvB9
lPjypfnU7n+4X3YDTZPM9/OjTlZWOxzu9+3EkkMwa7t/5WGVtf4QypwZWk804JGQ
8D7FpnbW00cYr/GeX/ObMh6huL0kljF4p8QzY6DVshJPskhRzue5H399S/LlcS6t
ZE4H5XZW/GLAnWx6yyMc
=EoyD
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
