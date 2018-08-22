From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Date: Wed, 22 Aug 2018 09:01:50 +0200
Message-ID: <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822081436.13d8f55b@ipc1.ka-ro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On 22.8.2018 08:14, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>> is disabled. This can caue issues when inverted PWM polarity is needed.
>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>> on the output. If the PWM is dissabled its output instantly goes to solid
>> zero which corresponds to duty cycle = 100%.
>>
>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>> with pull-up. Then switch the pad to PWM output whenever non-zero
>> duty cycle is needed.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> index c61bdf8..3b1bc4c 100644
>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>   	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>   - interrupts: The interrupt for the pwm controller
>>   
>> +Optional properties:
>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>> +  pin to gpio function.  It allows control over the pin output level when the
>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>> +
>>   Example:
>>   
>>   pwm1: pwm@53fb4000 {
>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>   	clock-names = "ipg", "per";
>>   	interrupts = <61>;
>>   };
>> +
>> +Inverted PWM output
>> +-------------------
>> +
>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>> +output, the output level is always zero volts when the PWM block is disabled.
>> +The zero output level is actively driven by the output stage of the PWM block
>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>> +a PWM client (e.g. backlight) requested.
>> +
>> +To gain control of the PWM output level in disabled state two pinctrl states
>> +can be used. The "default" state and the "pwm" state. In the default state the
>>
> The "default" function of a PWM is to deliver a PWM signal. So it is
> more sensible to me to have the PWM function as "default" and a "gpio"
> function as alternative state.

Yes, I totally agree that using "default" for PWM and "gpio" as the
alternative function seems more sensible. That is actually how I started.
Then I realized that that way you end up with the PWM pad set to zero
until the first call of imx_pwm_apply_v2 where you can select the GPIO
function. On my system that first call is made by pwm-backlight more than
3s after pinctrl init.

I suggested to use the "default" state as a GPIO function as the only way
how to get a truly inverted PWM output all the time from power-up to
power-down.

In my opinion it is up to the DT author what pad configuration he uses for
each pinctrl function as he knows what the HW really needs. I see that this
approach is kind of controversial but I hope that with good documentation
this would not be a problem. And as I wrote in the intro, it is absolutely
optional. If you do not need it, you do not use it.

>> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
>> +is configured as a PWM output. This setup assures that the PWM output is at
>> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
>> +E.g. at boot.
>> +
>> +Example:
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default", "pwm";
>> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
>> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
>> +}
>> +
>> +pinctrl_backlight_gpio: pwm1grp-gpio {
>> +	fsl,pins = <
>> +		/* GPIO with 22kOhm pull-up */
>> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
>> +	>;
>> +};
>> +
>> +pinctrl_backlight_pwm: pwm1grp-pwm {
>> +	fsl,pins = <
>> +		/* PWM output */
>> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
>> +	>;
>> +};
> 
> 
> 
