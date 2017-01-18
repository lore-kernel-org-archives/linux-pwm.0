From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/4] pwm: lpss: Do not export board infos for
 different PWM types
Date: Wed, 18 Jan 2017 12:11:09 +0100
Message-ID: <20170118111109.GO18989@ulmo.ba.sec>
References: <20170102091647.86910-1-andriy.shevchenko@linux.intel.com>
 <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2IK6idz0sKKouFF6"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33755 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbdARLLN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 06:11:13 -0500
Received: by mail-wj0-f196.google.com with SMTP id un2so60481wjb.0
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2017 03:11:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170102091647.86910-4-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--2IK6idz0sKKouFF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 11:16:46AM +0200, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> The PWM LPSS probe drivers just pass a pointer to the exported board info
> structures to pwm_lpss_probe() based on device PCI or ACPI ID. Since the
> core driver knows everything else except mapping between device ID and the
> type, just pass the type with pwm_lpss_probe() and stop exporting the boa=
rd
> info structures.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 20 ++++++++---------
>  drivers/pwm/pwm-lpss-platform.c | 10 ++++-----
>  drivers/pwm/pwm-lpss.c          | 49 ++++++++++++++++++++++-------------=
------
>  drivers/pwm/pwm-lpss.h          | 14 +++++-------
>  4 files changed, 44 insertions(+), 49 deletions(-)

Is there anything in particular that you think will need this change? It
looks to me more like churn than anything else. Moving away from the per
device struct to describe the particular instance seems to me like
removing flexibility that we might want at some point rather than any
real gain.

Thierry

--2IK6idz0sKKouFF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/TUsACgkQ3SOs138+
s6HmEQ/+PeJiEFpZuxHHjnlzasLbnRKRAI4sO8DJZbCQ8PvGTm4yL48Fe04RAjR7
itgGBuj6YuVowYpoR2uLKHRj88qvvMhG2RilrtGLaGXB1kYb3n8AyKhy07/Daxfg
0lsy09fK02rTHsso1s+KeWBPsbdeyV4h/KsW7H906ORb/dMOu3E1SoiRH1qM+cbY
A0gsbCjNLng5diXk+RSR+R6OUJOIHH3TvJH7Vs8DiWaZWuUQK7WXQyALbdb9oLBr
gqjArHTgWLpVl6sKB5MnTaxAbB74NslIHuD3bBGnNc7XJXIH0qldAnLiFroGAhWA
gFF2zY3F54vUdgblGUcjVincdVv3ui7hZ14AvLEGr+KheyC2RkmwsOmyIkEGFUzk
tN33rSMsDffoT1pTX/IjUPlzxvOib96Ta3/uAbVXYYZ3HyIh/Vi9et3FvExA5SZa
jhUM6XAn9mMXrVD0focy5S/Y/4szwdlyG3vidbQNHHkxoDq/uJpJx7KdAStQL0Xk
rK55SBL1rVjGWv5bIUawddbfQhHSylXr14Ra3c0+Xg3Dyg0v4P67MulB92t//9uF
7aRXKwfyw7Xh5GocjXA+i47970g8lsiA5o2nQZiYA2HLxe1Ooj5uXlPTtaikIpSp
SH2p12S4qAQNEeOisBz6g89icx8rWJyg68c8KQmoPgyqCWBfSSQ=
=Dh7R
-----END PGP SIGNATURE-----

--2IK6idz0sKKouFF6--
