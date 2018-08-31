From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Fri, 31 Aug 2018 08:18:09 -0400
Message-ID: <20180831121809.GA22507@bogus>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Tue, Aug 21, 2018 at 04:38:52PM +0200, Michal Vokáč wrote:
> Output of the PWM block of i.MX SoCs is always zero volts when the block
> is disabled. This can caue issues when inverted PWM polarity is needed.
> With inverted polarity a duty cycle = 0% corresponds to solid high level
> on the output. If the PWM is dissabled its output instantly goes to solid
> zero which corresponds to duty cycle = 100%.
> 
> To have a trully inverted PWM output configure the PWM pad as a GPIO
> with pull-up. Then switch the pad to PWM output whenever non-zero
> duty cycle is needed.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> index c61bdf8..3b1bc4c 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> @@ -14,6 +14,12 @@ See the clock consumer binding,
>  	Documentation/devicetree/bindings/clock/clock-bindings.txt
>  - interrupts: The interrupt for the pwm controller
>  
> +Optional properties:
> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
> +  pin to gpio function.  It allows control over the pin output level when the
> +  PWM block is disabled. This is meant to be used if inverted polarity of the
> +  PWM signal is required. See "Inverted PWM output" section bellow.
> +
>  Example:
>  
>  pwm1: pwm@53fb4000 {
> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>  	clock-names = "ipg", "per";
>  	interrupts = <61>;
>  };
> +
> +Inverted PWM output
> +-------------------
> +
> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
> +output, the output level is always zero volts when the PWM block is disabled.
> +The zero output level is actively driven by the output stage of the PWM block
> +and can not be overridden by pull-up. It also does not matter what PWM polarity
> +a PWM client (e.g. backlight) requested.
> +
> +To gain control of the PWM output level in disabled state two pinctrl states
> +can be used. The "default" state and the "pwm" state. In the default state the
> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
> +is configured as a PWM output. This setup assures that the PWM output is at
> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
> +E.g. at boot.
> +
> +Example:
> +
> +&pwm1 {
> +	pinctrl-names = "default", "pwm";
> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
> +}
> +
> +pinctrl_backlight_gpio: pwm1grp-gpio {
> +	fsl,pins = <
> +		/* GPIO with 22kOhm pull-up */
> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008

There's a slight problem here if I remember the i.MX pin muxing. In GPIO 
mode, doesn't the GPIO block control the direction and level if an 
output. I guess as long as unused GPIOs are all initialized to inputs it 
will be okay.

Rob
