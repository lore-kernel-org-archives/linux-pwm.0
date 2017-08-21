From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/9] Add STM32 LPTimer: PWM, trigger and counter
Date: Mon, 21 Aug 2017 08:24:33 +0100
Message-ID: <20170821072433.fvtezmsnrkuhnx6w@dell>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499445068-7037-1-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 07 Jul 2017, Fabrice Gasnier wrote:

> This series adds support for Low-Power Timer that can be found on
> some STM32 devices.
> 
> STM32 LPTimer (LPTIM) is a 16-bit timer that provides several
> functionalities. This series adds support for following features:
> - PWM output (with programmable prescaler, configurable polarity)
> - Trigger source for STM32 ADC or DAC (LPTIM_OUT)
> - Quadrature encoder and counter
> 
> The MFD core is used to manage common resources (clock, register map)
> and to detect encoder feature. "stm32_lptimer" structure is provided
> to its sub-nodes to share those information:
> - PWM driver is used to implement single PWM channel
> - IIO trigger
> - IIO quadrature encoder and counter
> 
> ---
> Changes in v3:
> - I sent this v3 with various changes, but still need to discuss ABI
>   for counter driver (no change on this in v3).
> - Remarks for Rob on dt-bindings
> - Add validate_device in Trigger driver
> - Update PWM driver after Thierry's comments
> - Additional patch for STM32 ADC trigger

Looks like you have everything you need.

Please apply all the Acks you've collected and [RESEND].

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
