From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: PWM on Suspend To Ram
Date: Fri, 21 Oct 2016 09:29:01 +0200
Message-ID: <20161021072901.GE2670@ulmo.ba.sec>
References: <CACUGKYNYLnRkWuaMWsc+524C2TscjL2L2AU-eFP-JNKy879AvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32863 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbcJUH3G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Oct 2016 03:29:06 -0400
Received: by mail-pf0-f194.google.com with SMTP id i85so7861452pfa.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Oct 2016 00:29:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACUGKYNYLnRkWuaMWsc+524C2TscjL2L2AU-eFP-JNKy879AvQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Shawn Guo <shawn.guo@freescale.com>, Liu Ying <Ying.Liu@freescale.com>, linux-pwm@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 08:50:29AM -0700, John Tobias wrote:
> Hi Guys,
>=20
> I have an iMX6 board and I can put the device in Suspend to RAM mode.
> While in the said mode, I would like to keep the PWM up and running
> (The iMX6 PWM support low power mode).
>=20
> During the suspend mode, I set all the registers that I do believe to
> enable the PWM, but I am not getting the any signals.
>=20
> I would like to know if anyone here have any idea how to tweak it in
> order to accomplish for what I need?.

Cc'ing Shawn and Liu. Any ideas?

Thierry

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYCcO9AAoJEN0jrNd/PrOh0soQAIWVEbpUWmc3CoGQs8mKQzv9
8Gj0LuYxI+zpQcIU/vyJf2FKDKFPEt2CDU6y16osTwx1CMRiV5rjbrrrMrEs4YJt
y/FqAmH2W5oRF7guwUYrNcwPUxAwn5nQs1dVQs5Zx2ChaVX2YYl/AQ9UretesQgZ
dr/7gNDSxiU9oFJlrtT9Gm5y/gXs+wzeYTU3IToA0phj9EvRaReiZ+4F+1CUA+Jw
o1tOMa/jQ1Hi/OxlttECOYMFB/mOWtjIHIoFlKbWCa8u+1gDHaqUtnXR6gECurQn
MwSBdudJyHR3nsK8APEQP/YUnps+XEutNEV1YwlV2feDdBK2UenaZ7H/hKXWvTAd
ZGBWskn2oGqEH+GED8gJoM0v+MrVZ1pPPt6p20Butx1uk9H/gvgF/qZGk8lVXEPl
6gD5mMlsb7xyBiOFyVDM4YtrNFqRio5LAGLklKvXon0uD7XlBL/aWi3aqx3qgIQ8
yO/zJa9W2slszjjOl2uSesfVpd/pJn7VefQzBpM7yhW1qJriBoSHsoh3SqFfwepr
x3g/3RMuXGsegKGKQPHoLJk5GLwRl3uHB+IEIPjtV86VcZs7FVszgkQbs8ESkerd
9R5B2mV8eUA3tkbo4UPs8OYyxzxQgOlKXDgfosOTWGd+Q9l3FGSAj0k+zUMDNj42
7qvj1ZiMY8TUHRpSLJm9
=2NFe
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
