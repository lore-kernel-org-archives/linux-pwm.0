From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: add ZTE ZX PWM device driver
Date: Tue, 25 Jul 2017 13:53:43 +0200
Message-ID: <20170725115343.GD22355@ulmo>
References: <1498704874-14599-1-git-send-email-shawnguo@kernel.org>
 <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37970 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdGYLxr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jul 2017 07:53:47 -0400
Content-Disposition: inline
In-Reply-To: <1498704874-14599-3-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 10:54:34AM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
>=20
> It adds PWM device driver for ZTE ZX family SoCs.  The PWM controller
> supports 4 devices with polarity configuration.
>=20
> The driver has been tested with pwm-regulator support to scale core
> voltage via cpufreq.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/Kconfig  |   9 ++
>  drivers/pwm/Makefile |   1 +
>  drivers/pwm/pwm-zx.c | 244 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 254 insertions(+)
>  create mode 100644 drivers/pwm/pwm-zx.c

Hi Shawn,

This is close to perfect. Two minor things, see below.

> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 313c10789ca2..e98175331a69 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -500,4 +500,13 @@ config PWM_VT8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-vt8500.
> =20
> +config PWM_ZX
> +	tristate "ZTE ZX PWM support"
> +	depends on ARCH_ZX
> +	help
> +	  Generic PWM framework driver for ZTE ZX family SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-zx.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 93da1f79a3b8..75ab74094d7b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -49,3 +49,4 @@ obj-$(CONFIG_PWM_TIPWMSS)	+=3D pwm-tipwmss.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> +obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
> new file mode 100644
> index 000000000000..5c81c2ddc0a9
> --- /dev/null
> +++ b/drivers/pwm/pwm-zx.c
> @@ -0,0 +1,244 @@
> +/*
> + * Copyright (C) 2017 Sanechips Technology Co., Ltd.
> + * Copyright 2017 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +#define ZX_PWM_MODE		0x0
> +#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
> +#define ZX_PWM_CLKDIV(x)	(((x) << 8) & ZX_PWM_CLKDIV_MASK)
> +#define ZX_PWM_POLAR		BIT(1)
> +#define ZX_PWM_EN		BIT(0)
> +#define ZX_PWM_PERIOD		0x4
> +#define ZX_PWM_DUTY		0x8
> +
> +#define ZX_PWM_CLKDIV_MAX	1023
> +#define ZX_PWM_PERIOD_MAX	65535
> +
> +struct zx_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *pclk;
> +	struct clk *wclk;
> +	void __iomem *base;
> +};
> +
> +#define to_zx_pwm_chip(_chip) container_of(_chip, struct zx_pwm_chip, ch=
ip)

Please use a static inline function for this. That way diagnostic
messages from the compiler make more sense.

[...]
> +static const struct pwm_ops zx_pwm_ops =3D {
> +	.config =3D zx_pwm_config,
> +	.enable =3D zx_pwm_enable,
> +	.disable =3D zx_pwm_disable,
> +	.set_polarity =3D zx_pwm_set_polarity,
> +	.owner =3D THIS_MODULE,
> +};

Please convert this to implement the atomic PWM callbacks (->apply() and
->get_state()).

Thanks,
Thierry

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAll3MUcACgkQ3SOs138+
s6HdvQ/+N5z1Ro7VV+Ei959pR44kJHPTyDS6ejEllHmIrL6948m49MtmQJ/ADsau
txQiW+gKn2HMqwPTP50L4lEtxTkLYqaMmuwqHGoHt3+tb6KS3DGwvgPVTBMLtPpU
Ddsv0En/HrNabpk1Uq+5UfuMVkuipKMxTJ/uuHqRaqf/6dmxYaLXH1CQN6UqQMMW
HzUnL5/L8DHKtLG6HXB7Kv0t3WbU4rYQfpWSTSQNcy+990Tt4L2y7pPZM7iomTrY
Lb83ElagFVX2rLbxbgt2XoTCKGGA6RT2w63sktxeJM6+MmHaFz2y1a0CuDoY8ou+
nD3bK/tsHRvI21aXFcUFCBFuMUjqNUXYVLvNyLvGwgTHdD+uCNTj+naliuW7M8yT
vCVY+rmldiYnStu4O7DehR1m/Nk/UgskbcmTaChWXIKnsmR4oqxaxK+de5+SsJP4
brZVyyX8rCd9IQf9uAK6CzLWbmhtOBnBrJ4h3O6hQ5Qi1lkigPSVuk6qh08hqlk3
Gwe5a3x1rXnEQFtws0B49O89hW4rS+EQP9JLdvaM+/UorWZBuyXYO7ZnIA3X8/Iz
43fCvvpKh+pIuAMEmfhRYc+j6Rfgb2X+tVOC98xLgPVpSbtHomaCNkSc71cDqHLr
8dPOXwWMIvbCBqgHI8n/coi2ClLIlV5nRsnvK25AzQVvqmkXIjk=
=faIL
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
