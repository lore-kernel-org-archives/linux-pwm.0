From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/2] pwm: mtk_disp: keep the trigger register after
 pwm setting.
Date: Mon, 20 Jan 2020 12:54:04 +0100
Message-ID: <20200120115404.GB206171@ulmo>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
 <20191217040237.28238-3-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44422 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATLyI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 06:54:08 -0500
Content-Disposition: inline
In-Reply-To: <20191217040237.28238-3-jitao.shi@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, sj.huang@mediatek.com


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 12:02:37PM +0800, Jitao Shi wrote:
> Move the trigger after pwm setting to avoid the pwm wrong signal
> output.
>=20
> Remove the regist enable trigger setting in probe.
> Move the trigger to end of mtk_disp_pwm_config().
>=20
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Same as for patch 1/2, please make the commit message more useful. Don't
say what you do (because the patch already shows that), but instead say
why you do it, what the specific problems are that you're fixing, etc.

Thierry

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4llNwACgkQ3SOs138+
s6HDxQ/+IOGqWchokwjeBg42kfmwMjHb1KEpMro+54eRGoYNxpDIEVacCzzxSTsE
5buLHuzucUZj84iAYDWzzw+m2VVpVrAUf9U6GKXYfPuv+jrXDUqZGU1FYELRTWBt
NebebfYiaeLrx3/ZDF6FRuoVusubMGexn1RgqCqruOyhB9dYG4z+j52zol+EUG7K
N2nbVTzyUn4RnpK2j0KDGW/+vJt8TSwvowgwOq3SmWWqUzA1XnOI/CUijfDGjGh3
ggGS/koW3h5zkErcEAiGLJ4ELlhEbj67ytei8hh8ktRLAZjSSYY8ktE0Q7/q3V6T
0DMxKPzlVOEpfr2/KEQ4r/ibEYDAyJ/Ab23nEw/aMjFq4DXFHCXPkVrRJzjFBHKi
eGt2HbzDbEBH6rrFkVaiXwstx+81m4Yqlm58uzdS/iMzFADo1Zke4enAF3LtY8LX
Em+JJX52sGRjFzOIlveGHY4MqICdKM0MkvO3VDS3thaQRnK/wdrA136/+rmJOMi/
U6JWvcGMxPVuZGDukaRZRXDa5gys5qFSdeVS6d8rU9a8NmFcO91gn/K4Pks60mtS
mNuchXD3oZ5boHb80GoqW274g5wY9M/haw2QMEeydodtUWAz0UIp9l3v+vRqWXC6
8hV3/yVmxZiYhazGk5EZ84wGwflGHZZ4ruEYsMV95wxIvgB01GI=
=TZoJ
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
