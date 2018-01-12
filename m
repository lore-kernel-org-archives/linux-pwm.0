From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Fri, 12 Jan 2018 10:35:13 -0800
Message-ID: <20180112183512.GB102880@google.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515766983-15151-2-git-send-email-claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

On Fri, Jan 12, 2018 at 04:22:48PM +0200, Claudiu Beznea wrote:
> Remove of_pwm_simple_xlate() and of_pwm_xlate_with_flags() functions
> and add of_pwm_xlate() which is used in all cases no mather if the OF
> bindings are with PWM flags or not. This should not affect the old
> behavior since the xlate will be based on #pwm-cells property of the
> PWM controller. Based on #pwm-cells property the xlate will consider
> the flags or not. This will permit the addition of other inputs to OF
> xlate by just adding proper code at the end of of_pwm_xlate() and a new
> input to enum pwm_args_xlate_options. With this changes there will be
> no need to fill of_xlate and of_pwm_n_cells of struct pwm_chip from
> the drivers probe methods. References in drives to references to of_xlate
> and of_pwm_n_cells were removed. Drivers which used private of_xlate
> functions switched to the generic of_pwm_xlate() function which fits
> for it but with little changes in device trees (these drivers translated
> differently the "pwms" bindings; the "pwms" bindings now are generic to
> all drivers and all drivers should provide them in the format described
> in pwm documentation).
> 
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mike Dunn <mikedunn-kFrNdAxtuftBDgjK7y7TUQ@public.gmane.org>
> Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
> 
> This patch (and the next 7) could be applied independetly by this series, if
> any, but I choosed to have it here since it makes easy the PWM modes parsing.
> If you feel it could be independently of this series I could send a new version.
> 
> Also, Thierry, Mike, Brian, Shiyan, please take an extra look over pwm-pxa.c,
> pwm-cros-ec.c and pwm-clps711x.c since these were moved to use the generic
> pwms (minimum 2 pwm-cells).
> 
>  drivers/pwm/core.c             | 56 +++++++++++-------------------------------
>  drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
>  drivers/pwm/pwm-atmel-tcb.c    |  2 --
>  drivers/pwm/pwm-atmel.c        |  6 -----
>  drivers/pwm/pwm-bcm-iproc.c    |  2 --
>  drivers/pwm/pwm-bcm-kona.c     |  2 --
>  drivers/pwm/pwm-bcm2835.c      |  2 --
>  drivers/pwm/pwm-berlin.c       |  2 --
>  drivers/pwm/pwm-clps711x.c     | 11 ---------
>  drivers/pwm/pwm-cros-ec.c      | 20 ---------------

For pwm-cros-ec.c:

Nacked-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

This is a fiat change of the documented binding, which breaks the RK3399
Kevin board. That's not how we do device tree.

You can extend the binding if you want, so you can represent the period
in the device tree if you'd like (though the value won't mean anything;
it can't be changed by the kernel), but don't break existing device
trees.

>  drivers/pwm/pwm-fsl-ftm.c      |  2 --
>  drivers/pwm/pwm-hibvt.c        |  2 --
>  drivers/pwm/pwm-imx.c          |  8 ------
>  drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
>  drivers/pwm/pwm-meson.c        |  2 --
>  drivers/pwm/pwm-omap-dmtimer.c |  2 --
>  drivers/pwm/pwm-pxa.c          | 19 --------------
>  drivers/pwm/pwm-renesas-tpu.c  |  2 --
>  drivers/pwm/pwm-rockchip.c     |  5 ----
>  drivers/pwm/pwm-samsung.c      |  3 ---
>  drivers/pwm/pwm-sun4i.c        |  2 --
>  drivers/pwm/pwm-tiecap.c       |  2 --
>  drivers/pwm/pwm-tiehrpwm.c     |  2 --
>  drivers/pwm/pwm-vt8500.c       |  2 --
>  drivers/pwm/pwm-zx.c           |  2 --
>  include/linux/pwm.h            | 23 ++++++++++-------
>  26 files changed, 29 insertions(+), 156 deletions(-)
> 
...

> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 9c13694eaa24..692298693768 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -133,24 +133,6 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	state->duty_cycle = ret;
>  }
>  
> -static struct pwm_device *
> -cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
> -{
> -	struct pwm_device *pwm;
> -
> -	if (args->args[0] >= pc->npwm)
> -		return ERR_PTR(-EINVAL);
> -
> -	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
> -	if (IS_ERR(pwm))
> -		return pwm;
> -
> -	/* The EC won't let us change the period */
> -	pwm->args.period = EC_PWM_MAX_DUTY;
> -
> -	return pwm;
> -}
> -
>  static const struct pwm_ops cros_ec_pwm_ops = {
>  	.get_state	= cros_ec_pwm_get_state,
>  	.apply		= cros_ec_pwm_apply,
> @@ -207,8 +189,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>  	/* PWM chip */
>  	chip->dev = dev;
>  	chip->ops = &cros_ec_pwm_ops;
> -	chip->of_xlate = cros_ec_pwm_xlate;
> -	chip->of_pwm_n_cells = 1;
>  	chip->base = -1;
>  	ret = cros_ec_num_pwms(ec);
>  	if (ret < 0) {

...

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
