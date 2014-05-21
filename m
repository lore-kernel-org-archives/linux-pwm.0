From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] PWM: ab8500: Fix wrong value shift for
 disable/enable PWM
Date: Wed, 21 May 2014 12:30:27 +0200
Message-ID: <20140521103026.GE22783@ulmo>
References: <1397049594.5246.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50257 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaEUKco (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 May 2014 06:32:44 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so1449751eei.33
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2014 03:32:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397049594.5246.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre BOURDIOL <alexandre.bourdiol@st.com>, Philippe Begnic <philippe.begnic@st.com>, linux-pwm@vger.kernel.org


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 09:19:54PM +0800, Axel Lin wrote:
> Current code only works when pdev->id is 1. Fix it by passing correct bit=
values
> argument to abx500_mask_and_set_register_interruptible.
>=20
> Having DISABLE_PWM/ENABLE_PWM does not make the code better in readability
> because the bitvalues depends on pdev->id.
> Thus drop defines for DISABLE_PWM/ENABLE_PWM.
>=20
> This patch also removes a unnecessary return in ab8500_pwm_disable.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Alexandre BOURDIOL <alexandre.bourdiol@st.com>
> Acked-by: Philippe Begnic <philippe.begnic@st.com>
> ---
>  drivers/pwm/pwm-ab8500.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfIBCAAoJEN0jrNd/PrOhvFAP/2kEFt9p3Awrp9sAcvvcvHxL
Be7zZUez1HcZAEW5PjQwsc1C2e/BgaOik4V3ItmJQVFSkhjkL7i1Bu3Z/bLudUiL
dQ+UElARfnRuXUORFeyiuZXoqWmPZk4n7GndBu05cuWySKm9KrQvLKT9wHjfQ53C
FZp3MeftTQl4HsqJGPYAI+AKKXyndTlrfYgWwEeiXj5J3YWIz20pEsinb0CTTtuW
VgJvTPTx0LBbnSqQ17Q8ugzm1ylwizd7ZhBAmRxhYkL8T9kjCkvmHHN6rNcDPZ8D
L86uEprr4BIa5umGuHk3FC+HyzWholLv7OmlSkA7vIwVNJPfYMiP7mwtrKVGF+jT
Gbe9/Qb/DdDMCUOF4gUvRVOvLqFWqo4y7RZc0pirQ+gW7VFiBtlm7bzPoqeO9tS3
hQgttugqwCSmdyVTb0ITWX324jPJ12YEqcT9GgdDgZshtzNYc46hR8tQ1XB9RgT0
8Ng5CBwMOONDrUpFcN9x0V/Hibb2zgSMoFnSjR1gieGNSv0z4VJueaIs1zMEaunV
8PdXoe0/lOfac7Z8v6mzLOco6ms2VXM5Va9eOVjH8yIuTs8dSX3SXaHJbrl1N8Y1
4ipe9e2Row2fScE4ljA2s6cz1hDsxtIkL4V6YS3KwkQE5A1sB+HpTCBKwxBy1KUk
MxpMlN8OpKVW2OV23q4l
=hAil
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
