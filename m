From: Hao Zhang <hao5781286@gmail.com>
Subject: Re: [PATCH v1 4/4] ARM: dts: add pwm node for r40.
Date: Sun, 14 Jan 2018 14:43:39 +0800
Message-ID: <CAJeuY78QLOYZUUS7ghakqqpdzigdvpdHCsw+6onkUCjgZMqTzA@mail.gmail.com>
References: <20180111113412.GA22008@arx-s1> <20180111124752.2ljspnaclwgz2s62@flea.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180111124752.2ljspnaclwgz2s62@flea.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

2018-01-11 20:47 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Thu, Jan 11, 2018 at 07:34:12PM +0800, hao_zhang wrote:
>> This patch add pwm node for r40.
>>
>> Signed-off-by: hao_zhang <hao5781286@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>> index 173dcc1..84c963c 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -295,6 +295,11 @@
>>                               bias-pull-up;
>>                       };
>>
>> +                     pwm_pins: pwm-pins {
>> +                             pins = "PB2", "PB3";
>> +                             function = "pwm";
>> +                     };
>> +
>
> Is it the only combination of pins that is usable?
>
> If so, you can add the pinctrl-0 property directly in the pwm nodes.
>

There are 8 channel pwm of R40/V40/T3, the pins that can be configed to pwm are:
PB2, PB3, PI20, PI21, PB20, PB21, PB9, PB10

PB2, PB3 can be configed on bananapi-m2-ultra and on my T3 board, but
the other pins
is not exist on the board or some pin is confilct with other
functions, so i just add
PB2, PB3. but i think split it is better, just like this :

pwm0_pin: pwm0-pin {
    pins = "PB2";
    function = "pwm";
};

pwm1_pin: pwm1-pin {
    pins = "PB3";
    function = "pwm";
};

the node of pwm2~7 should also be added here?

On sun8i-r40-bananapi-m2-ultra.dts:
because of the special customize board, i think just add pinctrl-0 = <&pwm0_pin>
(PB3 I just use to test pwm channel 1)for bananapi-m2-ultra board is enough.

&pwm {
    pinctrl-names = "default";
    pinctrl-0 = <&pwm0_pin>;
    status = "okay";
};

Thanks ;-)
Hao Zhang


> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
