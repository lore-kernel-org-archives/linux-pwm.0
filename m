From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Rework the sequence of programming
 PWM_SW_UPDATE
Date: Wed, 16 Dec 2015 16:53:01 +0100
Message-ID: <20151216155301.GG28947@ulmo>
References: <1447845918-66691-1-git-send-email-mika.westerberg@linux.intel.com>
 <1447845918-66691-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34605 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965671AbbLPPxE (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:53:04 -0500
Received: by mail-wm0-f47.google.com with SMTP id l126so45696675wml.1
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2015 07:53:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447845918-66691-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 01:25:18PM +0200, Mika Westerberg wrote:
> Setting of PWM_SW_UPDATE is bit different in Intel Broxton compared to the
> previous generation SoCs. Previously it was OK to set the bit many times
> (from userspace via sysfs for example) before the PWM is actually enabled.
>=20
> Starting from Intel Broxton it seems that we must set PWM_SW_UPDATE only
> once before the PWM is enabled. Otherwise it is possible that the PWM does
> not start properly.
>=20
> Change the sequence of how PWM_SW_UPDATE is programmed so that we only set
> it in pwm_lpss_config() when the PWM is already enabled. The initial
> setting of PWM_SW_UPDATE will be done when PWM gets enabled. This should
> make the driver work with the previous generation Intel SoCs and Broxton.
>=20
> Add also small delay after the bit is set to let the hardware propagate it
> properly.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Applies on top of Qipeng's patch here:
>=20
> https://patchwork.ozlabs.org/patch/545313/
>=20
>  drivers/pwm/pwm-lpss.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYjdAAoJEN0jrNd/PrOhVw8QALtdviB9pySqUdtvz1BRSgox
HEMUPx8A9c9zmENbyvLVfRKGwEVehOZU6S9WUOZHsulJ6Q0pZeoSvJ9Yw2YbOqbW
ZN+dGt6jxlocmWLgsOZPj2/KgzvBDCmbjguyZh2Cp2ebJL4oZ7GDF0MCu2qMjWCJ
fkx/XHzWk0gE0bMSNFjKqjCCNdNNdvyYtBO1u8csmp3Hk2pTHqIkIZvusnR1jzny
VxOAV1bncjCWJJC8Yp4AqSq8TRjOsx0sun5daF+5hjx54JBcWL+XlYXY7Uw4+cfA
5TDR4Qv9MLcEVwHyEkycjSERXdYgT64K1/zwykeTsP5/FVwfBauY2o5+AHeu2h5M
fcaW3n5GmgO3xPPwHaVNt2oZSLKW5UVI2COEdTSy5JA02IvljRxAF5nLvQmeMCxs
vd/UfCTLOyt0pyaCR2D2tAjgFdTtNqtRxVlc8adPI+BtpBsBvMsgHcjurt2tXtRi
fIm7y8iW/5tu2+QFNE63JEGs0z3fCoUvP51Xc1UKxLBSUw+O5VTOUbnRdMEY9x+B
OCRqIs76fp3BWSErCwKIgSXSup1ZQCMP9freS9QK2wn7D76GaE8nXAZnYCZhc2HC
vJG44sYPnEjHTKu4VcZHYM+pWIjzp539OahNinsBN68y3PRbvZpBR5BX5PSRH3WS
t6ohIbT69iavp4pf35AZ
=iq/e
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
