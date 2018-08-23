From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
Date: Thu, 23 Aug 2018 14:38:22 +0200
Message-ID: <5a5c419a-b08f-f913-01ad-715e28164731@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
 <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
 <20180822131758.162d5351@ipc1.ka-ro>
 <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
 <20180822161036.4d69bdc1@ipc1.ka-ro>
 <5b13d21c-f83f-49b0-eedd-9a4995dbd469@ysoft.com>
 <20180823131816.741c09cc@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823131816.741c09cc@ipc1.ka-ro>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On 23.8.2018 13:18, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>> On 22.8.2018 16:10, Lothar Waßmann wrote:
>>> My use case is attaching different displays to the same baseboard,
>>> where some displays have the brightness control pin inverted with
>>> respect to the others. It's easy to change the compatible string for
>>> the simple-panel driver and the PWM polarity setting for the
>>> pwm-backlight driver from U-Boot according to the display model, but
>>> it's not so easy, to edit the pinctrl settings from pull-up to
>>> pull-down or vice versa.
>>
>> OK, I got it. Though that is something different than having two clients,
>> right?
>>
>> You do not actually need to change the pinctrl pull-up/down configuration
>> in bootloader. You define the two pinctrl groups as I suggested in the
>> example. Or more precisely, you add a new pinctrl group where the PWM
>> output pad is configured as a GPIO with pull-up. You add this group to
>> all your common device trees. This does no harm as the group is not used
>> yet.
>>
>> In bootloader you detect the type of the panel. Normal PWM polarity? OK,
>> do nothing and boot. Inverted PWM polarity? Set the pinctrl-names property
>> to "default", "pwm". Set the pinctrl-0 property to point to the GPIO group
>> and set pinctrl-1 property to point to the old PWM group.
>>
>> E.g. something like:
>>
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-names default pwm
>> => fdt get value gpio-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-gpio phandle
>> => fdt get value pwm-phandle /soc/aips-bus@2000000/iomuxc@20e0000/pwm1grp-pwm phandle
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-0 ${gpio-phandle}
>> => fdt set /soc/aips-bus@2000000/pwm@2080000 pinctrl-1 ${pwm-phandle}
>>
>> Will this work for you?
>>
> This would probably work, but it's quite ugly.
> I'd still prefer to set the pin output state to the desired level
> rather than relying on the chip internal pullup/pulldown facility.

You mean like actively setting the pin HIGH or LOW using
gpiod_set_value_cansleep()? I also used that in my very first prototype.
But even for that you still need to define the second GPIO pinctrl group
and select it before you can set the GPIO value. I think because this is
all meant to be used only with inverted PWM output you naturally configure
the GPIO with pull-up. So you do not need to actively drive the pin.
Is your concern that the 22k pull-up may not be strong enough for any
connected circuit? IMO the whole point of totally disabling the PWM is to
save some power. So I will go with just the pull-up.

In your case you also need additional xxxx-gpios property that describes
the GPIO. Actually here you have one more option to invert the logic as
you can specify the GPIO as GPIO_ACTIVE_LOW or GPIO_ACTIVE_HIGH.
For inverted PWM output you should use GPIO_ACIVE_LOW. In your case you
will need to tweak that in the bootloader also.

The final DT fow inverted PWM for backlight will look like this:

         backlight {
                 compatible = "pwm-backlight";
                 pwms = <&pwm1 0 500000 PWM_POLARITY_INVERTED>;
                 brightness-levels = <0 32 64 128 255>;
                 default-brightness-level = <32>;
                 num-interpolated-steps = <8>;
                 power-supply = <&sw2_reg>;
                 status = "okay";
         };

	&pwm1 {
		#pwm-cells = <3>;
		pinctrl-names = "default", "pwm";
		pinctrl-0 = <&pinctrl_backlight_gpio>;
		pinctrl-1 = <&pinctrl_backlight_pwm>;
		pwm-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
		status = "disabled";
	};

	&iomuxc {
		pinctrl_backlight_gpio: pwm1grp-gpio {
			fsl,pins = <
				MX6QDL_PAD_GPIO_9__GPIO1_IO09   0x8
			>;
		};

		pinctrl_backlight_pwm: pwm1grp-pwm {
			fsl,pins = <
				MX6QDL_PAD_GPIO_9__PWM1_OUT     0x8
			>;
		};
	};

I think that for further effective discussion we need to wait for some
comments from PWM maintainers.

The main questions still remain:

- Is it acceptable to use pinctrl from the PWM driver in the first place?
- If so, is it acceptable to allow to use the approach where GPIO is used
   as the default state and we switch to "pwm" when needed? This produces
   the cleanest inverted PWM signal.
- If not, we will use the "gpio" state as the second optional one and use
   it when clients disable PWM.
- In both cases, can we rely on internal the pull-up facility or do we
   need to actively drive the pin?

Thank you for your time!
Michal
