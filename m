From: Hao Zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: dtsi: add pwm node for sun8i.
Date: Tue, 15 May 2018 00:08:57 +0800
Message-ID: <CAJeuY7876=WEpg9M240ygNv6KW68_+tpP9PxpSQfKHNR7=FO-Q@mail.gmail.com>
References: <20180225135134.GA14529@arx-s1> <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4@arm.com>
Reply-To: hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDKITZOARQMBBG7J43LQKGQEARZGIEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <b8af4f6a-c2df-7382-9a1c-9c1a9ea5f8c4-5wv7dgnIgG8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

2018-02-28 9:53 GMT+08:00 Andr=C3=A9 Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>:
> Hi,
>
> The subject line should mention the R40, there are far too many sun8i SoC=
s.

Okey.

>
> On 25/02/18 13:51, hao_zhang wrote:
>> This patch adds pwm node for sun8i.
>>
>> Signed-off-by: hao_zhang <hao5781286-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-=
r40.dtsi
>> index 173dcc1..99a0261 100644
>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>> @@ -295,6 +295,11 @@
>>                               bias-pull-up;
>>                       };
>>
>> +                     pwm_ch0_pin: pwm-ch0-pin {
>> +                             pins =3D "PB2";
>> +                             function =3D "pwm";
>> +                     };
>> +
>>                       uart0_pb_pins: uart0-pb-pins {
>>                               pins =3D "PB22", "PB23";
>>                               function =3D "uart0";
>> @@ -306,6 +311,14 @@
>>                       reg =3D <0x01c20c90 0x10>;
>>               };
>>
>> +             pwm: pwm@1c23400 {
>> +                          compatible =3D "allwinner,sun8i-r40-pwm";
>> +                          reg =3D <0x01c23400 0x154>;
>
> Following my comments on the binding document:
>                         interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
>
>> +                          clocks =3D <&osc24M>;
>
> And possibly multiple clocks here (though I fail to find the APB1 clock
> being exposed by our CCU).

It seem CCU dosen't support APB1 clock for R40 PWM...

>
> Cheers,
> Andre.
>
>> +                          #pwm-cells =3D <3>;
>> +                          status =3D "disabled";
>> +             };
>> +
>>               uart0: serial@1c28000 {
>>                       compatible =3D "snps,dw-apb-uart";
>>                       reg =3D <0x01c28000 0x400>;
>>
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
