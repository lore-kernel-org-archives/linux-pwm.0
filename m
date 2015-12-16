From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: lpss: select core part automatically
Date: Wed, 16 Dec 2015 16:52:46 +0100
Message-ID: <20151216155246.GF28947@ulmo>
References: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36576 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965747AbbLPPwt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:52:49 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so7095845wmp.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2015 07:52:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 01:25:17PM +0200, Mika Westerberg wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> We have two users of core part right now. Let them to select core part
> automatically.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/Kconfig | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYjOAAoJEN0jrNd/PrOh698P/0gI9Vg63/Pbx0bdvY4eiV0c
L3MPT8rW/vjYv6U1HqNNHXubrXcz88Dfqyo05Sojttjfy7ZoV3eUoZUh/GkBTCWj
l/7WetAt6Bu5Ok7pAOQHRHG49YhMdpr1Xo0KpoJ6ggH9mf8yMGQB9vR4rPmUHcv0
G/p4GPyR1zQoYvS2Zs6KKYgEe9rWs4LBArXT5dPxqnD3/+98iGxfCV0zuM96cofz
/whadESZ2Zyt9N0vdIQTl6Hzo4N+4yZIkE1SV/sIJM2KRVGmOAbH6iPCE4M2SHz8
Spaeb64nonvDYIDY2y9czc/asEsA5/RbKSJqDe3NwEMMKTp6BVrkg6KX0aTQA4KO
Sm5880MTpxDSITahiqPFqahgLkB7MT15Kaf6NGuH3+QxwSIe0fIsp4yFiYcY6lGn
B5YArgs4+SdMZgcHugp26MPoFuwfHO+kfsaFYdxY91ZiLFbcRpopv4VbHDCqWLY8
4AslEud6IsdjuPk/WUkVZYy+OKYba8A1p36uCGJPdxd4d+DNxGxFdhMVce8mvNVg
zWnJUxP3jvMr90IG5ZJ5YOB94P3rjV6m1g2Qdu9KO9vu4cwigmS5ZCAMtCfNjYo0
B4Kkgbd7E6HNGrI/1uZdELSbtCwXbRUeRkLOmI/yxQGEWdS4J1kUJz2PIMDak1Lf
7N17/JSbA9FmCWRcU+lF
=wj50
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
