From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: mediatek: fix up PWM4 and PWM5 malfunction on
 MT7623
Date: Fri, 2 Mar 2018 11:57:19 +0100
Message-ID: <20180302105719.GC27178@ulmo>
References: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <051f401bcca48ece188023ccf10b2cedc7a25a64.1519891948.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Zhi Mao <zhi.mao@mediatek.com>, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 04:19:12PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Since the offset for both registers, PWMDWIDTH and PWMTHRES, used to
> control PWM4 or PWM5 are distinct from the other PWMs, whose wrong
> programming on PWM hardware causes waveform cannot be output as expected.
> Thus, the patch adds the extra condition for fixing up the weird case to
> let PWM4 or PWM5 able to work on MT7623.
>=20
> v1 -> v2: use pwm45_fixup naming instead of pwm45_quirk
> v2 -> v3: add more tags for Reviewed-by, Fixes, and Cc stable
>=20
> Cc: stable@vger.kernel.org
> Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Zhi Mao <zhi.mao@mediatek.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
[...]
> @@ -151,9 +156,18 @@ static int mtk_pwm_config(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		return -EINVAL;
>  	}
> =20
> +	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
> +		/*
> +		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
> +		 * from the other PWMs on MT7623.
> +		 */
> +		reg_width =3D PWM45DWIDTH_FIXUP;
> +		reg_thres =3D PWM45THRES_FIXUP;
> +	}

I don't understand this. According to the condition above the above
would also use the PWM[4,5] "fixup" register offsets with PWM[3]. Should
the condition be pwm->hwpwm > 3?

Thierry

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlqZLgwACgkQ3SOs138+
s6FX2w//SIhj+docsdzcwMIo27Gc2qmUL1sMCZXhB8dEGZ8CDXRDRyGsNE/eCkkD
5bZrN3ie7XkkcoLjDqhJZM5PvsiqR4367yRlWg5N/PsCwlji0wZ/1ZfV0bxBxa7G
k9A9aJt4PdRAzT6gJh7IQmbnlMvbHN1NpkSli5HYrGtEO7t0MewAPRjJ8/KIcscI
IlXX6ESptOP3+3xbu21dOzxV3T2zmlPKQmUIfDLH9PkcC4RYOuANbkWb0em9hpeq
dJtLSqqwXh3WSMjRgJpKIT5qiKhuuiQRoWJyUkImQfjU5kH8QC89/yVNUXcNo3pT
NvZ5cqihFktL+dLd+qS+nIxh2VQDF+NLHD0G8OBlYtSe/X44NkPtS+gOMBYDSKLJ
L3g0REZRfQXK2QtWZ818acUnd/MC9E5x2O3C0VVh/YzIEzUr6qKTstk33+QX7xUc
6kLWtO5ctV180OdiyWW0qE/v8ZoioY/KTeNQU5Mgfz1YMEkhSP8wSLLRBMknJ4+n
n7CE172HhAUGsbhYA2/eRG9e8vnTyk4fdWrcjryRoxtjGGsG2JTOkOj5x0M5XR3o
b6O2JQXS8hGJXBzjK7/PtKnbXc8hMjRFT1HcZ4z4ztNnaSufCEdKPWlXRLZQs0ix
2PAvnqATUdF3IegKJZSmWJ5joIT/kJu7JmmzXM2GoOM9FAUNZ18=
=4k2G
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
