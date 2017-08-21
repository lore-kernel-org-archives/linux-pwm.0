From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3  2/6] pwm: mediatek: fix pwm source clock selection
Date: Mon, 21 Aug 2017 09:35:16 +0200
Message-ID: <20170821073516.GL18996@ulmo>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-3-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498802721-32455-3-git-send-email-zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, zhenbao.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 02:05:17PM +0800, Zhi Mao wrote:
> In original code, the pwm output frequency is not correct
> when set bit<3>=3D1 to PWMCON register.
>=20
> Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pwm/pwm-mediatek.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmajTQACgkQ3SOs138+
s6Fd2A//feFy+1k86XOOv/90kw8EpraGdWn6S7bcMR9gTYIZ9Is1xzjdtPfDgUzb
JLCdYJp749seRod2ihAR/0786Gf2H+7CV6DRnFgrihfJugj6a+lIxu8p4T+hoLbr
Imob0mO+HePEMY/LzPN2zXqaYfGOkCwFZxDeecu2T192f7wq/cAD8Iwy6GaSbqdK
GH4KXwCQdxTghPEBJ83d6cHqZ2z2h0eAIEDkaUOWhORGmNapxCEy7nTftOtxpedJ
deFN/yS8ziGGbqIFqnKxahyIcElXTMsoDlDBqFRTd2xnGDDlCN0qmBOY97oC3pY8
2dPD/ykuDHXzLq6pCXCeRZiSmSKelOg1sTd4y6IoPFSWvFDQf9Ml7/+2fYXFLsqE
3h09y425U+yMr9eSGz0DmoDU2FS7LHNFx/ASQxqmSE0L/oM3KYTp7I1hiHW+SZqx
/dzCL2N97aRj8oz4EtJ0i8UY//PZQQw6GmYl8Y+Mncf4oDj74SK0nI6EVxHDrFao
ycYnQrEaVaymSNoBzRiyauTBDLhcndu8/wPSORIQdSc03c6CBknXdw9DZL6/OWlX
3mzjWY8E11kQ3fWxfuGSHpiTf0aZULogQRL6qWUV0DQUQbtM40Ncykfivsy3qRk5
9Zvq/yHp3lwH8dT8CsEjeX1plvuO+vJ0R6stOq6yrg1IUXDVVz8=
=yHWx
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
