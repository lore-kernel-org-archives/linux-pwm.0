From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pxa: Use of_match_ptr()
Date: Wed, 26 Feb 2014 16:17:25 +0100
Message-ID: <20140226151724.GJ29779@ulmo.nvidia.com>
References: <002c01cf3290$7ad36ef0$707a4cd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:51293 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbaBZPR2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 10:17:28 -0500
Received: by mail-ea0-f179.google.com with SMTP id q10so1017341ead.38
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 07:17:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <002c01cf3290$7ad36ef0$707a4cd0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org, 'Eric Miao' <eric.y.miao@gmail.com>


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 10:17:13AM +0900, Jingoo Han wrote:
> Use of_match_ptr(), because of_match_ptr() returns NULL pointer
> when CONFIG_OF is disabled.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-pxa.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDgWEAAoJEN0jrNd/PrOhL0MQAMF76+QMGCpputOK91Gjvx/c
c6ybmO5tDoSpVnTMBmKXJrlGE+s4ac8W2dRbhlNrf9Rr7RAAQx/d778sJjHXC4V0
uxtJpw8xujwUpoLOKOZhzDTZE2tcG7gwFwm/MgA7PN/sfU6RTEs6DzHJ2aq874hg
ptQxELhAU3xC0IfS2F5Fl1tpkJuOzzSQPA9PVjoThu8a6G4GdVDtoQ8Hqe5Qpmzy
Hh3HCv485R7fVVyoGypYdwwTXMDn6n1cDZNwE6eGUH4VBzcHd4ii8zzRDVeDTxIy
qcwI94vQ5YVg3dVFtymlEuZPttePNod02OjtXzN20mpvm2Ksl3GSAe8clC7dpNhZ
/N1uM/9GmiNK3fZ7OICYm8dE8Jdvd6hUlxBkNVLca1xCHFLxaM4FdmrAo/K+KUAb
glEywLBTC04wVGkjqaeTSLDdoIj8auv8y3UWKqFad0SB5CHwHLJGJklbzEHeMmtv
2KobPJujeevJvZEDk9tZdfwiiKWD6FMkLTb5fgvMaQzH0ANbdiHgYmdKDqrjTS8/
WV+rG5H2tOlE6CycSpm9d7YXS2i/54xNhaAJ71KMT/yMzBdkpK3emz//ac99GEkK
mgo5MnuXvm0roFJkvWvLxOb+qOOPDlOs6daRPdI3igybZcEsl+Xb6fQllrI1u8wZ
1NetuIYR0tpv1humlzA5
=0aA/
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
