From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Remove unneeded platform MODULE_ALIAS
Date: Thu, 20 Oct 2016 09:23:18 -0700
Message-ID: <7h8ttj7zwp.fsf@baylibre.com>
References: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476906599-14350-1-git-send-email-javier@osg.samsung.com>
        (Javier Martinez Canillas's message of "Wed, 19 Oct 2016 16:49:59
        -0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Javier Martinez Canillas <javier@osg.samsung.com> writes:

> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
>
> So there's no need to have a MODULE_ALIAS("platform:meson-pwm") since
> the reported uevent MODALIAS to user-space will always be the OF one.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
>
>  drivers/pwm/pwm-meson.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 381871b2bb46..5678092cad4b 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -523,7 +523,6 @@ static struct platform_driver meson_pwm_driver = {
>  };
>  module_platform_driver(meson_pwm_driver);
>  
> -MODULE_ALIAS("platform:meson-pwm");
>  MODULE_DESCRIPTION("Amlogic Meson PWM Generator driver");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
