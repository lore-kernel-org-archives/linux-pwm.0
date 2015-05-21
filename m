From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: samsung: Use MODULE_DEVICE_TABLE() to include OF
 modalias
Date: Thu, 21 May 2015 10:20:01 +0200
Message-ID: <20150521082000.GA25406@ulmo.nvidia.com>
References: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33750 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbEUIUG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 21 May 2015 04:20:06 -0400
Content-Disposition: inline
In-Reply-To: <1431563551-9461-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 02:32:31AM +0200, Javier Martinez Canillas wrote:
> If the pwm-samsung driver is built as a module, modalias information is
> not filled so the module is not autoloaded. Use the MODULE_DEVICE_TABLE()
> macro to export the OF device ID so the module contains that information.
>=20
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  drivers/pwm/pwm-samsung.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVXZUuAAoJEN0jrNd/PrOhLvAP+wcW2owumMJnPb+XhyGf0ejj
Hxym55K1RQRPWx7hBSiQ9FUWykVWqJL4hTeqONl13FRBhAb9+IWqbs87PKv9Zdrh
a7bvJUwfuvY5lqvQpljH/n+QJVo9/Uvpjwc/ZPuhXxkhyq4cPDa8JTi+UOx9WI4D
oaXKWJOEs3BCslCu0ldj6SRJEH6UAYbm+UBw5leADGMEik/s9Y6gkmTI75bnBvD+
Oa2xuUcWd3X3u6JHQIcx5tYzhhJRFgBcM1UyAaTPmyOeoqRJS3AZoizsUp9v8PjT
lvsATDXlJkjwnxzk+69vTSdAtWfzSAxHgZS36IfbwhM5fhGYapFiwHl271t42Nys
1j6J19/VEDj1NBv20egFeUnjzUcZ+TOShBZReuHEwOyOu6sUewuB5Tkd0PDYVuM7
O/V3vM6jhaSXSS8CaiWf9BzOtdrozcYi7+QeqnJdblWFNiWuAHMpJJ/WPYT7jrjs
Htmom7arNGR7YhWyfvSmvqxtEPoTBsIVk7jPIleyBpDBHuEAVNqv2fm8ajPsrHLY
pAehs4kDpFbDyfEcycWVwmXOOB/7b6bwbauU3DBhUlGtLkJXIFpiNiLVsqvF1X60
hhKgZQNqe607Q+rczUBHgWSwayL1SwTGbPzTWUcZbTx+uHqe8TykriVNtbmzqcfo
cJM9j4o6Kl8CuvmpHijM
=QQcT
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
