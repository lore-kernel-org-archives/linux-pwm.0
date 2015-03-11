From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pca9685: Constify struct regmap_config
Date: Wed, 11 Mar 2015 11:52:33 +0100
Message-ID: <20150311105232.GB22149@ulmo.nvidia.com>
References: <1424770824-7281-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44600 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbCKKwi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 06:52:38 -0400
Content-Disposition: inline
In-Reply-To: <1424770824-7281-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 10:40:24AM +0100, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAB5wAAoJEN0jrNd/PrOhy9EP/059MH7UgbJZWJpREhG8w9Nv
Ze8tJ6z/RFg6xIayFS1XOpVmg4lr+124qcAvcpSLCaI1EGP5HuO8obZoTl/lM6Nw
VyvJos3icI+evtlA08P0BQ8NVyqfiugTO2M4oo7wmGcGjFrXyiA+yGbm2dxfAGBK
s6nOsNT3SWWdIk4s7UqFmKYPkB00xwL++X8enwj247V/QW2LrZfCO+t0Bu/isS7I
19TouW5wLCGd13zZHqXPB8avFLECUscLndE8hOnfTTz1vD9ZcASuhki0IaLehpTb
90nbE+EaDw+0rHhbNGdRQa6lTht6B6sOtBxh1wSJHGgrdeqnGDX5kNY35X6L1oZu
Q+eO6lsM9v1dsZCS2++mWDGoMNRCXZCniIRUW83eFVt/YGf+vjIhLH0PiuLZwS9m
toN80L02FbZmCyQZrI+Xcxzx2muTtRe9Pt4lw/2JMFgXVcOYPj9htDYXwOaYoC/B
uhHmFkObRU2aSP4tDTDymoSuKsBcNamvMgzlw0KXneMblTCd4lSjX+U7Yike9fQ6
LkI5X13AQh+yH+bHWYi5YoYl2Y/aIUAzXTZgSKHpPWD7i7f0ZVxQbCLLKn+OJ3C7
2qP+UQx+dc6IyaoCXM26fC+J78kyxR4zMn6Xtvx3Ok4MHGN0XkGGICv1CvS/z3Og
hruwA1vyhFC/0ZrZPOvr
=2J9o
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
