From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/1] pwm: lpss: Move clk_rate check to ->probe()
Date: Mon, 11 Jul 2016 12:49:55 +0200
Message-ID: <20160711104955.GC5503@ulmo.ba.sec>
References: <1467646587-6613-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36071 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbcGKKt6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 06:49:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id x83so14020129wma.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jul 2016 03:49:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467646587-6613-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 04, 2016 at 06:36:27PM +0300, Andy Shevchenko wrote:
> There is no need to check each time if the clk_rate defined or not when w=
e call
> pwm_lpss_config(). Move the check to ->probe() instead.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Applied, thanks.

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg3nQAAoJEN0jrNd/PrOh4mMP/2Q1iNp4nwYlHz1mFXzmJpJb
tAoG9u082MB/c20+JnV3gPd9TIt+5H+EsMjAtnrq0h7iIK/iIg4e2cR2cLc27MYw
rZez8LAZuGF0exe8GVAjiudN2L8VMgqVUCg8EdiJ5RTQW712Yy2MQwsyJn9ZqDI7
3mU9Za6x3b0S7JtRMN884qlXXrClBTTsZzLAfHLaS7X0JmlL7PKt1c5OEUzqJSgq
kSe52S2v3Nhph1/k7YhHu9qF6u8tkCpBEqUsul3c5tZw04k2CYB8flx058/CFlEK
Jw90pn9TT2jU+m0+MEhmjPts5UMdBXk9qeiTGo1UdjK0e4HeLB0dKg4svUZfxk+T
50t36MEUWkC/vFqvenyKYvozxuwhABt5OWIkFn7Iez72+cBHhVpEaf32jaS5PaKH
jBwUQLw0lUW4wo+sFNOoZYFURptZ0ypYd2GpqfWgiWMCKK8Ny8iFsF0lL/nLP0yT
QcUFxM69Sx/3/SoGzOPtEn6dUemJ/kVT0h75j7zDV9auj7vZmYxRxU/4WwUaxat5
+cI9LHasw9M8l6WgPs4SJjXRxb/xxx1jMqyPVH879fA/r4N5JsEs/fRHPAMTEkqv
9aGXxjEF/RyqB/2FZPIjVw/iWIFH9rmdCt/DWzOj0kbeELpm1IhS0Sdxdy85v4Fk
K/wFeiQ6DvT2MqsekUir
=ixp8
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
