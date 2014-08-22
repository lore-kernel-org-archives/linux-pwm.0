From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: Kconfig: Select REGMAP_MMIO for PWM_FSL_FTM
Date: Fri, 22 Aug 2014 10:19:09 +0200
Message-ID: <20140822081908.GA24156@ulmo>
References: <1408665025-23204-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:41329 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbaHVITM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Aug 2014 04:19:12 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so10201000wes.23
        for <linux-pwm@vger.kernel.org>; Fri, 22 Aug 2014 01:19:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408665025-23204-1-git-send-email-festevam@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Li.Xiubo@freescale.com, linux-pwm@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 08:50:25PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit 42fa98a9c3609c1 ("pwm: fsl-ftm: Convert to direct regmap API usage=
")
> introduced the following error when REGMAP_MMIO=3Dn:
>=20
> drivers/built-in.o: In function `fsl_pwm_probe':
> >> pwm-fsl-ftm.c:(.text+0xd7d7): undefined reference to `devm_regmap_init=
_mmio_clk'
>=20
> Select select REGMAP_MMIO in order to fix this error.
>=20
> Reported-by: kbuild test robot <fengguang.wu@intel.com>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Change since v1:
> - Added Reported-by tag
>=20
>  drivers/pwm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9vz8AAoJEN0jrNd/PrOh/FsP+gLm7zKXjTxHqEjHBBcHf5jS
kKnbS1c2ujVMia7TAqcLCrc8cD7Ip8F9as85S/J8fSxPLSVRZxc5Tw5RlUXjwVm/
tSNlwE5LQnwi8na/Rp66czZ7rNW3zpbSios68CA4OA9gkRXLpCRyhLHrSo2ygWHf
ueVXaJRouwpDFmgSRwV30SedY2g54S5j9wT7oRLZK3TpQa0xJLWRqqNgKkb9RgfQ
DExY4EgzMwkbAdQhTpQqoqZR6rrWyohRd0dBe6h+9eKf7Cylk5c6H6hgniYzB2+f
MRdLLwI2bK9jSfjmbORDoD0R9LJF6hspltTgFVLoJdznLQRcKbgcB3+u2nWBdAaO
BOpfzyI0FO4dWQJ84rMlHztLkwWH55KbjMwero3hYgSMUIvOyPysUqvIZ/b11vnc
yLy7FFLcuouLTr7mcqMSiQleZoc6+HMeT9Fa8ydblntPYZQWIP7jyBA4/zEhHkSH
kwvXNVv+A3xdlCxq+NcXhOGuK6Z6BaSON3dLiu1C1cmlI1VwQG50yDUf4/Qwk2uG
340Oo+mLM12cCg7dFL4EB4qOeiGMWkwZgBLqcFW9snFyLsG17dvwDrk9b31EpB0d
DKEeBUKu/4fFgnY/kYloqiKEMA1AmR9HIWy7YbPTwLKF2TeGr7e2cm926xzxu+nF
6wdADj6FhghaxK3Aatb8
=wPmo
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
