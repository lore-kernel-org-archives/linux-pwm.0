From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: samsung: do not set manual update bit in
 pwm_samsung_config
Date: Wed, 21 May 2014 12:20:43 +0200
Message-ID: <20140521102042.GB22783@ulmo>
References: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56315 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaEUKXB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 May 2014 06:23:01 -0400
Content-Disposition: inline
In-Reply-To: <1399906581-29298-1-git-send-email-ajaykumar.rs@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ajay Kumar <ajaykumar.rs@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ajaynumb@gmail.com, tomasz.figa@gmail.com, abrestic@chromium.org, jg1.han@samsung.com, sachin.kamat@linaro.org, joshi@samsung.com, prashanth.g@samsung.com


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2014 at 08:26:21PM +0530, Ajay Kumar wrote:
> pwm_samsung_config sets manual update bit via call to
> pwm_samsung_enable even when the channel is already running.
> This causes noticable flickers on display if we try to change
> the backlight value from 0 to MAX, continiously.
>=20
> So, we remove the call to pwm_samsung_enable from
> pwm_samsung_config to avoid the flicker and this change doesn't
> harm normal working since the pwm_bl core already takes care of
> calling pwm_samsung_enable whenever needed.
>=20
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/pwm/pwm-samsung.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

Thierry

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfH36AAoJEN0jrNd/PrOhIxMP/RYLUKRZHVV9akmJIZDkoCmQ
LDZZCZBM6sBRF+ZQ7BPlRTeYVA6xsnp0OCrw1DR0yf5ciQg+sYR0GgiB4QrVpTSj
1H4D7kTg9KvULveMdjSQR/aU7RjujXl36MuluG6M+NPh81wP1DIUn2P4q9k5q5+I
ra4AUheNl6b/VlJcUNoMvyHpbOrV7bRhkGsD9mzVjMMvY5HfhZ9OmOPYDuLkqbBE
aHqls7QMk4i9jWRXZcGI1SRhyWRn051lfbcs1FAEzFshR6S0sBVaxBae4U2Y7Uso
LF+dRTfWXrfmYzDHHxqojltNViQ0VeMxl9xKwR2vFOAY4Y5H6WzfTmuyRrTAjz6G
Wr2W0lAPEhxOSiik8mOIJ6RwH4QuItwtDIFN/f3TZH/VSC4Eg9M+Q4yrrj3jfIxP
Rw6Yg5IPdJsvkJQ9gKjVT8Hevsz2CHCsTWk0COpoRdz8EizVA79yptPRsYoxJ4Kb
1hVab4S2IST9TI11R2rzjkX/k3JZIcm/F6n6gDiL1lmDemJcOqy2411AhVuADIFV
YZdRKfUItnZmKe4slC9EumrFI8mmto0kuxwrdAJGXfSfOFkHQ2705fLHTZExUgS1
QmEujkggV2ObIz+kDrcQwuEyVYrKHM2pKO1ztToOWeHnbzhMNCqoA+F2tLyLhC0j
o7uGKaKyVgkEPZtlteAe
=6ZBB
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
