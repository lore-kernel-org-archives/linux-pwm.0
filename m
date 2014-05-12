From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH] pwm_lpss: Add support for PCI devices
Date: Mon, 12 May 2014 16:18:16 -0700
Message-ID: <20140512231816.GA65896@dvhart-mac01.jf.intel.com>
References: <1397311131-13371-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51894 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbaELXR6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 12 May 2014 19:17:58 -0400
Content-Disposition: inline
In-Reply-To: <1397311131-13371-1-git-send-email-chiau.ee.chew@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Chew Chiau Ee <chiau.ee.chew@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 12, 2014 at 09:58:51PM +0800, Chew Chiau Ee wrote:
> From: Alan Cox <alan@linux.intel.com>
>=20
> Not all systems enumerate the PWM devices via ACPI. They can also be =
exposed
> via the PCI interface.
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
> ---
>  drivers/pwm/pwm-lpss.c |  160 ++++++++++++++++++++++++++++++++++++++=
---------
>  1 files changed, 129 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 449e372..6f79bf8 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -6,6 +6,7 @@
>   * Author: Chew Kean Ho <kean.ho.chew@intel.com>
>   * Author: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
>   * Author: Chew Chiau Ee <chiau.ee.chew@intel.com>
> + * Author: Alan Cox <alan@linux.intel.com>
>   *
>   * This program is free software; you can redistribute it and/or mod=
ify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -19,6 +20,9 @@
>  #include <linux/module.h>
>  #include <linux/pwm.h>
>  #include <linux/platform_device.h>
> +#include <linux/pci.h>
> +
> +static int pci_drv, plat_drv;	/* So we know which drivers registered=
 */
> =20
>  #define PWM				0x00000000
>  #define PWM_ENABLE			BIT(31)
> @@ -34,6 +38,15 @@ struct pwm_lpss_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	struct clk *clk;
> +	unsigned long clk_rate;
> +};
> +
> +struct pwm_lpss_boardinfo {
> +	unsigned long clk_rate;
> +};
> +
> +static const struct pwm_lpss_boardinfo byt_info =3D {
> +	25000000
>  };
> =20
>  static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
> @@ -55,7 +68,7 @@ static int pwm_lpss_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	/* The equation is: base_unit =3D ((freq / c) * 65536) + correction=
 */
>  	base_unit =3D freq * 65536;
> =20
> -	c =3D clk_get_rate(lpwm->clk);
> +	c =3D lpwm->clk_rate;
>  	if (!c)
>  		return -EINVAL;
> =20
> @@ -113,52 +126,47 @@ static const struct pwm_ops pwm_lpss_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> -static const struct acpi_device_id pwm_lpss_acpi_match[] =3D {
> -	{ "80860F09", 0 },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(acpi, pwm_lpss_acpi_match);
> -
> -static int pwm_lpss_probe(struct platform_device *pdev)
> +static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
> +			struct resource *r, struct pwm_lpss_boardinfo *info)

Has this landed anywhere? I didn't see it in mainline or next, am I loo=
king in
the wrong place? If it's just still pending, I ran into one issue integ=
rating it
with 3.14.2:

  CC [M]  drivers/pwm/pwm-lpss.o
  drivers/pwm/pwm-lpss.c: In function =E2=80=98pwm_lpss_probe_pci=E2=80=
=99:
  drivers/pwm/pwm-lpss.c:192:2: warning: passing argument 3 of =E2=80=98=
pwm_lpss_probe=E2=80=99
  discards =E2=80=98const=E2=80=99 qualifier from pointer target type [=
enabled by default]
  drivers/pwm/pwm-lpss.c:130:30: note: expected =E2=80=98struct pwm_lps=
s_boardinfo *=E2=80=99
  but argument is of type =E2=80=98const struct pwm_lpss_boardinfo *=E2=
=80=99

Can we make the third argument to pwm_lpss_probe a const? The following=
 is
working for me:

 static struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev,
                                             struct resource *r,
                                             const struct pwm_lpss_boar=
dinfo *info)

Thanks,

--
Darren Hart			Open Source Technology Center
darren.hart@intel.com		Intel Corporation
