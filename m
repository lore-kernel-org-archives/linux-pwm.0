From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] pwm: core: use seq_puts() instead of seq_printf()
Date: Fri, 20 Dec 2013 10:58:08 +0100
Message-ID: <20131220095807.GF27787@ulmo.nvidia.com>
References: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab3LTJ7l (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 04:59:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id u15so1101938bkz.19
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 01:59:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <002101cefc73$2d22ff70$8768fe50$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 01:31:24PM +0900, Jingoo Han wrote:
> For a constant format without additional arguments, use seq_puts()
> instead of seq_printf(). Also, the following checkpatch warning is
> fixed.
>=20
>   WARNING: Prefer seq_puts to seq_printf
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All three patches applied, thanks!

Thierry

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStBSvAAoJEN0jrNd/PrOhrc8P/28cFjsutzSTHpK57dB64wnH
JbNzIULzntttyRSvINCggTOkpuLfsnKGKjQvco+JSwLdyOC+tSNHV7AJ7/aDmi9C
we0Smc87HJsyq0hDtm/EFD2WzuOofHeJu3amt9XY4hmF9sYq5yg0XnD+dbC0sfmx
YBnu48yfL55bgqd3hV6ROgfd1gqouCVvDTyJnZpsjy8Pj/3jrfP/271jplIKKQ5T
sL2qs6ShotaWEyeiwBoY+NDGl5yFed0mgTDFsdOf48yvUHWR1LGRaTU5ljHgR3Vz
8FTqt6H92TwRNqxiRd1iS9XS+6f89Q03y+XArtuUvb5ZJvaQLwF+69Y+Ek0qJd2Q
/HpS4uB0DqsD3zBk8lBoNcnK6yS4WUdRBlkfhmHflKKOpBCkzWxoQffOtwkosFWg
ejYoS0YsWX3HphtiNEMRz5ke1qNH4ojtsLKm/r+Qt35WrA6FgbTQB0A9IXA6KM+L
K/fegU46tLHsb7C8Eba4BXCjXVMIhqIRU5wC5KuI/MkV2ISoHrd+PLsLiInD8BWs
PJTZvBTFpMadpc4QqCuJHOmE0GiZQnOrjavBXjnCJm4jy4ImXcVOrgHCJgGKUHJi
s+4xvMBwEQ6sQ4f7Xav1y9JLKuf5cwzMkao+/OFf3CLf5yZfN/kPCEIhCQB/LlYL
6X91k4iWxUDf5K5dIuv1
=rwXT
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
