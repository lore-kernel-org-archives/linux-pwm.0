From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] pwm: meson: use generic compatibles
Date: Tue, 17 Oct 2017 17:09:20 -0500
Message-ID: <20171017220920.acjq6dr3ntf7xkid@rob-hp-laptop>
References: <20171013091642.31948-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013091642.31948-1-jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Oct 13, 2017 at 11:16:42AM +0200, Jerome Brunet wrote:
> The meson pwm driver seems to be compatible with more SoCs than
> initially thought. Let's use the most generic compatibles he have in
> DT instead of the gxbb specific ones
> 
> Signed-off-by: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-meson.txt |  6 +++---
>  drivers/pwm/pwm-meson.c                             | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> index 1ee81321c35e..439e05030553 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> @@ -3,8 +3,8 @@ Amlogic Meson PWM Controller
>  
>  Required properties:
>  - compatible: Shall contain "amlogic,meson8b-pwm"
> -                         or "amlogic,meson-gxbb-pwm"
> -                         or "amlogic,meson-gxbb-ao-pwm"
> +                         or "amlogic,meson-gx-pwm"
> +                         or "amlogic,meson-gx-ao-pwm"

I've already said the same on other patches, but so other 
maintainers see it, this seems like pointless, non-backwards compatible 
change.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
