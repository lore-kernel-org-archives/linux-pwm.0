From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: atmel-hlcdc: Convert to the atomic PWM API
Date: Thu, 6 Apr 2017 16:14:32 +0200
Message-ID: <20170406141432.GB8438@ulmo.ba.sec>
References: <1488379731-12951-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33709 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935124AbdDFOOh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 10:14:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id g19so11808959wrb.0
        for <linux-pwm@vger.kernel.org>; Thu, 06 Apr 2017 07:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1488379731-12951-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 03:48:51PM +0100, Boris Brezillon wrote:
> Implement the ->apply() hook and drop the ->enable(), ->disable,
> ->set_polarity and ->config() ones.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changes from v1:
> - stop the source clk when the PWM is being disabled
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 227 +++++++++++++++++++-----------------=
------
>  1 file changed, 101 insertions(+), 126 deletions(-)

Applied, thanks.

Thierry

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmTUYACgkQ3SOs138+
s6HVaQ//Zs2KxsjofS+DaFX+Glmztj4z8arwZgmzqmnX/KNKyrkNXcTzMIHfBh+t
rsmsYPb2NOtnn9v+2FCiphRGiFO9QsDZ19wGmr+qMO+UqTCt2s5tFtM0AC5yVQEu
XnBWm9GyvzhMPJ9DIc863QISMXM4oA5IZQeAJem65v2c5lqbzjKHxYova6MnEF/s
65HjCxqjI5byiCWB9Hu45NZ5L5TFIssMu+ybFTMBC+ItagEGZbGfinnu8KvQtkNW
I3GISQ7xLaZzNOrBOEOTxihGsjsiOVXlJ4IZZKow1PbphHqH+humuhBKG2NFdKNV
Noax211hE/SkdzOGa8+KTteYsGjnjWKd6a6CUDuddrZhUvfdswEg1xWzGy03iVbN
cRV0Bt4z9yaCscJCMvZFOoUAPKotLkIp0VdCKi+DO5TV+2XHOYKwfgsWomQMOAQC
c5wjP9WnS9/moY8cvSnA/30ju6xOUhsUv9SZKo7PT2gr4nI+Yxwxo5dA28KES1c8
jHXIsi7U42HNXvRLLN9xPcF4PusSCIGqls7fTCf/bP79woVuIcE/M1gou1Pb9bxR
Wmkc/YA8scj62Q4o2AzYg6LDi3AcCBgj5TYW8nSSPrSDwiluzSKRkzoZS1IZMe7K
mjkAIu5Sicpd1lQIfrI39YokPzYw5i2CdwWOtINGIaiwamTxL2g=
=e2Se
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
