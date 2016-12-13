From: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 7/8] ARM: dts: stm32: add Timers driver for stm32f429 MCU
Date: Tue, 13 Dec 2016 10:15:21 +0100
Message-ID: <CA+M3ks6hMDVqDkjn_vcu-d2YkJkiAmCS44Nc7rtfgAkD09LNFA@mail.gmail.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-8-git-send-email-benjamin.gaignard@st.com> <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161212185943.ph7njaqb2lxtgdn4@rob-hp-laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>, Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

2016-12-12 19:59 GMT+01:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Fri, Dec 09, 2016 at 03:15:18PM +0100, Benjamin Gaignard wrote:
>> Add Timers and it sub-nodes into DT for stm32f429 family.
>>
>> version 6:
>> - split patch in two: one for SoC family and one for stm32f469
>>   discovery board.
>>
>> version 5:
>> - rename gptimer node to timers
>> - re-order timers node par addresses
>>
>> version 4:
>> - remove unwanted indexing in pwm@ and timer@ node name
>> - use "reg" instead of additional parameters to set timer
>>   configuration
>>
>> version 3:
>> - use "st,stm32-timer-trigger" in DT
>>
>> version 2:
>> - use parameters to describe hardware capabilities
>> - do not use references for pwm and iio timer subnodes
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/stm32f429.dtsi | 275 ++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 275 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f=
429.dtsi
>> index bca491d..d0fb9cc 100644
>> --- a/arch/arm/boot/dts/stm32f429.dtsi
>> +++ b/arch/arm/boot/dts/stm32f429.dtsi
>> @@ -355,6 +355,21 @@
>>                                       slew-rate =3D <2>;
>>                               };
>>                       };
>> +
>> +                     pwm1_pins: pwm@1 {
>
> No reg prop, so should not have a unit-address. Given the names in the
> define below, seems like "timer1" would be appropriate.
>
>> +                             pins {
>> +                                     pinmux =3D <STM32F429_PA8_FUNC_TIM=
1_CH1>,
>> +                                              <STM32F429_PB13_FUNC_TIM1=
_CH1N>,
>> +                                              <STM32F429_PB12_FUNC_TIM1=
_BKIN>;
>> +                             };
>> +                     };
>> +
>> +                     pwm3_pins: pwm@3 {
>> +                             pins {
>> +                                     pinmux =3D <STM32F429_PB4_FUNC_TIM=
3_CH1>,
>> +                                              <STM32F429_PB5_FUNC_TIM3_=
CH2>;
>> +                             };
>> +                     };
>>               };
>>
>>               rcc: rcc@40023810 {
>> @@ -426,6 +441,266 @@
>>                       interrupts =3D <80>;
>>                       clocks =3D <&rcc 0 38>;
>>               };
>> +
>> +             timers2: timers@40000000 {
>
> timer@...
>
> It may be more than just a timer, there's not a better generic name.
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000000 0x400>;
>> +                     clocks =3D <&rcc 0 128>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <1>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers3: timers@40000400 {
>
> ditto
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000400 0x400>;
>> +                     clocks =3D <&rcc 0 129>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <2>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers4: timers@40000800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000800 0x400>;
>> +                     clocks =3D <&rcc 0 130>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <3>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers5: timers@40000C00 {
>
> timer@...
>
> And use lowercase hex.
>
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40000C00 0x400>;
>
> ditto
>
>> +                     clocks =3D <&rcc 0 131>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <4>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers6: timers@40001000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001000 0x400>;
>> +                     clocks =3D <&rcc 0 132>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <5>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers7: timers@40001400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001400 0x400>;
>> +                     clocks =3D <&rcc 0 133>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <6>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers12: timers@40001800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001800 0x400>;
>> +                     clocks =3D <&rcc 0 134>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <9>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers13: timers@40001C00 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40001C00 0x400>;
>> +                     clocks =3D <&rcc 0 135>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers14: timers@40002000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40002000 0x400>;
>> +                     clocks =3D <&rcc 0 136>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers1: timers@40010000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40010000 0x400>;
>> +                     clocks =3D <&rcc 0 160>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <0>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers8: timers@40010400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40010400 0x400>;
>> +                     clocks =3D <&rcc 0 161>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <7>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers9: timers@40014000 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014000 0x400>;
>> +                     clocks =3D <&rcc 0 176>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +
>> +                     timer {
>> +                             compatible =3D "st,stm32-timer-trigger";
>> +                             reg =3D <8>;
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers10: timers@40014400 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014400 0x400>;
>> +                     clocks =3D <&rcc 0 177>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>> +
>> +             timers11: timers@40014800 {
>> +                     #address-cells =3D <1>;
>> +                     #size-cells =3D <0>;
>> +                     compatible =3D "st,stm32-timers";
>> +                     reg =3D <0x40014800 0x400>;
>> +                     clocks =3D <&rcc 0 178>;
>> +                     clock-names =3D "clk_int";
>> +                     status =3D "disabled";
>> +
>> +                     pwm {
>> +                             compatible =3D "st,stm32-pwm";
>> +                             status =3D "disabled";
>> +                     };
>> +             };
>>       };
>>  };
>>
>> --
>> 1.9.1
>>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
