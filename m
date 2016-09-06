From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [pwm:for-4.9/drivers 2/9] drivers/pwm/pwm-berlin.c:245:35:
 error: 'struct berlin_pwm_chip' has no member named 'chips'
Date: Tue, 6 Sep 2016 11:08:42 +0200
Message-ID: <20160906090842.GB15644@ulmo.ba.sec>
References: <201609051807.8q1Dh6WZ%fengguang.wu@intel.com>
 <20160906133531.367129f0@xhacker>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35444 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbcIFJIp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 05:08:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id a6so6145803wmc.2
        for <linux-pwm@vger.kernel.org>; Tue, 06 Sep 2016 02:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160906133531.367129f0@xhacker>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-pwm@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2016 at 01:35:31PM +0800, Jisheng Zhang wrote:
>=20
>=20
> On Mon, 5 Sep 2016 18:37:13 +0800 kbuild test robot  wrote:
>=20
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git for-4.9/drivers
> > head:   e63ed23775362a6e1a867dc2f75ebbf4e3a8d4d2
> > commit: fd47f104003c629d0ec6be4c2ead90191c184a23 [2/9] pwm: berlin: Add=
 suspend/resume support
> > config: arm64-allyesconfig (attached as .config)
> > compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests=
=2Egit/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout fd47f104003c629d0ec6be4c2ead90191c184a23
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=3Darm64=20
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    drivers/pwm/pwm-berlin.c: In function 'berlin_pwm_suspend':
> > >> drivers/pwm/pwm-berlin.c:245:35: error: 'struct berlin_pwm_chip' has=
 no member named 'chips' =20
> >       channel =3D pwm_get_chip_data(&pwm->chips.pwms[i]);
> >                                       ^
>=20
>=20
> Thanks for information. Below patch can fix it.
>=20
> Hi Thierry,
>=20
> a separate fix or amend the commit, which do you prefer?

I've squashed the below change into the original patch.

Thanks,
Thierry

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzoeZAAoJEN0jrNd/PrOhQtAP/3aJDX+gpFsNTDcP4kPD51DQ
dYk/RbfdkRCD7gLzVOPmcVk/RhVabL1YNQiX8EVRvNv/UT4LyopK7ljjCA3kzlX8
oIQrr278X29ADely+/A4D3j6ljQ4puypE1xNZJm+Rh6RVserFP/FGWLNqF4+t67M
mZM9bFqS0ZCvRrxnyKGcMbeweMATkM2vs0W7t+0LfC106isvYAet05OqOCWIOIVg
mZ8s8bxhcIpBSu9xHZdilUVUFPd8/6Xl2nRapQWVdoQUS6t31I+hMn1+HL+Qy6vC
znkMTHdihKK1k+scq3uzhfh3dadBGgB3+sXnI1jfhJ8XyIhMmWSsq0SCPR7mfLC8
H/qiVHRzB1TomufuACstg3yH5yczqBP9X7yjcWN/kvRxc0mEkq1hljlOPWHBES/5
+FNQbYUYeJX8bfcGGqSpchYVlIXb6AkxcevPuJx6RsVTXwNpuNqZLpC8zS6DnJ5f
QQ8A9ETxxps0dLDb6Y8waxup4tjD/KAKg/VxYndIpyHEPTecQK+kl9xOqH3L9Q+M
9nIr0nUeSraF6Uz9dM3c5WqSolc+KjbAPaIPI4mSTLKGooOhdMjx6Okw0qXTu9XL
4l7qg/uDxrT2J8zt2q/mZH74+UPhpjzAX/g8GNDYIJuiBH9Md/7/sm/mBXBKz1PM
hhYV4J3q7l+Pd3iP2pnY
=M3uh
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
