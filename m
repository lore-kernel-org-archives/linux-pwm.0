From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/6] pwm: rcar: Use ARCH_RENESAS
Date: Mon, 11 Jul 2016 11:44:52 +0200
Message-ID: <20160711094452.GF5823@ulmo.ba.sec>
References: <1459424356-26061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1459424356-26061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33462 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbcGKJoz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 05:44:55 -0400
Content-Disposition: inline
In-Reply-To: <1459424356-26061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, linux-pwm@vger.kernel.org, magnus.damm@gmail.com, Ryo Kodama <ryo.kodama.vz@renesas.com>, Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2016 at 01:39:11PM +0200, Ulrich Hecht wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>=20
> Replace ARCH_RCAR_GEN{1,2} with ARCH_RENESAS in order to support R-Car Ge=
n3.
>=20
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg2qTAAoJEN0jrNd/PrOhrAMP/0gM8YBM6POHbWuPMv1b1cfN
gPlKk+HFFKka4IvGcJZN80jcGypyaE9On74zXNv9VCwSpAS1shuQFpExLme9+t6X
J0sdO1gPzxjTMIFWTfwzUg82QW23NMpK1qWIDcWvgg6FxT4vWEKgZrfRaInxLQ+C
S//cQhuSkrji5HkPo0kYKSd/Y0o7DTWFv8bgTzLzzRzjSLvO/gcKBX5pBHRPr71A
ll6ohOSJlARGoY2sloUgbpczzEGpSfQmM4c5RB/VHllKNDtJB498G3EKLp0Q2zmr
AGpBqdkgclThVKMHYLFLew9qzcP9+PkbPrPbCFlTMu7ODpBYl1iFRYvDpVe7lRmz
EtIMPYzA0Yg9Q5eM4J8J6//rmqtYTtYmenrTFyZvXN/hfpynohyfuWdPdW2/u5C/
/Cu9jzT16qc1CXZRFwoejEanX4eu3/F/M7DUrZ5K4b66A5Z2dzQwVy2jn6Z/o2q9
tikEFr9C3ZKLnv6IAB8hHc5NdizmM5qZVhi/WxozKnVkJns+dm0kG21Ibx/R6OxP
o/NcD/LmhDIUpmR50OHUAySEj2nR7gWjAt4JD8fZib7vn+DVS1OnX5AZVEQhqZbc
0iYCRV/U2hHIllyxdXLZjf5V7AQzTFyw0tXi1t9J0mGc6QatuRgA3IdbGexJNSn/
OIxFtfnoLPQ+O9P+xthx
=AFMx
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
