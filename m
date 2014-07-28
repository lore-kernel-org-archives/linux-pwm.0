From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/2] pwm: lpss: split driver to core and probe drivers
Date: Mon, 28 Jul 2014 17:29:56 +0200
Message-ID: <20140728152954.GA10126@ulmo.nvidia.com>
References: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54966 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaG1PaB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jul 2014 11:30:01 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so9857170pdb.41
        for <linux-pwm@vger.kernel.org>; Mon, 28 Jul 2014 08:30:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406559792-30652-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 06:03:10PM +0300, Andy Shevchenko wrote:
> This small series makes the architecture of pwm-lpss driver cleaner.
>=20
> Since v2:
> - fix one more typo in Kconfig (tested with one line removed in my config=
 now)
>=20
> Since v1:
> - hide struct definition in the core part
> - rename pwm-lpss-plat to pwm-lpss-platform
> - fix Kconfig dependencies and other typos
> - add Mika's Reviewed-by tag
> - fix spelling in the commit messages
>=20
> Andy Shevchenko (2):
>   pwm: lpss: properly split driver to parts
>   pwm: lpss: pci: move to use pcim_enable_device()
>=20
>  drivers/pwm/Kconfig             |  21 ++++++-
>  drivers/pwm/Makefile            |   2 +
>  drivers/pwm/pwm-lpss-pci.c      |  68 ++++++++++++++++++++++
>  drivers/pwm/pwm-lpss-platform.c |  61 ++++++++++++++++++++
>  drivers/pwm/pwm-lpss.c          | 125 ++--------------------------------=
------
>  drivers/pwm/pwm-lpss.h          |  29 ++++++++++
>  6 files changed, 186 insertions(+), 120 deletions(-)
>  create mode 100644 drivers/pwm/pwm-lpss-pci.c
>  create mode 100644 drivers/pwm/pwm-lpss-platform.c
>  create mode 100644 drivers/pwm/pwm-lpss.h

I'd like an Acked-by from Alan on this since he had strong objections
when I requested exactly this a while back.

Thierry

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1mxyAAoJEN0jrNd/PrOhEuUP/2jhOIGKIP906jofBXLVnmcR
DsynZmTlztKudXGeQ09DGLpmLZe33OBAB6c5bO+AIQ2KKrSVRmxwaETP6DYdCLy+
oFkadP2oK3pSjLlIn2uHQJWKzq58yYDlS5luQLSYYHj86mUnXpwqh3CiD+2ZnaMD
0shwhxh18CmgPq2NtViuG3DhihN1r00DLMe0+8CZz5eYRXaiSFD9mOAe/p1HVwYS
uVEl619GcJCfmKeBJt8ZOVm2dp5K17uFRmy7qlKhZjjollq3UFcZ2iTrO4eW0Vxi
1P9zUdO0k1dYV2Ahwo8oBJRkD3VvftrAMcNSSGdPt7f1Q+4xM01HG09i0RI03FPv
MmB/pMlvp6jmFVBMfVoOjBlpHQwVJ19q8k7KhV+xFDdOWcIiwY87Bg2OB1yZod0F
N3O1g67gebTsUTOmddbpvMze/GUJx+ND9xLG2QFJiO1unsah6sFnLlruj+5YDgLp
A39bK9Ba7BkGF/wFa+j1EDUGMQZFvHcWKQ6rZ0GifFYXDa5X3uOdGeWpbK7NrTUY
QgeEmJt02R+neF7SMh2K1pCPBfkSnF2OgbjlrWGweGBAbdJMk5J/4ZuwKKB+0E7W
9KBSqVTCNFpfsR2VHXep7X4kuh8gWVH4+cvzJiwEYdo9Eg+JKYcVEwTe08yWxwxB
jKqXE9gx8JIV9C6hkZC5
=KtGf
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
