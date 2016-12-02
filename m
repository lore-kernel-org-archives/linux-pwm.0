From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
Date: Fri, 2 Dec 2016 14:23:02 +0000
Message-ID: <20161202142302.GO2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480673842-20804-4-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 02 Dec 2016, Benjamin Gaignard wrote:

> Define bindings for pwm-stm32
> 
> version 2:
> - use parameters instead of compatible of handle the hardware configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> new file mode 100644
> index 0000000..575b9fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> @@ -0,0 +1,38 @@
> +STMicroelectronics PWM driver bindings for STM32
> +
> +Must be a sub-node of STM32 general purpose timer driver
> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
> +
> +Required parameters:
> +- compatible:		Must be "st,stm32-pwm"
> +- pinctrl-names: 	Set to "default".
> +- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> +			for PWM module.
> +			For Pinctrl properties, please refer to [1].
> +
> +Optional parameters:
> +- st,breakinput:	Set if the hardware have break input capabilities
> +- st,breakinput-polarity: Set break input polarity. Default is 0
> +			 The value define the active polarity:
> +			  - 0 (active LOW)
> +			  - 1 (active HIGH)

> +- st,breakinput-polarity-high

Then assume the default if the property is not present.

> +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.

What's the point in having a PWM device with  no channels?

Best to make this a compulsory property.

> +- st,32bits-counter:	Set if the hardware have a 32 bits counter
> +- st,complementary:	Set if the hardware have complementary output channels
> +
> +[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

Use relative path.

../pinctrl/pinctrl-bindings.txt

> +Example:
> +	gptimer1: gptimer1@40010000 {
> +		compatible = "st,stm32-gptimer";
> +		reg = <0x40010000 0x400>;
> +		clocks = <&rcc 0 160>;
> +		clock-names = "clk_int";
> +
> +		pwm1@0 {

Don't number the node name.

pwm@xx

> +			compatible = "st,stm32-pwm";
> +			st,pwm-num-chan = <4>;
> +			st,breakinput;
> +			st,complementary;
> +		};
> +	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
