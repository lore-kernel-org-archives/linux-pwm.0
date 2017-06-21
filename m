From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: Add STM32 LPTimer binding
Date: Wed, 21 Jun 2017 21:05:38 +0100
Message-ID: <20170621210538.568b0440@kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
        <1498055415-31513-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498055415-31513-2-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 21 Jun 2017 16:30:08 +0200
Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org> wrote:

> Add documentation for STMicroelectronics STM32 Low-Power Timer binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Looks sensible to me.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Changes in v2:
> - Lee's comments: s/Low Power/Low-Power/, remove 0x in example, improve
>   properties descriptions
> ---
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> new file mode 100644
> index 0000000..af859c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
> @@ -0,0 +1,48 @@
> +STMicroelectronics STM32 Low-Power Timer
> +
> +The STM32 Low-Power Timer (LPTIM) is a 16-bit timer that provides several
> +functions:
> +- PWM output (with programmable prescaler, configurable polarity)
> +- Quadrature encoder, counter
> +- Trigger source for STM32 ADC/DAC (LPTIM_OUT)
> +
> +Required properties:
> +- compatible:		Must be "st,stm32-lptimer".
> +- reg:			Offset and length of the device's register set.
> +- clocks:		Phandle to the clock used by the LP Timer module.
> +- clock-names:		Must be "mux".
> +- #address-cells:	Should be '<1>'.
> +- #size-cells:		Should be '<0>'.
> +
> +Optional subnodes:
> +- pwm:			See ../pwm/pwm-stm32-lp.txt
> +- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
> +- trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
> +
> +Example:
> +
> +	lptimer1: lptimer@40002400 {
> +		compatible = "st,stm32-lptimer";
> +		reg = <0x40002400 0x400>;
> +		clocks = <&timer_clk>;
> +		clock-names = "mux";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pwm {
> +			compatible = "st,stm32-pwm-lp";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lppwm1_pins>;
> +		};
> +
> +		trigger@0 {
> +			compatible = "st,stm32-lptimer-trigger";
> +			reg = <0>;
> +		};
> +
> +		counter {
> +			compatible = "st,stm32-lptimer-counter";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&lptim1_in_pins>;
> +		};
> +	};

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
