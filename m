From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: samsung: Use SIMPLE_DEV_PM_OPS macro
Date: Wed, 26 Feb 2014 16:17:40 +0100
Message-ID: <20140226151739.GK29779@ulmo.nvidia.com>
References: <002d01cf3290$92feb840$b8fc28c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:63479 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaBZPRo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 10:17:44 -0500
Received: by mail-ee0-f48.google.com with SMTP id c13so611136eek.35
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 07:17:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <002d01cf3290$92feb840$b8fc28c0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 10:17:53AM +0900, Jingoo Han wrote:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDgWTAAoJEN0jrNd/PrOhrlMP/ApEM6YW6FXx7VrMqtOZPAVZ
qqP4/i4wDCyK4ZdJGhL1Ds8FUlu3lOM7KYcKxDcSUTfjCbYY7/GUVABowwkK1ZRG
ffouqqFlO8Hvwh3jv2hEmPDKKhJK5JknB1KJM+MKVbIorXIeLeVD7eiVbTZeWOsf
MKj0wvQ7MeEYdB5FmcUchZxdAkYKX8xH9baivwPYXEsLGIbtnlP4wSycNZtyoH4Y
Ol6a1foo/wHNKAfWOIQ4WKTzbUP0uqJ4gBrIqGo2vO4NHJUKm1wggsKgpi7/8WEu
vkFr94ZF7X17xNIx4HeshTIwkCi6MuMzmlIMOeITIhljUJukNaF7OD2vVFaxxDnk
6HOsv6P/kmJF+RcC2riMJup2KEHnRc48ABRrB70oGWIlJ8xPkZJ3A1E9lsHsK6E/
N2+G9Kwf7eP2Tt6SFZohcpvRsmH/NIax2RMl6ypAY5o+MZwswCpnwGgMIXdeSPqH
DuL0cT+tbvPFxr8cLZdKrQe6GKKjRpiNzCytr33xs18Qh68jN4Ru2fuJIOovMBTb
/7H9e+mERFti0sFEDXY+wvrg9mvg2gFEfaJX299JB6jLha+g6TpzLUfjU6gsf2JA
nd70GNc/IYdILVoqUvSi8z8jbcPOZtxgUUc2olvvBoEcnUb35Jb+SS/CB7Q/f8lJ
CKTZ3XFlc2DAe8UPuaBd
=Pa8s
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
