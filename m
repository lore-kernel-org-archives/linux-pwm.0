From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 13 Apr 2017 17:34:16 +0200
Message-ID: <20170413153416.GD27388@ulmo.ba.sec>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33389 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdDMPeT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2017 11:34:19 -0400
Content-Disposition: inline
In-Reply-To: <1492088291-5215-2-git-send-email-svenv@arcx.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 08:58:11AM -0400, Sven Van Asbroeck wrote:
> gpio-only driver operation never clears the SLEEP bit, which can
> cause the gpios to become unusable.
>=20
> Example:
> 1. user requests first pwm  ->      driver clears SLEEP bit
> 2. user frees last pwm      ->      driver sets SLEEP bit
> 3. user requests gpio
> 4. user switches gpio on    ->      output does not turn on
>                                     because SLEEP bit is set
>=20
> Prevent this behaviour by letting the runtime_pm framework
> control the SLEEP bit. This will put the chip to SLEEP if
> no pwms/gpios are exported/in use.
>=20
> Fixes: bccec89f0a35 ("Allow any of the 16 PWMs to be used as a GPIO")
> Reported-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 112 ++++++++++++++++++++++++++++++++--------=
------
>  1 file changed, 79 insertions(+), 33 deletions(-)

Applied with s/gpio/GPIO/ and s/pwm/PWM/.

Thanks,
Thierry

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljvmngACgkQ3SOs138+
s6EAYQ/9EcyLKz6uZfIlZV0/v0Dqy/IWy8YKIbS69MQmXq9WsMZ8RxVXSYcVy+j5
2PQOsx3CEZy1psUyG/QQ2HqLSj7pQpXI/S6oXd648g5StBnntCq+5xLH0uUxhjch
6LmWyPQdMkdbI/4Ns4cFQ2k8s6j6d+0B5DCncbyvWAjySJpB9A7O6rg2vyDw2YP0
8XLwWSb7kIdFD0PpnT6B8a29fLIDQn0/ANphs9T7+SWz9OW3Mx0ejd+ecSca8LvY
Qkwa4SMflRo7rIQfNq0CYv6J/L4tJNW2PdyBzY7xbSJNfvYHeY6PhdZ3a6PtztXZ
iiOYoeiApsQLJrgw7kGVQ+2700VMAnxNgHPXTyKsqgcfcXjZKBsKa0U1+gSG2JQZ
UmZlBlXkbQHIuxpSLO4HciZeKS7wYAEUFV3C1KOhOLPSzGWCoqQawES0CvIAkFk6
Lf3b9OHqUdcmkd5sWG/IXpSvaKiklE1RFNnUOSJeZCfyXz8p+z/9TSxhXTegqkFK
2PuCu+FqZ04uC1n9qVrZdA9GSaaPXFtMKdsT6gabsMHOlnyW49NqTEZe9rxd6+uk
qMeUaF3n8bnm/Ir/6CdLNqCFLTZ6Ai7XbZPAcd27klEn8KM6UmBbOKQIlwZymvRS
FPl/oMEaQYrLO6xUxI3q44Fl/B+/8lW+3RAQkHZqKVMPQtz4mUo=
=K3ev
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
