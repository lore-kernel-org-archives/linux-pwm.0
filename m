From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RFT] pwm: stmpe: Fix wrong register offset for hwpwm=2
 case
Date: Tue, 5 Dec 2017 09:33:19 +0100
Message-ID: <20171205083319.GA7386@ulmo>
References: <20171107051853.14492-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38276 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbdLEIdW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Dec 2017 03:33:22 -0500
Received: by mail-wr0-f181.google.com with SMTP id o2so20069685wro.5
        for <linux-pwm@vger.kernel.org>; Tue, 05 Dec 2017 00:33:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171107051853.14492-1-axel.lin@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 01:18:53PM +0800, Axel Lin wrote:
> Fix trivial copy/paste bug.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Linus,
> I don't have this h/w to test.
> Appreciate if you can review and test this patch.
>=20
> Thanks,
> Axel
>  drivers/pwm/pwm-stmpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied this and added:

	Fixes: ef1f09eca74a ("pwm: Add a driver for the STMPE PWM")

Thanks,
Thierry

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlomWc8ACgkQ3SOs138+
s6GMzBAAjYXLdAeraut1nghelMtipcxPAw27jQw0oM3QZVPEjyvGd/Ppk2tUB61f
tzSjSRN8BIEOUHW0arj8Ikv1lgpiNevf7zEMDbZateHxV0YbS6tKP675/yWzPIEe
b+wNygJVdew4vllghgHpBFA4AZAX6Tj2rsjxOQBKmv3qmDETnReMfvMO3uxneCRj
u3mnOELhqa11HT7Pg2D8VD8S7aXVl/1YnxsIG1qAvmNULXPPOvseHHGX0TLVowtt
ihj28WExNZANbO4KWOUciK3Oh5W0l5KpkalKi5/5eWUth2Ceu1ta7TUZADU14uUw
zFQgrUGVHlyNWY9zDE0qrxA52P9aBajdHav74R6UbIPzK2wJ265KMg7Q26y8yyr9
JA/r07NI7ig8WghPyUxgc3ANQapuazV3/y54E6iinj1XvUv1PnuAUDgeh93Rg6em
WnpHHSCXsqvYE/wu5O6HoY7mLN7vgq8OoodM/4WPFzHu87lNg1kfk+D2SVWe4Ud3
tXPSqnFrnXlEWqg5h740MHEYWTS0n8R05n52YF3WMUvXazKKe8w2p4QO/ZO8gXKW
CGXUWrueV72Hkw3q7Pn8oShk4tdmSMXmmQ94dHYqbHrkr16oJgUMAsI9vSWtCun5
xJ86TlmJR7KodDZk3JqQemkLJj38bZACHTvBiYJtr7RNSTP1oG4=
=iS89
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
