From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Sun, 25 Nov 2018 21:56:12 +0100
Message-ID: <20181125205612.aownvgjnpxhqyxed@pengutronix.de>
References: <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
 <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
 <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
 <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello Michal,

On Fri, Nov 23, 2018 at 03:15:11PM +0000, Vokáč Michal wrote:
> On 22.11.2018 20:03, Uwe Kleine-König wrote:
> > On Thu, Nov 22, 2018 at 04:46:39PM +0000, Vokáč Michal wrote:
> >> On 22.11.2018 17:23, Uwe Kleine-König wrote:
> >>> So I'd expect this to really work on i.MX6 but not the earlier SoCs
> >>> without a gpio specifier.
> >>
> >> Maybe you would expect it to work but I already tested and measured
> >> that weeks ago ;) It did not work.
> > 
> > Which pin/gpio do we talk about? Which i.MX6 variant did you test this
> > on? (Assuming i.MX6D or i.MX6Q and PAD_DISP0_DATA09, did you try setting
> > 
> > 	IOMUXC_SW_MUX_CTL_PAD_DISP0_DATA09 (0x020E0194) = 0x00000005
> > 	IOMUXC_SW_PAD_CTL_PAD_DISP0_DATA09 (0x020E04A8) = 0x0000b080
> > 
> > and then play with GPIO 4.30 direction and output value?)
> 
> My test setup is as follows:
> - SoC is i.MX6DL or i.MX6S - I have three board variants in total.
> - Pin used for PWM/GPIO is PAD_GPIO9.
> - The pin is not connected to any circuit. Just a test point.
> - pinctrl setup in DT:
>    - for "pwm":
>      - fsl,pins = <MX6QDL_PAD_GPIO_9__PWM1_OUT 0x8>
>      - IOMUXC_SW_MUX_CTL_PAD_GPIO09 = 0x00000004
>      - IOMUXC_SW_PAD_CTL_PAD_GPIO09 = 0x00000008
> 
>    - for "gpio":
>     - fsl,pins = <MX6QDL_PAD_GPIO_9__GPIO1_IO09 0xb000>
>     - IOMUXC_SW_MUX_CTL_PAD_GPIO09 = 0x00000005
>     - IOMUXC_SW_PAD_CTL_PAD_GPIO09 = 0x0000b000

FTR: I suggested 0x0000b080 here, but 0x0000b000 is just fine.

> Test scenario:
> 
> - In bootloader configure the pin as GPIO output, set it LOW (0V).
>    I set it LOW to start in the oposite state than I want to end up in.
> - Boot Linux
> - Use sysfs to configure the PWM to produce some signal.
> - In the PWM driver select the "pwm" pinctrl state.
> - Measure the output - expected waveform on the scope.
> - Use sysfs to stop the PWM "echo 0 > /sys/class/pwm/pwmchip0/pwm0/enable°
> - In the PWM driver select the "gpio" pinctrl state.
> - Then in the PWM driver:
> 
> a) non-working variant
> - Do not request the GPIO - so do not touch its pad control reg.
>    It is set as output from the bootloader, data register = 0.
> - Measure voltage on the output
>    - against GND = 0V
>    - against VCC = 0V
> - Measure resistance against VCC: Hi-Z
> 
> The pin is in Hi-Z mode. That is fine but that does not satisfy any
> logic level.
> 
> b) working variant
> - Request the GPIO, configure it as input.
> - Measure voltage on the output
>    - against GND = VCC (3.3V)
>    - against VCC = 0V
> - Measure resistance against VCC = 91.1kOhm
> 
> The pull-up is active.

Thanks for your detailed test. So DSE = 0 doesn't work as I (and I think
Lothar) expected.

@Lothar: if Michal did something different than you expected, please
tell us with a few more details.

> I can repeat the results on both i.MX6DL and i.MX6S on pwm1 and pwm4.
> All pull-up and pull-down combinations gave me the expected results
> only if the pin is configured as input. So if I repeat the test and
> do not touch the pin in bootloader at all, it works as well even if
> I do not request/configure the GPIO in the PWM driver.

OK.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
