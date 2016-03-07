From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: bcm7038: fix check of error code returned by
 devm_ioremap_resource()
Date: Mon, 7 Mar 2016 10:19:13 +0100
Message-ID: <20160307091913.GF31189@ulmo.nvidia.com>
References: <1457227306-3142-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35440 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbcCGJTT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Mar 2016 04:19:19 -0500
Received: by mail-pa0-f47.google.com with SMTP id bj10so75965712pad.2
        for <linux-pwm@vger.kernel.org>; Mon, 07 Mar 2016 01:19:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1457227306-3142-1-git-send-email-vz@mleia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 06, 2016 at 03:21:46AM +0200, Vladimir Zapolskiy wrote:
> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
>=20
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 3a9f5957020f ("pwm: Add Broadcom BCM7038 PWM controller support")
> ---
>  drivers/pwm/pwm-brcmstb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3UePAAoJEN0jrNd/PrOhbHEP/2xgz77DVIy7C6bY5lJ9Yzc6
dIlrrDjGQSjC8NfNjfzWxHTio9+wf0AaUUe0P7AGJf2F1PQaAAe1xqFuoQfJHJ+R
wHBLOwX80XmErE78m/k2/MYIDiFJqiqIEgEyxVUDrV4idKBpKk9v/ZAx77PVejvy
gmc2KULAy6KfWLgPjs+gEQubDWOgmUGlRxxog09pHnMVta4ORWgXHYX4F2GWThyL
ZVzvE8mZ81Y5f56DoimRPe1RDqM9xuZl+K82+142zUeZy4WoWMv/DHofp3qcGwWP
1oVvFKDH8OXMun90sopPEI+WD1pPu80bmYeL2gtGUxQWSboW+XSEgZxWVmne5Duh
j1mV+9OLpIC7wnCooyLPfTwd8/e8VGWZS143BsHXle0gdJVdzHC/C5YYXVHv95Y6
Kj2X3HkIhml5py1Ii/SmZ/ImFbNYGa2nmRatIyWqbgyQF7aRTV88M4Cl/RJQ/ZGl
TBTASEkGj50PRyWzBLKFFsIQha4iC4osR2C3UR/D4A10l9m7tnX+I87xcTIX/u/h
2UFcIzUOn8crf4XKqmqS2whaiJnwG6GbCGiSJS63k0b0HNnOefm7kJYM+OfhCGPN
M+BUJKcniTCbhSxUvIdtyRq7GiPfjIp6WPE9jbd7botesDP/8LFWT1/6jl3mVxvG
LRWDzH50rUL/V44LYwgy
=QAXz
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
