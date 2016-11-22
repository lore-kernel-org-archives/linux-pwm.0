From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
Date: Tue, 22 Nov 2016 17:53:18 +0100
Message-ID: <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479831207-32699-6-git-send-email-benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Gaignard <benjamin.gaignard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: fabrice.gasnier-qxv4g6HH51o@public.gmane.org, gerald.baeza-qxv4g6HH51o@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On 11/22/2016 05:13 PM, Benjamin Gaignard wrote:
> Define bindings for stm32 IIO timer
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
> ---
>  .../bindings/iio/timer/stm32-iio-timer.txt         | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> new file mode 100644
> index 0000000..b80025e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
> @@ -0,0 +1,33 @@
> +timer IIO trigger bindings for STM32
> +
> +Must be a child of STM32 multifunctions timer driver
> +
> +Required parameters:
> +- compatible: must be one of the follow value:
> +	"st,stm32-iio-timer1"
> +	"st,stm32-iio-timer2"
> +	"st,stm32-iio-timer3"
> +	"st,stm32-iio-timer4"
> +	"st,stm32-iio-timer5"
> +	"st,stm32-iio-timer6"
> +	"st,stm32-iio-timer7"
> +	"st,stm32-iio-timer8"
> +	"st,stm32-iio-timer9"
> +	"st,stm32-iio-timer10"
> +	"st,stm32-iio-timer11"
> +	"st,stm32-iio-timer12"
> +	"st,stm32-iio-timer13"
> +	"st,stm32-iio-timer14"

We can't do this. This is a binding for a driver, not for the hardware.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
