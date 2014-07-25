From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2] pwm-backlight: fix probing from device-tree without enable-gpios
Date: Fri, 25 Jul 2014 23:46:51 +0900
Message-ID: <CAAVeFu+Gaabwt_3GB8VQRyOYPKsOjCkCDEYnSet3UaQztnb+Bg@mail.gmail.com>
References: <1406284115-489-1-git-send-email-m.olbrich@pengutronix.de> <1406288841-23140-1-git-send-email-m.olbrich@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406288841-23140-1-git-send-email-m.olbrich@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Olbrich <m.olbrich@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jul 25, 2014 at 8:47 PM, Michael Olbrich
<m.olbrich@pengutronix.de> wrote:
> Since 257462dbf3ed ("pwm-backlight: switch to gpiod interface")
> enable_gpio is no longer set and remains 0 when probing from
> device-tree. This is a valid gpio number. With no enable-gpios
> specified in the device-tree this is used and probing fails
> with:
>
> pwm-backlight lcd-backlight.3: failed to request GPIO#0: -16
>
> Fix this by setting enable_gpio to -1 which is not a valid gpio
> number.

Looks good indeed. My bad for overlooking this.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>

>
> Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
> ---
>
> Sorry, I sent the wrong version. This one actually compiles.
>
> Michael
>
>  drivers/video/backlight/pwm_bl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 38ca88b..e7e43cd 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -211,6 +211,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>                         dev_err(&pdev->dev, "failed to find platform data\n");
>                         return ret;
>                 }
> +               defdata.enable_gpio = -1;
>
>                 data = &defdata;
>         }
> --
> 2.0.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
