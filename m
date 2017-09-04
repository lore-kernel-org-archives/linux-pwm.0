From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v3 2/9] mfd: Add STM32 LPTimer driver
Date: Mon, 4 Sep 2017 14:46:20 +0100
Message-ID: <20170904134620.gdabswhptjbgweqk@dell>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
 <1503914654-19963-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1503914654-19963-3-git-send-email-fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
Cc: benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vilhelm.gray-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 28 Aug 2017, Fabrice Gasnier wrote:

> STM32 Low-Power Timer hardware block can be used for:
> - PWM generation
> - IIO trigger (in sync with PWM)
> - IIO quadrature encoder counter
> PWM and IIO timer configuration are mixed in the same registers so
> we need a multi fonction driver to be able to share those registers.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> ---
> Changes in v2:
> - Lee's remarks: various comments, max register define, s/Low Power/Low-Power,
>   clock name, removed reset, add kernel doc for stm32_lptimer struct
> ---
>  drivers/mfd/Kconfig               |  14 +++++
>  drivers/mfd/Makefile              |   1 +
>  drivers/mfd/stm32-lptimer.c       | 107 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/stm32-lptimer.h |  62 ++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/mfd/stm32-lptimer.c
>  create mode 100644 include/linux/mfd/stm32-lptimer.h

Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
