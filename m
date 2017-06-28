From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
Date: Wed, 28 Jun 2017 11:44:04 -0500
Message-ID: <20170628164404.kr2fnr3mfumigkt5@rob-hp-laptop>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-2-git-send-email-fabrice.gasnier@st.com>
 <20170626180744.fyyzjsu4pmurohap@rob-hp-laptop>
 <a69a61c3-95a8-d0cc-10a6-4a7cf65ff2c5@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a69a61c3-95a8-d0cc-10a6-4a7cf65ff2c5-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 27, 2017 at 10:57:32AM +0200, Fabrice Gasnier wrote:
> On 06/26/2017 08:07 PM, Rob Herring wrote:
> > On Wed, Jun 21, 2017 at 04:30:08PM +0200, Fabrice Gasnier wrote:
> >> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
> >>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> >> ---
> >> Changes in v2:
> >> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
> >>   properties descriptions
> >> ---
> >>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> >> new file mode 100644
> >> index 0000000..af859c8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> >> @@ -0,0 +1,48 @@
> >> +STMicroelectronics STM32 Low-Power Timer
> >> +
> >> +The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
> >> +functions:
> >> +- PWM output (with programmable prescaler, configurable polarity)
> >> +- Quadrature encoder, counter
> >> +- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
> >> +
> >> +Required properties:
> >> +- compatible:		Must be "st,stm32-lptimer".
> >> +- reg:			Offset and length of the device's register set.
> >> +- clocks:		Phandle to the clock used by the LP Timer module.
> >> +- clock-names:		Must be "mux".
> >> +- #address-cells:	Should be '<1>'.
> >> +- #size-cells:		Should be '<0>'.
> >> +
> >> +Optional subnodes:
> >> +- pwm:			See ../pwm/pwm-stm32-lp.txt
> >> +- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
> >> +- trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
> >> +
> >> +Example:
> >> +
> >> +	lptimer1: lptimer@40002400 {
> > 
> > timer@...
> 
> Hi Rob,
> 
> I initially put "lptimer" here to distinguish Low-Power Timer hardware
> from other "timers" hardware that can be found also on stm32 devices.
> I'd prefer to keep it, is it sensible from your point of view ?
> Please advise.

Node names are supposed to be the class of device (e.g. ethernet, 
serial, etc.), not the specific device. The compatible is what 
distinguishes it from other timers.

> >> +		compatible = "st,stm32-lptimer";
> >> +		reg = <0x40002400 0x400>;
> >> +		clocks = <&timer_clk>;
> >> +		clock-names = "mux";
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		pwm {
> >> +			compatible = "st,stm32-pwm-lp";
> >> +			pinctrl-names = "default";
> >> +			pinctrl-0 = <&lppwm1_pins>;
> >> +		};
> >> +
> >> +		trigger@0 {
> >> +			compatible = "st,stm32-lptimer-trigger";
> >> +			reg = <0>;
> > 
> > Is there more than 1? 
> 
> reg identifies trigger hardware block.

Okay, the trigger patch needs to be reworded.

Rob
