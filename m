From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio A701
Date: Sun, 22 Dec 2013 19:14:49 +0100
Message-ID: <8761qgsqg6.fsf@free.fr>
References: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:37513 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942Ab3LVSPO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Sun, 22 Dec 2013 13:15:14 -0500
In-Reply-To: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
	(Thierry Reding's message of "Fri, 20 Dec 2013 10:46:52 +0100")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux@simtec.co.uk, Marek Vasut <marek.vasut@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Daniel Ribeiro <drwyrm@gmail.com>, Stefan Schmidt <stefan@openezx.org>, Harald Welte <laforge@openezx.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi guys,

I think this kind of patch [1] should end up in your machine files too, as it
impacts all machines not relying on devicetree.

Moreover, your defconfig should be amended, adding 
CONFIG_REGULATOR_FIXED_VOLTAGE=y.

So far these are the files I think should be checked :
   rj@beldin:~/mio_linux/kernel$ for f in $(grep -l pwm-backlight arch/arm/mach-*/*.c); do echo $f; done
arch/arm/mach-pxa/cm-x300.c
arch/arm/mach-pxa/colibri-pxa270-income.c
arch/arm/mach-pxa/ezx.c
arch/arm/mach-pxa/hx4700.c
arch/arm/mach-pxa/lpd270.c
arch/arm/mach-pxa/magician.c
arch/arm/mach-pxa/mainstone.c
arch/arm/mach-pxa/mioa701.c
arch/arm/mach-pxa/palm27x.c
arch/arm/mach-pxa/palmtc.c
arch/arm/mach-pxa/palmte2.c
arch/arm/mach-pxa/pcm990-baseboard.c
arch/arm/mach-pxa/raumfeld.c
arch/arm/mach-pxa/tavorevb.c
arch/arm/mach-pxa/viper.c
arch/arm/mach-pxa/z2.c
arch/arm/mach-pxa/zylonite.c
arch/arm/mach-s3c24xx/mach-h1940.c
arch/arm/mach-s3c24xx/mach-rx1950.c
arch/arm/mach-s3c64xx/mach-crag6410.c
arch/arm/mach-s3c64xx/mach-hmt.c
arch/arm/mach-s3c64xx/mach-smartq.c
arch/arm/mach-shmobile/board-armadillo800eva.c

Cheers.

--
Robert

[1] Thierry's patch

Thierry Reding <thierry.reding@gmail.com> writes:

> Recent changes to the pwm-backlight driver have made the power supply
> mandatory. There is code in the regulator core to deal with situations
> where no regulator is specified and provide a dummy, but that works on
> DT-based boards only.
>
> The situation can be remedied by adding a dummy regulator during board
> initialization.
>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  arch/arm/mach-pxa/mioa701.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
> index f70583fee59f..29997bde277d 100644
> --- a/arch/arm/mach-pxa/mioa701.c
> +++ b/arch/arm/mach-pxa/mioa701.c
> @@ -38,6 +38,7 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/usb/gpio_vbus.h>
>  #include <linux/reboot.h>
> +#include <linux/regulator/fixed.h>
>  #include <linux/regulator/max1586.h>
>  #include <linux/slab.h>
>  #include <linux/i2c/pxa-i2c.h>
> @@ -714,6 +715,10 @@ static struct gpio global_gpios[] = {
>  	{ GPIO56_MT9M111_nOE, GPIOF_OUT_INIT_LOW, "Camera nOE" },
>  };
>  
> +static struct regulator_consumer_supply fixed_5v0_consumers[] = {
> +	REGULATOR_SUPPLY("power", "pwm-backlight"),
> +};
> +
>  static void __init mioa701_machine_init(void)
>  {
>  	int rc;
> @@ -753,6 +758,10 @@ static void __init mioa701_machine_init(void)
>  	pxa_set_i2c_info(&i2c_pdata);
>  	pxa27x_set_i2c_power_info(NULL);
>  	pxa_set_camera_info(&mioa701_pxacamera_platform_data);
> +
> +	regulator_register_always_on(0, "fixed-5.0V", fixed_5v0_consumers,
> +				     ARRAY_SIZE(fixed_5v0_consumers),
> +				     5000000);
>  }
>  
>  static void mioa701_machine_exit(void)
