From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/2] pwm: lpss: split driver to core and probe drivers
Date: Wed, 20 Aug 2014 12:12:49 +0200
Message-ID: <20140820101248.GH15414@ulmo>
References: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:59161 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbaHTKMx (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Aug 2014 06:12:53 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so7604552wes.28
        for <linux-pwm@vger.kernel.org>; Wed, 20 Aug 2014 03:12:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408465056-8605-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 07:17:34PM +0300, Andy Shevchenko wrote:
> This small series makes the architecture of pwm-lpss driver cleaner.
>=20
> Since v3:
> - rebased on top of recent linux-next
> - rebased on top of Alan's patch for Braswell
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
>  drivers/pwm/pwm-lpss-pci.c      |  65 +++++++++++++++++++
>  drivers/pwm/pwm-lpss-platform.c |  69 ++++++++++++++++++++
>  drivers/pwm/pwm-lpss.c          | 136 +++-------------------------------=
------
>  drivers/pwm/pwm-lpss.h          |  32 ++++++++++
>  6 files changed, 198 insertions(+), 127 deletions(-)
>  create mode 100644 drivers/pwm/pwm-lpss-pci.c
>  create mode 100644 drivers/pwm/pwm-lpss-platform.c
>  create mode 100644 drivers/pwm/pwm-lpss.h

Yea or nay, Alan?

Thierry

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9HSgAAoJEN0jrNd/PrOhprQP/jF8njH3TtpwfL1GZUJuHZ1F
QW+ZeG4HHKGaxxpfkwj1eVvyHH+9+P8mBjNlyvJbTi5NwgdcyuI+INFIHP0KkQ1D
T1cFzfjGQ5+Zzb2k96EU0ePIxBgskuMovrvzrIpq2/Z/5KKYfZNiLaFeMJ1Si17p
kVw3BTmmHG/KwaI7HAD1KBqjlRADhRzJpi67AoL5ZQPGTV3V+XXNpOtJWxYuTK8N
3GVvbMv130bxCynF2TFS3P2mAf+RszZeCNeM5qd43MInraURBgzNBv5ExkHR7s2c
Pu6uaJmqy2L90Vcz+NmmOh9KTqbQuAZUhknVJ/1Y8PT4sC1SUeXPY3SH8urbvH86
xBrPFcu0Vv5KO6+ZObsKQRvNZ/05wHmqR540fs92YG3DPKTBHShiAnE9239GcAVz
h0SJJGIglnY6xmn3cl8LrDqGCSvGfVdHKOKar89YJeWOaLof1x7tyFRaMJvnd2v8
io8Eu8MCGyoMH1Vieo5pIySvx1GJYKF7Qbfmtmy3qi2P+sehDRGScEAXcr1O6+qz
VR1fzKvym4L4E1r+/X3x599AN6NuypqnZxly/dmoEsSuz7Ko5TUX+WrEu8FoopW8
jofnKC60+F5vUD4mM8H0avo9Z3rUco3H7fvquKWwSTYWDEJnNvbI59opaUd8otup
5k3gXByfXaKOUoU8pejl
=SS5V
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--
