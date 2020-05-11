From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 08/16] pwm: add support for sl28cpld PWM controller
Date: Mon, 11 May 2020 15:45:29 -0500
Message-ID: <20200511204529.GA3518@bogus>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-9-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-9-michael-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc
List-Id: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:35PM +0200, Michael Walle wrote:
> This adds support for the PWM controller of the sl28cpld board
> management controller. This is part of a multi-function device driver.
> 
> Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-sl28cpld.c | 203 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sl28cpld.c


> +static const struct of_device_id sl28cpld_pwm_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
> +
> +static const struct platform_device_id sl28cpld_pwm_id_table[] = {
> +	{"sl28cpld-gpio"},

copy-n-paste error?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_pwm_id_table);
> +
> +static struct platform_driver sl28cpld_pwm_driver = {
> +	.probe = sl28cpld_pwm_probe,
> +	.remove	= sl28cpld_pwm_remove,
> +	.id_table = sl28cpld_pwm_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = sl28cpld_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_pwm_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
> +MODULE_AUTHOR("Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
> 
