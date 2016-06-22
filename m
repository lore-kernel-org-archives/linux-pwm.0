From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in
 lpc32xx_pwm_disable
Date: Wed, 22 Jun 2016 14:32:22 +0200
Message-ID: <20160622123222.GD26943@ulmo.ba.sec>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34388 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbcFVMc1 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 22 Jun 2016 08:32:27 -0400
Received: by mail-pa0-f52.google.com with SMTP id bz2so16683633pad.1
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jun 2016 05:32:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: vz@mleia.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
>=20
> If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
> disable the PWM, the PWM output is always set as a logic 1.

I presume there's a reason why the bootloader set this bit to 1. Why do
you assume it's the right thing to clear it?

Thierry

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXaoVWAAoJEN0jrNd/PrOhnTgP/1T3KG9iLpjpgu4pBUBIFvh3
0jmRC/ng6/VaDX535ISPxGxCESUlhIooNeMbyLW8ocOvajXZo45wyyNCHTDieekI
BiYe9Kj+qLlUj85HFyKM1dcr8R+NtR38Dj+k1E5QTMiPUs8y7C7jcrxl9cVev0SN
Dg2vAYdkAePjyTaPwmIWTPtRAtvVKFEz8zpv7i3m9w3AO1WlIEsyCOfvUzOvhbar
bCvWxtut8ds5X4J5VBI+jKzWlGq1w4YXN9E2+OOC6a70mRhR2FwtYdmhY8VqkdMt
KaY30ro4yJ77EqI1CfXVPulA7uHXavS4xoptj0fVNn+RGxIYEjGCtGybES8KgOYC
qdAVqFzjjFVtb9EXbmVxkUgYmK9nBcDE4OGd7hkqi7vRI+xdOifpL+WaYLs8Uufn
lQ7cleFOy7fUxwzsoiAbB5LhjXNY+3ux3Zq05qhip0z5YZifIFh6OHpzvxSPyVLB
60dCiX5djuYzIA9Aa9Q9wko90Xhi/lyoP3sVxYuopYLxMPrMFnq2M6k/wZ5uatQo
Pvtt0eX7MittvRXBhVvlt59r7DZCr8MDZNUy6u87ytDLf96PhBIckBg85+1/rNFs
hUTCAsFiy56z5hpgvX3QFbTmuvGfp+2OQrCNfDzzyqrWTYapskQd2SgLICIqt+Od
NVYbd/DB1+v9cIzsD4jj
=Gi4H
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
