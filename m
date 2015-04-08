From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 3/6] ARM:dts exynos5422 Update the thermal sensor for tmu_cpu0
Date: Wed, 8 Apr 2015 15:14:52 +0530
Message-ID: <CANAwSgSs+cV=qwA4vSO59KtQDHr8ZoM9JnOk6r2EhxtYp8-f4w@mail.gmail.com>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
	<1427387955-5129-4-git-send-email-linux.amoon@gmail.com>
	<20150408100240.7f597dae@amdc2363>
	<CANAwSgTSsGF1p7ehvMHpBX5MbtickOKXe3oZw26EuB9BMxY4Hg@mail.gmail.com>
	<20150408113003.78ec5f86@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150408113003.78ec5f86@amdc2363>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Lukasz,

I have Odroidxu3 board with fan. Odroid xu3 board and run on high tempe=
rature.

As per my understating as the sensors temperature cross the first
alert it triggers fan to run.
I was doing some stress testing to trigger this overheating with my cha=
nges.

-Anand Moon

On 8 April 2015 at 15:00, Lukasz Majewski <l.majewski@samsung.com> wrot=
e:
> Hi Anand,
>
>> Hi Lukasz,
>>
>> On Odroidxu3 board critical temp is 85.0 C. Below is the sensors
>> output.
>
> Do you have XU3 with a fan?
>
>>
>> therm_zone0-virtual-0
>> Adapter: Virtual device
>> temp1: +39.0=E2=96=92=E1=81=B0C (crit =3D +85.0=E2=96=92=C2=B0C)
>> temp2: +38.0=E2=96=92=C2=B0C (crit =3D +85.0=E2=96=92=C2=B0C)
>> temp3: +40.0=E2=96=92=C2=B0C (crit =3D +85.0=E2=96=92=C2=B0C)
>> temp4: +49.0=E2=96=92=C2=B0C (crit =3D +85.0=E2=96=92=C2=B0C)
>> temp5: +29.0=E2=96=92=C2=B0C (crit =3D +85.0=E2=96=92=C2=B0C)
>>
>> I have observed cpu shutdown as we do test pm-qa thermal testing.
>>
>> So I propose the temperature values to be 50000, 65000 ,80000 and
>> 85000 Critical temperature.
>>
>
> This seems strange - since other Samsung's SoC have higher work
> temperatures (both exynos5 and exynos4).
>
> I will try to check those thresholds on my XU3. Have anybody else
> experienced overheating at XU3?
>
> Sjoerd? Kukjin?
>
>> Please share your thoughts.
>>
>> -Anand Moon
>>
>> On 8 April 2015 at 13:32, Lukasz Majewski <l.majewski@samsung.com>
>> wrote:
>> > Hi Anand,
>> >
>> >> Move the registration of thermal sensors for tmu_cpu0 from
>> >> exynos5420.dtsi to exynos5-cpu-thermal.dtsi, to avoid duplicate
>> >> registration of the sensors.
>> >>
>> >> Tested on OdroidXU3 board.
>> >>
>> >> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> >> ---
>> >>  arch/arm/boot/dts/exynos5-cpu-thermal.dtsi | 58
>> >> ++++++++++++++++++++++++++++++
>> >> arch/arm/boot/dts/exynos5420.dtsi          |  4 ---
>> >> arch/arm/boot/dts/exynos5422-odroidxu3.dts |  1 + 3 files changed=
,
>> >> 59 insertions(+), 4 deletions(-) create mode 100644
>> >> arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
>> >>
>> >> diff --git a/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
>> >> b/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi new file mode 100644
>> >> index 0000000..8fede70
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/exynos5-cpu-thermal.dtsi
>> >> @@ -0,0 +1,58 @@
>> >> +/*
>> >> + * Device tree sources for Exynos5 thermal zone
>> >> + *
>> >> + * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
>> >
>> >                         ^^^^^^^^^^^^^^^^ Could you update this
>> >                         line :-). I'm just reviewer here :-)
>> >
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or
>> >> modify
>> >> + * it under the terms of the GNU General Public License version =
2
>> >> as
>> >> + * published by the Free Software Foundation.
>> >> + *
>> >> + */
>> >> +
>> >> +#include <dt-bindings/thermal/thermal.h>
>> >> +
>> >> +/ {
>> >> +     thermal-zones {
>> >> +             cpu0_thermal: cpu0-thermal {
>> >> +                     thermal-sensors =3D <&tmu_cpu0>;
>> >> +                     polling-delay-passive =3D <0>;
>> >> +                     polling-delay =3D <0>;
>> >> +                     trips {
>> >> +                             cpu_alert0: cpu-alert-0 {
>> >> +                                     temperature =3D <48000>; /*=
 ms
>> >> */
>> >> +                                     hysteresis =3D <3000>; /* m=
s */
>> >                                                             ^^^^^^=
^^^
>> >                                                         We already
>> > have "millicelsius"
>> >                                                         instead od
>> > ms
>> >> +                                     type =3D "active";
>> >> +                             };
>> >> +                             cpu_alert1: cpu-alert-1 {
>> >> +                                     temperature =3D <53000>; /*=
 ms
>> >> */
>> >> +                                     hysteresis =3D <3000>; /* m=
s */
>> >> +                                     type =3D "active";
>> >> +                             };
>> >> +                             cpu_alert2: cpu-alert-2 {
>> >> +                                     temperature =3D <59000>; /*=
 ms
>> >> */
>> >> +                                     hysteresis =3D <3000>; /* m=
s */
>> >> +                                     type =3D "active";
>> >> +                             };
>> >> +                             cpu_crit0: cpu-crit-0 {
>> >> +                                     temperature =3D <75000>; /*=
 ms
>> >> */
>> >> +                                     hysteresis =3D <0>; /* ms *=
/
>> >> +                                     type =3D "critical";
>> >
>> >                 Is there any special reasons why we need special
>> > values for cpu0_thermal sensor at XU3? Is something wrong with
>> >                 default values defined at exynos4-cpu-thermal.dtsi=
?
>> >
>> >                 If this is Odroid XU3 specific, then IMHO it shoul=
d
>> > be added to exynos5422-odroidxu3.dts
>> >
>> >> +                             };
>> >> +                     };
>> >> +                     cooling-maps {
>> >> +                             map0 {
>> >> +                                  trip =3D <&cpu_alert0>;
>> >> +                                  cooling-device =3D <&fan0 0 1>=
;
>> >> +                             };
>> >> +                             map1 {
>> >> +                                  trip =3D <&cpu_alert1>;
>> >> +                                  cooling-device =3D <&fan0 1 2>=
;
>> >> +                             };
>> >> +                             map2 {
>> >> +                                  trip =3D <&cpu_alert2>;
>> >> +                                  cooling-device =3D <&fan0 2 3>=
;
>> >> +                             };
>> >> +                     };
>> >> +             };
>> >> +     };
>> >> +};
>> >> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
>> >> b/arch/arm/boot/dts/exynos5420.dtsi index 6b49f3c..eb0f16c 100644
>> >> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> >> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> >> @@ -827,10 +827,6 @@
>> >>       };
>> >>
>> >>       thermal-zones {
>> >> -             cpu0_thermal: cpu0-thermal {
>> >> -                     thermal-sensors =3D <&tmu_cpu0>;
>> >> -                     #include "exynos5420-trip-points.dtsi"
>> >                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [1]
>> >
>> >> -             };
>> >>               cpu1_thermal: cpu1-thermal {
>> >>                      thermal-sensors =3D <&tmu_cpu1>;
>> >>                      #include "exynos5420-trip-points.dtsi"
>> >> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> >> b/arch/arm/boot/dts/exynos5422-odroidxu3.dts index eaec006..c8b3e=
3e
>> >> 100644 --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> >> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
>> >> @@ -12,6 +12,7 @@
>> >>
>> >>  /dts-v1/;
>> >>  #include "exynos5800.dtsi"
>> >> +#include "exynos5-cpu-thermal.dtsi"
>> >
>> > I would prefer to stick to convention proposed at [1]. It keeps
>> > the locality of the include with respective thermal zone.
>> >
>> >>
>> >>  / {
>> >>       model =3D "Hardkernel Odroid XU3";
>> >
>> > DTS changes should be added to Samsung tree by Samsung maintainer =
-
>> > Mr. Kukjin Kim.
>> >
>> > --
>> > Best regards,
>> >
>> > Lukasz Majewski
>> >
>> > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
