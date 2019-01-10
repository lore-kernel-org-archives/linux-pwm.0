Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32865 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfAJUEI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Jan 2019 15:04:08 -0500
Date: Thu, 10 Jan 2019 21:04:02 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Message-ID: <20190110200402.rusqd4edc6h7coel@pengutronix.de>
References: <201901110232.L51oPCXW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201901110232.L51oPCXW%fengguang.wu@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [pwm:for-next 7/8] drivers/pwm/pwm-imx27.c:291:25: error:
 'imx_pwm_dt_ids' undeclared here (not in a function); did you mean
 'pwm_imx27_dt_ids'?
To: kbuild test robot <lkp@intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: kbuild-all@01.org, linux-pwm@vger.kernel.org

Hello,

On Fri, Jan 11, 2019 at 02:39:31AM +0800, kbuild test robot wrote:
> First bad commit (maybe !=3D root cause):
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/li=
nux-pwm.git for-next
> head:   41b03ad2e2af3217154c1e6042011073105f28e7
> commit: 5a309d3800195cd6401c3f7d620c8c7207199237 [7/8] pwm: imx: Split in=
to two drivers
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 5a309d3800195cd6401c3f7d620c8c7207199237
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm=20
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>    In file included from drivers/pwm/pwm-imx27.c:15:0:
> >> drivers/pwm/pwm-imx27.c:291:25: error: 'imx_pwm_dt_ids' undeclared her=
e (not in a function); did you mean 'pwm_imx27_dt_ids'?

Yes, that's what I meant. This problem doesn't show up when compiling
this driver as a built-in. :-|

@Thierry: Would you care squash this diff into
5a309d3800195cd6401c3f7d620c8c7207199237, or do you want to keep your
tree fast-forwardable? In the latter case I can submit a patch including
description.

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 4dc2d62c0e1c..806130654211 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -286,7 +286,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] =3D=
 {
 	{ .compatible =3D "fsl,imx27-pwm", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
+MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
=20
 static int pwm_imx27_probe(struct platform_device *pdev)
 {

Thanks and sorry for not catching this problem myself.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
