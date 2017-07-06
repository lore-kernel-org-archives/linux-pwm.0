From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: pwm-backlight: add pwm-delay-us property
Date: Thu, 6 Jul 2017 12:07:35 -0500
Message-ID: <CAL_Jsq+xpdsqbreQpN6oTdr+X2cHNnJr8tVEzG+tgTvhZUka6g@mail.gmail.com>
References: <20170630112109.13785-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630112109.13785-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, huang lin <hl@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, Jun 30, 2017 at 6:21 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: huang lin <hl@rock-chips.com>
>
> Add a pwm-delay-us property to specify the delay between setting an
> initial (non-zero) PWM value and enabling the backlight, and also the
> delay between disabling the backlight and setting PWM value to 0.
>
> Signed-off-by: huang lin <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
>
> v1: https://lkml.org/lkml/2017/6/28/219
>
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..49b037e 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,11 @@ Optional properties:
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                    and disables the backlight (see GPIO binding[1])
> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
> +                  enabling the backlight, and also the delay between disabling
> +                  the backlight and setting PWM value to 0.
> +                  The 1st cell is the pre-delay in micro seconds.
> +                  The 2nd cell is the post-delay in micro seconds.

pre and post imply a time before and after a certain event, but these
are for 2 different events. These are more like an enable/on delay and
disable/off delay which probably should be separate properties. What
happens when we need the opposite sequence or a different sequence?
Maybe some panel requires the PWM to be 0 until some time after
enabling.

I don't understand why you even need a post delay. The PWM can be set
to 0 while enabled, right? So if the PWM is set to 0 while enabled and
then disable the backlight, then there's no delay. Plus this doesn't
make much sense to me electrically either. The PWM duty cycle is going
to be completely async to the enable line change. The PWM state could
go from 1 to 0 at any point in time relative to the enable line
change.

These issues are the problem with generic bindings. Adding 1 property
is no big deal, but then what happens with the next variation. These
timing constraints need to be able to be implied by the panel's
compatible.

Rob
