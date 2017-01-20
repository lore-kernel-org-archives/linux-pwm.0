From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: pca9685: fix period change with same duty cycle
Date: Fri, 20 Jan 2017 07:44:28 +0100
Message-ID: <20170120064428.GB4894@ulmo.ba.sec>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>
List-Id: linux-pwm@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 04:52:50PM +0100, Clemens Gruber wrote:
> When first implementing support for changing the output frequency, an
> optimization was added to continue the PWM after changing the prescaler
> without having to reprogram the ON and OFF registers for the duty cycle,
> in case the duty cycle stayed the same.
> This was flawed, because we compared the absolute value of the duty
> cycle in nanoseconds instead of the ratio to the period.
>=20
> Fix the problem by removing the shortcut.
>=20
> Fixes: 01ec8472009c9 ("pwm-pca9685: Support changing the output
> frequency")
> Cc: <stable@vger.kernel.org> # v4.3+
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 11 -----------
>  1 file changed, 11 deletions(-)

Applied, thanks.

Thierry

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBscsACgkQ3SOs138+
s6HDRA//ZCpzcrI1yRCOJQgwSWloCMdSJS4EmHqFP8i8zbcjqAxm7CYhOqATTH3z
kj3CfbHCwY2TPuGmP+eAGsPmVXucYkD6E724s/yC/q3SsuxBubwTW/YdIE6uG+Xz
i2GQSlbKaE8OaLMa0nM6XqdD1o7ID5aFz2wXp1kWVENuMTSvAD3Eix/DCoVw6sOz
muzx+RsRAalz3qkhc0KCrhg+hUtZuQXTxr2DfZe2nazm6qO7NhrCVjvg+uPfJnAx
QVZsr0+qh7kj3Mj3f6QMn9kL6T1rsm3GHc161xBkwMpwJI1/dTEcRqAl37hct2QZ
c/zqXO63cZffyuJYJFbuRBHnyoTkMxhMmMitND0SYlKKalnvHT/ckqSnakhLC1KC
j2JcwGRaqDdrVmCvxgOs+nOH6p6I2PSnTLXlbxnLOMdhNGeAiXIoVwniDXEc9eup
NTpgq7DkP5MOT+S3d6+gmcBpdRDj9wMXkpPu+inLZSTytQ0PpbE9LREE5pxbTwC5
IfYyiNqDck2zk8q4nSaxIRbhPBasExlMaxjTukgsxp/tRDNYa1LXdHhXfeS+xhHS
AJHz+ukp2dtgnNvbDnuto+XR5zOet3r+EsDYJETz9rXvj+zNT/BvgPfdW0YMGPXh
x0G5Ba+6jFfewQDekfEIm4hLWFeuIxSGGWIuFlzXLO6z2wm6xtA=
=IM12
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
