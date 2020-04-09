From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] pwm: Add DesignWare PWM Controller Driver
Date: Thu, 09 Apr 2020 10:09:27 +0300
Message-ID: <87k12pgmoo.fsf@kernel.org>
References: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33694 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgDIHJf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 03:09:35 -0400
Received: by mail-lf1-f65.google.com with SMTP id h6so7152509lfc.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Apr 2020 00:09:34 -0700 (PDT)
In-Reply-To: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Jarkko,

Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:

> Introduce driver for Synopsys DesignWare PWM Controller used on Intel
> Elkhart Lake.
>
> Initial implementation is done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks for sending this. FWIW:

Signed-off-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl6OyicACgkQzL64meEa
mQbpjg//evPIzO34GFt9Fosbe23C3xoa6XP4xIwIKOAeoDnTJsgEA5fDjjlysbP0
g85gtb2CklkiEIbXtbT5cDIkCwGE6otxg9fudUMfjEfDxRRuYn94YdycYe5fMPkk
t0I45tehq7McnJTtDV7XfuOrzXlKonphLoobxoopbQ/DwZi461g5Gu4rRLOpwzJG
AKesWhXSzZ6NzXpQwVBH7Tf+dDpCv0HFkB0E+R2bsQdrDPbE5Qk+ClPSCOcK/cnp
qFfv1cgo7GVW0rrN6kg0VehUmBEN8d5Hd/NZ/O+WYx9JzApkab+oicaIxYSxN4Ij
yp4juc/xsiixktj5qLzqLtSmlfGdjnQ4S0E0exPZvSGL0DavmhHLwZiD2/kO/1kB
Me7GMPpo1rRAYcCRiHsULJIY7lv5bdJqRe6v7UhWK4aTK3aOZH/bZjbsDzHe4nfk
tii30QnNOG+K9jz61XcegE4wnm1v0qVw65cBiovn8ciUJOS8dkK2FQyDqpYgiDrD
QPYlPrLG8AcrxveOF21CNOye3s/fle61lywe9OMzdGiTmrE1uMpKvocHbsI8y9Yb
P4PXmtdrHjqeqdlfijZnf/PNVsGpE7Vqkg0hHkxUycxpkM+wcUfBLBK8nNQD0hWE
6FGkyx07/EUgSSjplegkWCITdtpfmDBvtahoaZf0nRXgL1dyZE8=
=CKGr
-----END PGP SIGNATURE-----
--=-=-=--
