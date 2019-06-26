Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfFZJo1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 05:44:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1885284wrw.13
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 02:44:25 -0700 (PDT)
Date: Wed, 26 Jun 2019 11:44:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190626094422.GB22424@ulmo>
References: <201906260804.9UofywY8%lkp@intel.com>
 <1561510359.10069.3@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <1561510359.10069.3@crapouillou.net>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [pwm:for-next 13/37] ERROR: "jz4740_timer_base"
 [drivers/pwm/pwm-jz4740.ko] undefined!
To: Paul Cercueil <paul@crapouillou.net>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-pwm@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 02:52:39AM +0200, Paul Cercueil wrote:
>=20
>=20
> Le mer. 26 juin 2019 =C3=A0 2:47, kbuild test robot <lkp@intel.com> a =C3=
=A9crit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git
> > for-next
> > head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
> > commit: e9bd35ff751fac8755fe3480bec1f470383f4522 [13/37] pwm: jz4740:
> > Drop dependency on MACH_INGENIC
> > config: mips-allmodconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 7.4.0
> > reproduce:
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout e9bd35ff751fac8755fe3480bec1f470383f4522
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >  ERROR: "jz4740_timer_base" [drivers/pwm/pwm-jz4740.ko] undefined!
>=20
> Looks like this patch was a bit premature...
> I think you can drop it...

Hmm, I didn't catch this during my build tests because I hadn't updated
my build configurations to leave out the MACH_INGENIC dependency, so I
was still building that and hence getting the symbol.

I've dropped this patch for now. Let's look at that again once you're
done untangling this in arch/mips.

Thanks,
Thierry

>=20
> > ---
> > 0-DAY kernel test infrastructure                Open Source Technology
> > Center
> > https://lists.01.org/pipermail/kbuild-all                   Intel
> > Corporation
>=20
>=20

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0TPnYACgkQ3SOs138+
s6Hnsg//U24yrWvZVoBHNBP1Yf+RnAW5HxL0ir9CUHqOk1wTa2sHUr6Ga9EnVvZ7
TQjUfE8m0Miv2wA9bPlSgapF9LkkEckJPjUhEZ8ObcDA2tdUl6eORIXGB6VI3uhC
s+VfwI2a95jlfJZa4TAjAcOJA6gW9TcWtmPbmZWsRYsbqFpBXD69XKQa/8T6uT24
DXjbRw+x8p2mAfUKaaAx4Yn3Sk8uyYqHTmjSUDuR0lg3HdX+iEAkLBmrbQB8LmOh
m9FkDybr1LLatdruYh+8XaHzA+BSpChpAJR71jLb5wbMBXANROseEVvwOfJfVikz
VFNDb+X3KHh9U3LQTOoyZOpRfVLdfFaV2nE6pQsuiJC+/Igc50HFLtxa3EMy1o4Q
qIOfcTYx5bMP3UwPxcINgrutpKtYIFRr9B+4qrRrGjhaQdymYBrW7ocSmv8d6KEE
EsQMtmim6apXb8Hbr77oRa9H1o2PnjcGHVtWIRwxU2AwZiXvAkuF9b5Gxy8bxHED
0r5AiRd4Lvvf9MpxpTlJECKFUNA/jLIgkCO/dwlTv8pgspt4Uq2POidk8DZu0al3
B8/IoMK5OoJvMV1gQGDo1qFN+IijWBDcJetX4/HMD0wK3OcectB6fvBHkaTdD2gc
rc0goB2AB9MNyqSPHYIJs1H/p0GdXfBJpJGshiNHKUI6L5/zKV8=
=9sTv
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
