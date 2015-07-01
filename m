From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [v3 1/7] gpiolib: Add support for removing registered consumer
 lookup table
Date: Wed, 1 Jul 2015 08:46:01 +0100
Message-ID: <20150701074601.GE3210@x1>
References: <1435309330-50725-1-git-send-email-shobhit.kumar@intel.com>
 <1435309330-50725-2-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38258 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695AbbGAHqG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Jul 2015 03:46:06 -0400
Received: by wibdq8 with SMTP id dq8so37004307wib.1
        for <linux-pwm@vger.kernel.org>; Wed, 01 Jul 2015 00:46:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435309330-50725-2-git-send-email-shobhit.kumar@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>
Cc: linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Paul Bolle <pebolle@tiscali.nl>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, varkabhadram@gmail.com

On Fri, 26 Jun 2015, Shobhit Kumar wrote:

> In case we unload and load a driver module again that is registering =
a
> lookup table, without this it will result in multiple entries. Provid=
e
> an option to remove the lookup table on driver unload
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>
> ---
> v2: Ccing maintainers
> v3: Correct the subject line (Lee jones)

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/gpio/gpiolib.c       | 13 +++++++++++++
>  include/linux/gpio/machine.h |  1 +
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 957ede5..9d3ea4e 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1675,6 +1675,19 @@ void gpiod_add_lookup_table(struct gpiod_looku=
p_table *table)
>  	mutex_unlock(&gpio_lookup_lock);
>  }
> =20
> +/**
> + * gpiod_remove_lookup_table() - unregister GPIO device consumers
> + * @table: table of consumers to unregister
> + */
> +void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)
> +{
> +	mutex_lock(&gpio_lookup_lock);
> +
> +	list_del(&table->list);
> +
> +	mutex_unlock(&gpio_lookup_lock);
> +}
> +
>  static struct gpio_desc *of_find_gpio(struct device *dev, const char=
 *con_id,
>  				      unsigned int idx,
>  				      enum gpio_lookup_flags *flags)
> diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machin=
e.h
> index e270614..c0d712d 100644
> --- a/include/linux/gpio/machine.h
> +++ b/include/linux/gpio/machine.h
> @@ -57,5 +57,6 @@ struct gpiod_lookup_table {
>  }
> =20
>  void gpiod_add_lookup_table(struct gpiod_lookup_table *table);
> +void gpiod_remove_lookup_table(struct gpiod_lookup_table *table);
> =20
>  #endif /* __LINUX_GPIO_MACHINE_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
