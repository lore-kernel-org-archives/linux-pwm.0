From: =?ISO-8859-2?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH v2] clk: Add PWM clock driver
Date: Mon, 08 Dec 2014 21:03:50 +0100
Message-ID: <54860426.3020400@elproma.com.pl>
References: <1415007078-7947-1-git-send-email-p.zabel@pengutronix.de> <5480A132.2010103@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:49849 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753969AbaLHUDz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Dec 2014 15:03:55 -0500
In-Reply-To: <5480A132.2010103@elproma.com.pl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, Mike Turquette <mturquette@linaro.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi,

I've fixed my pwm driver and I can enable 12MHz 50% output using sysfs.=
=20
Then I rebased the pwm-clock to 3.14.
I have connected mcp2515 and it works with fixed clock. When I switch=20
the chip's clock to pwm clock in dt
I get "mcp251x: probe of spi1.2 failed with error -2". I've also added=20
clock-frequency property
but it didn't help.
When I set the mcp2515 clock to fixed clock again but the clock is not=20
applied to mcp2515 I get
"mcp251x spi1.2: MCP251x didn't enter in conf mode after reset".
So it looks this is indeed probe error caused likely by dt.

The fixed and pwm clock in DT:
         clocks {
                 #address-cells =3D <1>;
                 #size-cells =3D <1>;
                 ranges;
                 mcp251x_xtal_clk: mcp2515_xtal {
                         compatible =3D "fixed-clock";
                         #clock-cells =3D <0>;
                         clock-frequency =3D <12000000>;
                 };

                 mcp251x_pwm_clk: mcp2515_pwm {
                         compatible =3D "pwm-clock";
                         #clock-cells =3D <0>;
                         clock-frequency =3D <12000000>;
                         clock-output-names =3D "can_clk";
                         pwms =3D <&pwm 3 83>;     /* 12MHz =3D 1 / ~83=
ns */
                 };
         };

Also the mentioned frequency recalculation problem appears here.
In the case above recalc value is about 12.048MHz instead of 12.0MHz.
While PWM block is clocked 24MHz and the pwm generates exactly 12MHz
the pwm-clock driver returns drifted value. Using clock-frequency like
fixed-clock does could simply solve the binding problem.

thanks,
Janusz


W dniu 2014-12-04 o 19:00, Janusz U=BFycki pisze:
> Hi,
>
> W dniu 2014-11-03 o 10:31, Philipp Zabel pisze:
>> Some board designers, when running out of clock output pads, decide =
to
>> (mis)use PWM output pads to provide a clock to external components.
>> This driver supports this practice by providing an adapter between t=
he
>> PWM and clock bindings in the device tree. As the PWM bindings speci=
fy
>> the period in the device tree, this is a fixed clock.
>>
>> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>> I'm resending this because last time the linux-pwm list was not in C=
c:
>> So far I have not received any comments on the patch itself. I have =
used
>> it on a BoundaryDevices Nitrogen6X board to produce a master clock f=
or
>> the OV5640 MIPI CSI-2 camera module.
>>
>> Changes since v1:
>>   - none (rebased onto v3.18-rc3)
>> ---
>>   .../devicetree/bindings/clock/pwm-clock.txt        |  23 +++++
>>   drivers/clk/Kconfig                                |   7 ++
>>   drivers/clk/Makefile                               |   1 +
>>   drivers/clk/clk-pwm.c                              | 110=20
>> +++++++++++++++++++++
>>   4 files changed, 141 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/clock/pwm-clock.txt
>>   create mode 100644 drivers/clk/clk-pwm.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/pwm-clock.txt=20
>> b/Documentation/devicetree/bindings/clock/pwm-clock.txt
>> new file mode 100644
>> index 0000000..d127d17
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/pwm-clock.txt
>> @@ -0,0 +1,23 @@
>> +Binding for an external clock signal driven by a PWM pin.
>> +
>> +This binding uses the common clock binding[1] and the common PWM=20
>> binding[2].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +[2] Documentation/devicetree/bindings/pwm/pwm.txt
>> +
>> +Required properties:
>> +- compatible : shall be "pwm-clock".
>> +- #clock-cells : from common clock binding; shall be set to 0.
>> +- pwms : from common PWM binding; this determines the clock frequen=
cy
>> +  via the PWM period given in the pwm-specifier.
>> +
>> +Optional properties:
>> +- clock-output-names : From common clock binding.
>> +
>> +Example:
>> +    clock {
>> +        compatible =3D "pwm-clock";
>> +        #clock-cells =3D <0>;
>> +        clock-output-names =3D "mipi_mclk";
>> +        pwms =3D <&pwm2 0 40>; /* 1 / 40 ns =3D 25 MHz */
>
> Before I asked about [MHz/kHz] <-> [ns] conversion problem but I=20
> didn't noticed
> you've just used [ns] in dt. As Thierry wrote:
> "Also the PWM chips will most likely use the concept of period and=20
> duty-cycle
> internally anyway, so it will convert back from Hz/percentage to=20
> nanoseconds
> and fall victim to similar rounding effects."
>
> Unfortunately I discovered that many pwm drivers are buggy around=20
> upper freqs limit.
> The example is pwm-mxs.c. PWM has 24MHz clock. There is no problem to=
 set
> registers directly for 12MHz 50% output (period_cycles=3D2-1=3D1,=20
> inactive_c=3D1, active_c=3D0).
>
> When I set pwm-mxs period to 83ns / duty to 42ns the output is low=20
> because
> it sets inactive_c=3D0!
> For 125ns/63ns I got about 6MHz instead of 8MHz, and +width=3D42ns.
> When I set 42ns/42ns I got 12MHz 50%.
> It means new patches for pwms...
>
> I will test the patch backported to 3.14 using the mxs platform.
> However as I wrote I  need to patch pwm-mxs first.
>
>> [...]
>>
>> +static struct platform_driver clk_pwm_driver =3D {
>> +    .probe =3D clk_pwm_probe,
>> +    .driver =3D {
>> +        .name =3D "pwm-clock",
>> +        .owner =3D THIS_MODULE,
>
> AFAIR new drivers don't need to set .owner.
>
> thanks
> Janusz
>
>> +        .of_match_table =3D of_match_ptr(clk_pwm_dt_ids),
>> +    },
>> +};
>> +
>> +module_platform_driver(clk_pwm_driver);
>

