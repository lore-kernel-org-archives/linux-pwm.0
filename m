Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:36332 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFZAwp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 20:52:45 -0400
Date: Wed, 26 Jun 2019 02:52:39 +0200
From: Paul Cercueil <paul@crapouillou.net>
Message-Id: <1561510359.10069.3@crapouillou.net>
In-Reply-To: <201906260804.9UofywY8%lkp@intel.com>
References: <201906260804.9UofywY8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [pwm:for-next 13/37] ERROR: "jz4740_timer_base"
 [drivers/pwm/pwm-jz4740.ko] undefined!
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>



Le mer. 26 juin 2019 =E0 2:47, kbuild test robot <lkp@intel.com> a=20
=E9crit :
> tree:  =20
> https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.=
git=20
> for-next
> head:   cb8338e4fe3a8278cee91f666d2155a0ce1dd82f
> commit: e9bd35ff751fac8755fe3480bec1f470383f4522 [13/37] pwm: jz4740:=20
> Drop dependency on MACH_INGENIC
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget=20
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross=20
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e9bd35ff751fac8755fe3480bec1f470383f4522
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>  ERROR: "jz4740_timer_base" [drivers/pwm/pwm-jz4740.ko] undefined!

Looks like this patch was a bit premature...
I think you can drop it...

> ---
> 0-DAY kernel test infrastructure                Open Source=20
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel=20
> Corporation

=
