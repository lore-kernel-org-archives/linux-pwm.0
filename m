From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Date: Wed, 22 Aug 2018 13:17:58 +0200
Message-ID: <20180822131758.162d5351@ipc1.ka-ro>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
        <20180822081436.13d8f55b@ipc1.ka-ro>
        <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Michal Vokáč <michal.vokac@ysoft.com> wrote:

> On 22.8.2018 08:14, Lothar Waßmann wrote:
> > Michal Vokáč <michal.vokac@ysoft.com> wrote:
> >   
> >> Output of the PWM block of i.MX SoCs is always zero volts when the block
> >> is disabled. This can caue issues when inverted PWM polarity is needed.
> >> With inverted polarity a duty cycle = 0% corresponds to solid high level
> >> on the output. If the PWM is dissabled its output instantly goes to solid
> >> zero which corresponds to duty cycle = 100%.
> >>
> >> To have a trully inverted PWM output configure the PWM pad as a GPIO
> >> with pull-up. Then switch the pad to PWM output whenever non-zero
> >> duty cycle is needed.
> >>
> >> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> >> ---
> >>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
> >>   1 file changed, 44 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >> index c61bdf8..3b1bc4c 100644
> >> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
> >> @@ -14,6 +14,12 @@ See the clock consumer binding,
> >>   	Documentation/devicetree/bindings/clock/clock-bindings.txt
> >>   - interrupts: The interrupt for the pwm controller
> >>   
> >> +Optional properties:
> >> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
> >> +  pin to gpio function.  It allows control over the pin output level when the
> >> +  PWM block is disabled. This is meant to be used if inverted polarity of the
> >> +  PWM signal is required. See "Inverted PWM output" section bellow.
> >> +
> >>   Example:
> >>   
> >>   pwm1: pwm@53fb4000 {
> >> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
> >>   	clock-names = "ipg", "per";
> >>   	interrupts = <61>;
> >>   };
> >> +
> >> +Inverted PWM output
> >> +-------------------
> >> +
> >> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
> >> +output, the output level is always zero volts when the PWM block is disabled.
> >> +The zero output level is actively driven by the output stage of the PWM block
> >> +and can not be overridden by pull-up. It also does not matter what PWM polarity
> >> +a PWM client (e.g. backlight) requested.
> >> +
> >> +To gain control of the PWM output level in disabled state two pinctrl states
> >> +can be used. The "default" state and the "pwm" state. In the default state the
> >>  
> > The "default" function of a PWM is to deliver a PWM signal. So it is
> > more sensible to me to have the PWM function as "default" and a "gpio"
> > function as alternative state.  
> 
> Yes, I totally agree that using "default" for PWM and "gpio" as the
> alternative function seems more sensible. That is actually how I started.
> Then I realized that that way you end up with the PWM pad set to zero
> until the first call of imx_pwm_apply_v2 where you can select the GPIO
> function. On my system that first call is made by pwm-backlight more than
> 3s after pinctrl init.
> 
> I suggested to use the "default" state as a GPIO function as the only way
> how to get a truly inverted PWM output all the time from power-up to
> power-down.
> 
> In my opinion it is up to the DT author what pad configuration he uses for
> each pinctrl function as he knows what the HW really needs. I see that this
> approach is kind of controversial but I hope that with good documentation
> this would not be a problem. And as I wrote in the intro, it is absolutely
> optional. If you do not need it, you do not use it.
> 
This is OK so far.
But the approach with the pin being driven high via the pullup
configuration has a fundamental flaw:
The pwm polarity is specified by the PWM client (e.g: the pwm-backlight
driver:
	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
)
The pinconfig is defined in the pinctrl of the PWM driver.

If you have clients that may use the same PWM instance and require
different polarity, there is no way to set the pullup/-down
configuration in accordance with the clients needs.

IMO the PWM driver should actively set the pin to the 'INACTIVE' state
according to the polarity specified by the current client using the PWM.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
