From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
Date: Mon, 23 Nov 2015 10:49:55 +0100
Message-ID: <20151123094955.GA31868@ulmo.nvidia.com>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch>
 <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
 <564E6B6D.80006@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34097 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbbKWJt7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Nov 2015 04:49:59 -0500
Content-Disposition: inline
In-Reply-To: <564E6B6D.80006@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2015 at 02:38:05AM +0200, Vladimir Zapolskiy wrote:
> On 19.11.2015 04:04, Stefan Agner wrote:
> > Thierry,
> >=20
> > I realized that this patch did not make it into 4.4-rc1, while others,
> > IMHO less important patches which have been posted later (e.g. sunxi
> > whitespace fixes) have made it! :-(
> >=20
> > Anything wrong with that? Or am I on your spam list? Note that this is
> > already a RESEND :-)
>=20
> You are not alone with this problem, I have unreviewed changes in
> linux-pwm mailing list sent in 2014 :)

Please either ping me or resend patches if I don't reply within a week
or so. Chances are I've either not seen them or meant to reply but never
got around to.

Also, the Linux kernel is a community-driven project, so I fully expect
contributors to review each other's patches. Review isn't something that
only maintainers need to do.

Thierry

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWUuFDAAoJEN0jrNd/PrOhUAAP/iaPUUquzfFwlaMNFeTknLRg
6cyuhWg/7NdkDpkqydtIMiUcbFnGLz1t8bLkPg5kcfVbEbELzeQVaSthFT30vgkI
8vqsZr5xK/BVXoxGoKlmcxAhncpgsuYOUnvfrE9F6IKHau0FIF/RA9seUGCpHHyQ
sDh9CvDhQBCDiwGP9pVmgqcvdF4t0RNmTb38ur5+xT+VKo+YPPBv56ZXGzszSPRs
AF3FyKHgvnJ8Db8w99wUxvRHqu+qcBRk1XgLWKMsOIL19WCSole0SprAttZ4EgAG
ZO63Jez+6J56NAC6qsUDREFyulpjUfWT3ndHBg1cngZM5XLgipfXPnui8GU9XZyn
g5Kf8QmV60Gq5eiTpWxFKP1jTB0LUTHHlcs4PsbEZ6Uqh5Ov6cRcrRP47I4IEnuE
v0zdC5jamacpny7MRHfB5Sn/vR4faka1Y6OrdvfvDAIsF4Z+yjemY0okmC14zx9z
0sOPl9Czs8XdiZYEkzK/Vgw0TJhSWGuIRPsyHXX0Bv3lRnVHmz0GcaZM2aFGU/dw
5sj8RBGTjsY2CRbr4gjtGC6YwZRQ8COF7no4flqoyVc2SnhnrJL5OUBy0Vqe7Cfc
HRTuHIm9d+hlZnbfDO1tFqnwUWhrZvFuNP9gBy16U72/7R1Bi8c90sw8gGRxtV3f
AND92zHrO8lspWThcRsU
=Q76z
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
