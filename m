From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Date: Thu, 23 Aug 2018 13:21:04 +0200
Message-ID: <0691e93d-c2e2-21e5-374f-c29e7765de93@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180823123759.68b78e9f@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823123759.68b78e9f@jawa>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On 23.8.2018 12:40, Lukasz Majewski wrote:

Hi Lukasz, thanks for the reply!
> Hi Michal,
> 
>> Output of the PWM block of i.MX SoCs is always zero volts when the
>> block is disabled. This can caue issues when inverted PWM polarity is
>> needed. With inverted polarity a duty cycle = 0% corresponds to solid
>> high level on the output. If the PWM is dissabled its output
>> instantly goes to solid zero which corresponds to duty cycle = 100%.
>>
>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>> with pull-up. Then switch the pad to PWM output whenever non-zero
>> duty cycle is needed.
> 
> Just to ask - Is your display equipped with power supply enable/disable
> pin?

No it is not. The backlight on my display is just a bunch of serial-
parallel connected LEDs with separate GND and VCC pins on a separate flex
cable. And the display itself also does not have a reset or enable signal.
It is a PITA to use it I must say..
  
> As fair as I remember the trick to avoid flickering the display
> was to disable the display (enable-gpio property) and set the PWM PIN
> as GPIO to high in u-boot.

Yes, I know about that. I can not use this as the PWM output is the only
signal I have to control the backlight. I mentioned that somewhere in the
previous discussion with Lothar.

I also think this could be useful not only for backlight. Any circuit that
requires truly inverted PWM signal can use it. I see it as an enhancement
to what you with Lothar have already done ;)
  
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44
>> +++++++++++++++++++++++ 1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt index
>> c61bdf8..3b1bc4c 100644 ---
>> a/Documentation/devicetree/bindings/pwm/imx-pwm.txt +++
>> b/Documentation/devicetree/bindings/pwm/imx-pwm.txt @@ -14,6 +14,12
>> @@ See the clock consumer binding,
>> Documentation/devicetree/bindings/clock/clock-bindings.txt
>>   - interrupts: The interrupt for the pwm controller
>>   
>> +Optional properties:
>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure
>> the PWM
>> +  pin to gpio function.  It allows control over the pin output level
>> when the
>> +  PWM block is disabled. This is meant to be used if inverted
>> polarity of the
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
>> +The i.MX SoC has such limitation that whenever a pad is configured
>> as a PWM +output, the output level is always zero volts when the PWM
>> block is disabled. +The zero output level is actively driven by the
>> output stage of the PWM block +and can not be overridden by pull-up.
>> It also does not matter what PWM polarity +a PWM client (e.g.
>> backlight) requested. +
>> +To gain control of the PWM output level in disabled state two
>> pinctrl states +can be used. The "default" state and the "pwm" state.
>> In the default state the +PWM output is configured as a GPIO with
>> pull-up. In the "pwm" state the output +is configured as a PWM
>> output. This setup assures that the PWM output is at +the required
>> level that corresponds to duty cycle = 0 when PWM is disabled. +E.g.
>> at boot. +
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
