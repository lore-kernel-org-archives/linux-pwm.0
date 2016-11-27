From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/7] IIO: add bindings for stm32 IIO timer driver
Date: Sun, 27 Nov 2016 14:25:46 +0000
Message-ID: <b2002a81-49fe-af2a-f13a-9f09831aa530@kernel.org>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-6-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480000463-9625-6-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On 24/11/16 15:14, Benjamin Gaignard wrote:
> Define bindings for stm32 IIO timer
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> ---
>  .../bindings/iio/timer/stm32-iio-timer.txt         | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> new file mode 100644
> index 0000000..840b417
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> @@ -0,0 +1,41 @@
> +timer IIO trigger bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
Add a cross reference...
> +
> +Required parameters:
> +- compatible:		must be "st,stm32-iio-timer"
st,stm32-adc-timer or something like that.
> +- interrupts:		Interrupt for this device
> +			See ../interrupt-controller/st,stm32-exti.txt
> +
> +Optional parameters:
> +- st,input-triggers-names:	List of the possible input triggers for
> +				the device
> +- st,output-triggers-names:	List of the possible output triggers for
> +				the device
What are input / output triggers?
> +
> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-iio-timer.h
> +
> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1@0 {
> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +
> +		iiotimer1@0 {
> +			compatible = "st,stm32-iio-timer";
> +			interrupts = <27>;
> +			st,input-triggers-names = TIM5_TRGO,
> +						  TIM2_TRGO,
> +						  TIM4_TRGO,
> +						  TIM3_TRGO;
> +			st,output-triggers-names = TIM1_TRGO;
> +		};
> +	};
> 
