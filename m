From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 5/7] IIO: add bindings for stm32 timer trigger driver
Date: Fri, 2 Dec 2016 13:59:04 +0000
Message-ID: <20161202135904.GN2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480673842-20804-6-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 02 Dec 2016, Benjamin Gaignard wrote:

> Define bindings for stm32 timer trigger
> 
> version 3:
> - change file name
> - add cross reference with mfd bindings
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> new file mode 100644
> index 0000000..858816d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> @@ -0,0 +1,39 @@
> +timer trigger bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
> +
> +Required parameters:
> +- compatible:		must be "st,stm32-iio-timer"
> +- interrupts:		Interrupt for this device
> +			See ../interrupt-controller/st,stm32-exti.txt
> +
> +Optional parameters:
> +- st,input-triggers-names:	List of the possible input triggers for
> +				the device
> +- st,output-triggers-names:	List of the possible output triggers for
> +				the device
> +
> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-timer-trigger.h
> +
> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		timer1@0 {
> +			compatible = "st,stm32-timer-trigger";
> +			interrupts = <27>;
> +			st,input-triggers-names = TIM5_TRGO,
> +						  TIM2_TRGO,
> +						  TIM4_TRGO,
> +						  TIM3_TRGO;
> +			st,output-triggers-names = TIM1_TRGO,
> +						   TIM1_CH1,
> +						   TIM1_CH2,
> +						   TIM1_CH3,
> +						   TIM1_CH4;

I see why you've done it like this now ... because it makes things
easier for you in the driver, since the IIO subsystem matches on names
such as these.

BUT, this is a Linux-implementation-ism.  Just use pairs of integers
and create the Linux-ism strings in the driver.

> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
