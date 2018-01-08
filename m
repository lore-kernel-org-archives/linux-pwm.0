From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
Date: Mon, 8 Jan 2018 19:08:53 +0800
Message-ID: <CAJeuY79_w+8Gv=jRxK4tajiecNSAZkMGYY_d7PJmsjyOZHPkJw@mail.gmail.com>
References: <20171213144748.GA18267@arx-s1> <20171213154549.5zn4uxhsssqw3pb7@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171213154549.5zn4uxhsssqw3pb7-ZC1Zs529Oq4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

2017-12-13 23:45 GMT+08:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> Hi,
>
> Thanks for your patch!
>
> On Wed, Dec 13, 2017 at 10:47:48PM +0800, hao_zhang wrote:
>> Pin function can not be match correctly when SUNXI_PIN describe with
>> mutiple variant and same function.
>>
>> such as:
>> on pinctrl-sun4i-a10.c
>>
>> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
>>               SUNXI_FUNCTION(0x0, "gpio_in"),
>>               SUNXI_FUNCTION(0x1, "gpio_out"),
>>               SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
>>                       PINCTRL_SUN4I_A10 |
>>                       PINCTRL_SUN7I_A20),
>>               SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
>>                       PINCTRL_SUN8I_R40)),
>>
>> it would always match to the first variant function
>> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
>>
>> so we should add variant compare on it.
>>
>> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index 4b6cb25..f23e74e 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -83,9 +83,11 @@ sunxi_pinctrl_desc_find_function_by_name(struct sunxi_pinctrl *pctl,
>>                       struct sunxi_desc_function *func = pin->functions;
>>
>>                       while (func->name) {
>> -                             if (!strcmp(func->name, func_name))
>> +                             if (!strcmp(func->name, func_name)) {
>> +                                     if (!(func->variant) ||
>> +                                        (func->variant & pctl->variant))
>
> I guess it would be better to have:
>         if (!strcmp(func->name, func_name) &&
>             (!func->variant || (func->variant & pctl->variant)))

It would over 80 characters, can i change it by this ?
if (!strcmp(func->name, func_name) &&
         (func->variant & pctl->variant ||
          !func->variant))

>
> Once fixed,
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
