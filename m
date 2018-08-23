From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Date: Thu, 23 Aug 2018 11:13:48 +0200
Message-ID: <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
 <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
 <20180822131758.162d5351@ipc1.ka-ro>
 <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
 <20180822161036.4d69bdc1@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822161036.4d69bdc1@ipc1.ka-ro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On 22.8.2018 16:10, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> On 22.8.2018 13:17, Lothar Waßmann wrote:
>>> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>>    
>>>> On 22.8.2018 08:14, Lothar Waßmann wrote:
>>>>> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>>>>       
>>>>>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>>>>>> is disabled. This can caue issues when inverted PWM polarity is needed.
>>>>>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>>>>>> on the output. If the PWM is dissabled its output instantly goes to solid
>>>>>> zero which corresponds to duty cycle = 100%.
>>>>>>
>>>>>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>>>>>> with pull-up. Then switch the pad to PWM output whenever non-zero
>>>>>> duty cycle is needed.
>>>>>>
>>>>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>>>>>     1 file changed, 44 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> index c61bdf8..3b1bc4c 100644
>>>>>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>>>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>>>>>     	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>>>     - interrupts: The interrupt for the pwm controller
>>>>>>     
>>>>>> +Optional properties:
>>>>>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>>>>>> +  pin to gpio function.  It allows control over the pin output level when the
>>>>>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>>>>>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>>>>>> +
>>>>>>     Example:
>>>>>>     
>>>>>>     pwm1: pwm@53fb4000 {
>>>>>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>>>>>     	clock-names = "ipg", "per";
>>>>>>     	interrupts = <61>;
>>>>>>     };
>>>>>> +
>>>>>> +Inverted PWM output
>>>>>> +-------------------
>>>>>> +
>>>>>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>>>>>> +output, the output level is always zero volts when the PWM block is disabled.
>>>>>> +The zero output level is actively driven by the output stage of the PWM block
>>>>>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>>>>>> +a PWM client (e.g. backlight) requested.
>>>>>> +
>>>>>> +To gain control of the PWM output level in disabled state two pinctrl states
>>>>>> +can be used. The "default" state and the "pwm" state. In the default state the
>>>>>>      
>>>>> The "default" function of a PWM is to deliver a PWM signal. So it is
>>>>> more sensible to me to have the PWM function as "default" and a "gpio"
>>>>> function as alternative state.
>>>>
>>>> Yes, I totally agree that using "default" for PWM and "gpio" as the
>>>> alternative function seems more sensible. That is actually how I started.
>>>> Then I realized that that way you end up with the PWM pad set to zero
>>>> until the first call of imx_pwm_apply_v2 where you can select the GPIO
>>>> function. On my system that first call is made by pwm-backlight more than
>>>> 3s after pinctrl init.
>>>>
>>>> I suggested to use the "default" state as a GPIO function as the only way
>>>> how to get a truly inverted PWM output all the time from power-up to
>>>> power-down.
>>>>
>>>> In my opinion it is up to the DT author what pad configuration he uses for
>>>> each pinctrl function as he knows what the HW really needs. I see that this
>>>> approach is kind of controversial but I hope that with good documentation
>>>> this would not be a problem. And as I wrote in the intro, it is absolutely
>>>> optional. If you do not need it, you do not use it.
>>>>   
>>> This is OK so far.
>>> But the approach with the pin being driven high via the pullup
>>> configuration has a fundamental flaw:
>>> The pwm polarity is specified by the PWM client (e.g: the pwm-backlight
>>> driver:
>>> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
>>> )
>>> The pinconfig is defined in the pinctrl of the PWM driver.
>>>
>>> If you have clients that may use the same PWM instance and require
>>> different polarity, there is no way to set the pullup/-down
>>> configuration in accordance with the clients needs.
>>
>> Hmm, I did not think about more than one PWM client. Is it even possible
>> to design such board? Do you have an example of such usage? It would mean
>>
> My use case is attaching different displays to the same baseboard,
> where some displays have the brightness control pin inverted with
> respect to the others. It's easy to change the compatible string for
> the simple-panel driver and the PWM polarity setting for the
> pwm-backlight driver from U-Boot according to the display model, but
> it's not so easy, to edit the pinctrl settings from pull-up to
> pull-down or vice versa.

OK, I got it. Though that is something different than having two clients,
right?

You do not actually need to change the pinctrl pull-up/down configuration
in bootloader. You define the two pinctrl groups as I suggested in the
example. Or more precisely, you add a new pinctrl group where the PWM
output pad is configured as a GPIO with pull-up. You add this group to
all your common device trees. This does no harm as the group is not used
yet.

In bootloader you detect the type of the panel. Normal PWM polarity? OK,
do nothing and boot. Inverted PWM polarity? Set the pinctrl-names property
to "default", "pwm". Set the pinctrl-0 property to point to the GPIO group
and set pinctrl-1 property to point to the old PWM group.

E.g. something like:

=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-names default pwm
=> fdt get value gpio-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-gpio phandle
=> fdt get value pwm-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-pwm phandle
=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-0 ${gpio-phandle}
=> fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-1 ${pwm-phandle}

Will this work for you?

Michal
