From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Mon, 15 Jan 2018 14:43:58 +0200
Message-ID: <47978236-5cf2-c190-f25d-536735c52c9c@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Mike Dunn <mikedunn@newsguy.com>, Alexander Shiyan <shc_work@mail.ru>, corbet@lwn.net, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, haojian.zhuang@gmail.com, linux-amlogic@lists.infradead.org, robert.jarzmik@free.fr, daniel@zonque.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 15.01.2018 10:41, Claudiu Beznea wrote:
> Hi Boris,
s/Boris/Brian

> 
> Thanks for your review. See below my answers.
> 
> On 12.01.2018 20:35, Brian Norris wrote:
>> Hi,
>>
>> On Fri, Jan 12, 2018 at 04:22:48PM +0200, Claudiu Beznea wrote:
>>> Remove of_pwm_simple_xlate() and of_pwm_xlate_with_flags() functions
>>> and add of_pwm_xlate() which is used in all cases no mather if the OF
>>> bindings are with PWM flags or not. This should not affect the old
>>> behavior since the xlate will be based on #pwm-cells property of the
>>> PWM controller. Based on #pwm-cells property the xlate will consider
>>> the flags or not. This will permit the addition of other inputs to OF
>>> xlate by just adding proper code at the end of of_pwm_xlate() and a new
>>> input to enum pwm_args_xlate_options. With this changes there will be
>>> no need to fill of_xlate and of_pwm_n_cells of struct pwm_chip from
>>> the drivers probe methods. References in drives to references to of_xlate
>>> and of_pwm_n_cells were removed. Drivers which used private of_xlate
>>> functions switched to the generic of_pwm_xlate() function which fits
>>> for it but with little changes in device trees (these drivers translated
>>> differently the "pwms" bindings; the "pwms" bindings now are generic to
>>> all drivers and all drivers should provide them in the format described
>>> in pwm documentation).
>>>
>>> Cc: Thierry Reding <thierry.reding@gmail.com>
>>> Cc: Mike Dunn <mikedunn@newsguy.com>
>>> Cc: Brian Norris <briannorris@chromium.org>
>>> Cc: Alexander Shiyan <shc_work@mail.ru>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> ---
>>>
>>> This patch (and the next 7) could be applied independetly by this series, if
>>> any, but I choosed to have it here since it makes easy the PWM modes parsing.
>>> If you feel it could be independently of this series I could send a new version.
>>>
>>> Also, Thierry, Mike, Brian, Shiyan, please take an extra look over pwm-pxa.c,
>>> pwm-cros-ec.c and pwm-clps711x.c since these were moved to use the generic
>>> pwms (minimum 2 pwm-cells).
>>>
>>>  drivers/pwm/core.c             | 56 +++++++++++-------------------------------
>>>  drivers/pwm/pwm-atmel-hlcdc.c  |  2 --
>>>  drivers/pwm/pwm-atmel-tcb.c    |  2 --
>>>  drivers/pwm/pwm-atmel.c        |  6 -----
>>>  drivers/pwm/pwm-bcm-iproc.c    |  2 --
>>>  drivers/pwm/pwm-bcm-kona.c     |  2 --
>>>  drivers/pwm/pwm-bcm2835.c      |  2 --
>>>  drivers/pwm/pwm-berlin.c       |  2 --
>>>  drivers/pwm/pwm-clps711x.c     | 11 ---------
>>>  drivers/pwm/pwm-cros-ec.c      | 20 ---------------
>>
>> For pwm-cros-ec.c:
>>
>> Nacked-by: Brian Norris <briannorris@chromium.org>
>>
>> This is a fiat change of the documented binding, which breaks the RK3399
>> Kevin board. That's not how we do device tree.
>>
>> You can extend the binding if you want, so you can represent the period
>> in the device tree if you'd like (though the value won't mean anything;
>> it can't be changed by the kernel), but don't break existing device
>> trees.
> 
> That wasn't the idea, I wasn't intended to break something. The idea was
> to have a generic device tree parsing function since all the drivers,
> except pwm-pxa.c, pwm-cros-ec.c and pwm-clps711x.c, uses the same function
> to parse DT bindings. And I think, these 3 drivers could use this way of
> parsing, which is not something new, is what all the current PWM drivers
> uses (except pwm-pxa.c, pwm-cros-ec.c and pwm-clps711x.c). It is true
> I have no RK3399 board to run any tests.
> 
> pwm-cross-ec.c it is true that it's period cannot be changed. It is fixed, as
> I saw in the driver, at EC_PWM_MAX_DUTY=0xffff. The driver itself won't apply
> any PWM state if the period is different from EC_PWM_MAX_DUTY.
> For this driver, the PWM bindings were changed (I did a grep by "google,cros-ec-pwm"
> and located only:
> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> files) and changed the bindings in this series, as follows, patch 7 from this series:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 0384e3121f18..0c790ec387eb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -77,7 +77,7 @@
>  
>         backlight: backlight {
>                 compatible = "pwm-backlight";
> -               pwms = <&cros_ec_pwm 1>;
> +               pwms = <&cros_ec_pwm 1 65535>;
>                 brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
>                                      17 18 19 20 21 22 23 24 25 26 27 28 29 30
>                                      31 32 33 34 35 36 37 38 39 40 41 42 43 44
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 5772c52fbfd3..aa377f9ae6ad 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -853,7 +853,7 @@ ap_i2c_audio: &i2c8 {
>  
>                 cros_ec_pwm: ec-pwm {
>                         compatible = "google,cros-ec-pwm";
> -                       #pwm-cells = <1>;
> +                       #pwm-cells = <2>;
>                 };
>         };
> };
> 
> The code that was removed requests a PWM, the one that was set in the bindings, and
> then set pwm->args.period:
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
> 
> The old flow is as follows:
> of_pwm_get() -> cros_ec_pwm_xlate() { request chip and set constant period }
> 
> The new flow uses of_pwm_xlate():
> of_pwm_get() -> of_pwm_xlate() -> { parse PWM args: channel number, period, flags +
> request PWM chip + set pwm->args; }
> 
> This path is only used at DT parsing.
> 
> In case of PWM channel requested by PWM backlight driver it looks good to me
> with the changes in rk3399-gru-kevin.dts (please correct me if I'm wrong).
> 
> Since this driver accepts only EC_PWM_MAX_DUTY period maybe the documentation should
> be updated regarding this value?
> 
> Please, let me know what you think!
> 
> Thanks,
> Claudiu
>>
>>>  drivers/pwm/pwm-fsl-ftm.c      |  2 --
>>>  drivers/pwm/pwm-hibvt.c        |  2 --
>>>  drivers/pwm/pwm-imx.c          |  8 ------
>>>  drivers/pwm/pwm-lpc18xx-sct.c  |  2 --
>>>  drivers/pwm/pwm-meson.c        |  2 --
>>>  drivers/pwm/pwm-omap-dmtimer.c |  2 --
>>>  drivers/pwm/pwm-pxa.c          | 19 --------------
>>>  drivers/pwm/pwm-renesas-tpu.c  |  2 --
>>>  drivers/pwm/pwm-rockchip.c     |  5 ----
>>>  drivers/pwm/pwm-samsung.c      |  3 ---
>>>  drivers/pwm/pwm-sun4i.c        |  2 --
>>>  drivers/pwm/pwm-tiecap.c       |  2 --
>>>  drivers/pwm/pwm-tiehrpwm.c     |  2 --
>>>  drivers/pwm/pwm-vt8500.c       |  2 --
>>>  drivers/pwm/pwm-zx.c           |  2 --
>>>  include/linux/pwm.h            | 23 ++++++++++-------
>>>  26 files changed, 29 insertions(+), 156 deletions(-)
>>>
>> ...
>>
>>> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
>>> index 9c13694eaa24..692298693768 100644
>>> --- a/drivers/pwm/pwm-cros-ec.c
>>> +++ b/drivers/pwm/pwm-cros-ec.c
>>> @@ -133,24 +133,6 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>>  	state->duty_cycle = ret;
>>>  }
>>>  
>>> -static struct pwm_device *
>>> -cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
>>> -{
>>> -	struct pwm_device *pwm;
>>> -
>>> -	if (args->args[0] >= pc->npwm)
>>> -		return ERR_PTR(-EINVAL);
>>> -
>>> -	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
>>> -	if (IS_ERR(pwm))
>>> -		return pwm;
>>> -
>>> -	/* The EC won't let us change the period */
>>> -	pwm->args.period = EC_PWM_MAX_DUTY;
>>> -
>>> -	return pwm;
>>> -}
>>> -
>>>  static const struct pwm_ops cros_ec_pwm_ops = {
>>>  	.get_state	= cros_ec_pwm_get_state,
>>>  	.apply		= cros_ec_pwm_apply,
>>> @@ -207,8 +189,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
>>>  	/* PWM chip */
>>>  	chip->dev = dev;
>>>  	chip->ops = &cros_ec_pwm_ops;
>>> -	chip->of_xlate = cros_ec_pwm_xlate;
>>> -	chip->of_pwm_n_cells = 1;
>>>  	chip->base = -1;
>>>  	ret = cros_ec_num_pwms(ec);
>>>  	if (ret < 0) {
>>
>> ...
>>
>> Brian
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
