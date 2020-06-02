From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: jz4740: Drop dependency on MACH_INGENIC
Date: Tue, 2 Jun 2020 14:41:26 +0200
Message-ID: <20200602124126.GD3360525@ulmo>
References: <20200527115225.10069-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMlb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 08:41:31 -0400
Content-Disposition: inline
In-Reply-To: <20200527115225.10069-1-paul@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 01:52:22PM +0200, Paul Cercueil wrote:
> Depending on MACH_INGENIC prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: New patch. I don't consider this a fix but an enhancement, since =
the old
>     	behaviour was in place since the driver was born in ~2010, so no Fix=
es tag.
>     v3: Commit message changes (invert Acked-by / Signed-off-by)
>=20
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All four patches applied, thanks.

Thierry

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSPYACgkQ3SOs138+
s6FaCRAAnn+U7/uQz3zkEYTEbfnxMr8kVUv6gVcGH3Ix8HVWYWXpWh753iKyp8AP
vwfWWrO1oy5hh5JuygD21z+Ax5Q80jdohC5q88WMX9XrGuxxtk0ZdU/vXUKr1Jq8
XF9QGH6AyFVqqTmQb0vZfYpMqMIPmV2xOIosKvHr30MfxnzWgijcAQyCzqHDKKtn
nZVMeZXwOzwfGM3ZFGy27z4o2CqFepCzwtqdFBkGLM3pHASuI36M8luC64dYgRzq
/G4JRz22p2+0AJ1MurJmb7jTvujJbdBYKtm5hMJoDxjxONFqKEgfMPXbnVdSGWFW
eBuQpws8toP4Rzd5VTJAZ2deC8cd4gWvKCHLip9EtuWqHgIwPrVSLmRw/DiVSVif
r/Wex9A1iPHKAuo9yUAwph41N0qX6UegVSUV3yen9PZwduHGY2eJ0xhHsYQdlSLW
xqdDga5hvavcrg62EPWAHch1z1vrRKC7tO+DbRSnaQV/mJEqhnf7+jM0dB8723F5
9zirSWPQkWojhNPBE1dbMqeaitDoFOqHZ/U/OlMY6NHDFincfxk2jDQF32ehMfrm
c4iDIaarl73UlGCtgNYO1/9SFrRcdKXeBLhFaLJyU/5+J+eSO/LOCdcHVKDXXTuM
iGhac5iTre7gSZlU4CfS58AglrjmNMMbEbkt1Mh4PhxW++f20A4=
=yUQX
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
