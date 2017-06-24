From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: Add STM32 LPTimer trigger
 binding
Date: Sat, 24 Jun 2017 21:10:42 +0100
Message-ID: <20170624211042.1f37f575@kernel.org>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
        <1498055415-31513-6-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498055415-31513-6-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 21 Jun 2017 16:30:12 +0200
Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org> wrote:

> Add documentation for STMicroelectronics STM32 Low-Power Timer Trigger
> binding.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
looks sensible to me.
I'm kind of assuming this whole series will end up going through Lee and MFD.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
> Changes in v2:
> - s/Low Power/Low-Power
> - remove leading 0x in example (parent node)
> - improve reg property description
> ---
>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
> new file mode 100644
> index 0000000..466d99f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
> @@ -0,0 +1,23 @@
> +STMicroelectronics STM32 Low-Power Timer Trigger
> +
> +STM32 Low-Power Timer provides trigger source (LPTIM output) that can be used
> +by STM32 internal ADC and/or DAC.
> +
> +Must be a sub-node of an STM32 Low-Power Timer device tree node.
> +See ../mfd/stm32-lptimer.txt for details about the parent node.
> +
> +Required properties:
> +- compatible:		Must be "st,stm32-lptimer-trigger".
> +- reg:			Selects trigger hardware block. Must be 0, 1 or 2
> +			respectively for lptimer1, lptimer2 or lptimer3
> +			trigger output.
> +
> +Example:
> +	lptimer1: lptimer@40002400 {
> +		compatible = "st,stm32-lptimer";
> +		...
> +		trigger@0 {
> +			compatible = "st,stm32-lptimer-trigger";
> +			reg = <0>;
> +		};
> +	};
