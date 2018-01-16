From: Claudiu Beznea <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
Date: Tue, 16 Jan 2018 10:24:59 +0200
Message-ID: <9a130c0b-572d-be0b-8ac7-596714208d41@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
 <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TbrhsbdSgBK9A@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org



On 15.01.2018 22:27, Andy Shevchenko wrote:
> On Mon, Jan 15, 2018 at 10:41 AM, Claudiu Beznea
> <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
> 
>> For this driver, the PWM bindings were changed (I did a grep by "google,cros-ec-pwm"
>> and located only:
>> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>> arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
>> files) and changed the bindings in this series, as follows, patch 7 from this series:
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>> index 0384e3121f18..0c790ec387eb 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
>> @@ -77,7 +77,7 @@
>>
>>         backlight: backlight {
>>                 compatible = "pwm-backlight";
>> -               pwms = <&cros_ec_pwm 1>;
>> +               pwms = <&cros_ec_pwm 1 65535>;
> 
> This shows an breakage for user.
As long as pwm-cells=2 the OF hooks will read PWM channel and PWM period
(e.g. in this case, PWM channel=1, PWM period=65532)
I don't see a breakage here. Please explain me further.

The old PWM device tree sources or
> binaries should work independently on what changes you did to kernel.
Please explain me further. From this I understand, as a general rule,
that the device tree binaries from, e.g. 3 years ago, should be
compatible with, e.g. the current version of kernel?

Thanks,
Claudiu
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
