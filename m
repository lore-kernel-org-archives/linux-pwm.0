From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Date: Thu, 4 Jun 2020 19:16:20 +0200
Message-ID: <20200604171620.GA1158773@ulmo>
References: <202006031539.4198EA6@keescook>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgFDRQY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Jun 2020 13:16:24 -0400
Content-Disposition: inline
In-Reply-To: <202006031539.4198EA6@keescook>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2020 at 03:40:56PM -0700, Kees Cook wrote:
> The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> lead to skipping this code.
>=20
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7ZLGAACgkQ3SOs138+
s6FIpQ/9EdDHxyq+7OCwqubx0/mE/4j7lmsLu+HYUpekTsHkXckRQHO4QO7e7Ii3
MOksak4nU+QCCkG0xCDWHTvbI4BpaXITB+FjkiPO50m5Fai1YNL9paf19GMx/jvc
UrPWbYDxYyqK/hhrNyztmwqddeHDPIWgUcUeIFXHhTzAtCZoPNmLW7XX4PZwMazc
Wn85Uvm5Ydo3DON5YebxJhsbAoYzerh+iSMastl0vnTuBMFRwRSkgDU1HwnHFvaG
TaFmfWYdlAlq78zwr4YMbScJF98svgUlW9TsB6Bmzou+5U3AWfNR+hxQNhVqoBJ9
UoCFEZp7EeYlydLGrRP0/ygMoIQDbOIVtAgxlL9zttG6gMw75+IG4Y+fvY8wEYXL
GyiPzHuQ+sFODN/iSxMuQr4/oXrE1xeSi7vjppfZFIimEQw+sl/fLYxxplilJ2Q0
i3KZgxytiMySK11VUiF1i5deBF/C7JtnXiMjV5AYpsAMHqwG0dLczmWLFFJy+4i7
OxlV29miA0bt/Zuz8qYHY9LvbYQT0FGqo8hMA1CrIq5Jj47ZG3zptIjwilhL02kv
/A8/0pOmpfpZhKgCOcdEh7e19UGU9YwVkcCSe2pwFOT895xql2B2OVNAc3dfZtAf
11C47mMwG8wwSbVVbpFppgdKWonnul9tJUHh/noI4PYSzCrxTNs=
=+mI0
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
