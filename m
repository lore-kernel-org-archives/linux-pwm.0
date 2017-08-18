From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: pwm: add description for rv1108 pwm
Date: Fri, 18 Aug 2017 17:46:34 +0200
Message-ID: <20170818154634.GI18307@ulmo>
References: <1502699477-8063-1-git-send-email-andy.yan@rock-chips.com>
 <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502699868-8315-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 04:37:48PM +0800, Andy Yan wrote:
> Add device tree bindings document for pwm on
> rockchip rv1108 soc.
>=20
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>=20
> ---
>=20
> Changes in v4: None
> Changes in v3:
> - make the compatible string be: "rockchip,rv1108-pwm", "rockchip,rk3288-=
pwm"
>   for rv1108
>=20
> Changes in v2: None
>=20
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-4.14/drivers, thanks.

Thierry

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXC9oACgkQ3SOs138+
s6GPNw/8D96nXEm83w0F7HoBgeYpDE40UdayAsC2bFDsajpa/2O/T+H3YnVhYnIQ
RhSzo7Tno9gRmUbfyKJNe7WPXJhPHt7XMyoU2mZzTGKXJyOuphwGLSM+8BRrFz5U
Deu+A7RRj4QPCdnRh9l57Br1ofxQSUGz4kEKxKIYc6PME/+8SDt3Qcb3DvE2BRQY
SGCv486hqm2mlCkrho/zYb19m6aoa1HTH4HgBdvLKQtUpzog3Pl1b67893WgkmTY
riTv4uBEcGoLqUYbmLJtnn20b1VZiSeK3IRgBDJD9tgdWg5D6w45594iNgsKhqM9
lmL/qqlov8QftXUsKl57RFkFozZwb1dNSh2K/otkBuyF3FjTT/rTuZaSNOv4xpZR
aE1buBByM8Pvd1HiQnNfRUAJS08BiTYc8ykjqKBu3CdNJmoeP0LHFgcDnBIvotLN
gpBORe1pgMu0HUm6P9IL3CSyIs52Igye+b6g0XbuIeqJzSegPcccUSYz+pe0wvyl
NGaptlNxDl4RZVGm/X2HxuwaOVKVYNHwoyyrD3nMoa8zuNv9EbSp7V/1imenPpPG
enwYdqUGK/79oKmpYnP5aPP7ko2ybIumC+1fGnK3cdau0IWTKKV0aC9ODEMvr8Vt
F+d/28tKcq2mR7VWzJjqluqxoOOVXaARIkformIlP5ZXEHBavfc=
=Y3fq
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
