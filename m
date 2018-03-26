From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Date: Mon, 26 Mar 2018 16:07:08 +0100
Message-ID: <20180326150708.jvjewhmk3j5a6vu7@holly.lan>
References: <20180326095213.18362-1-enric.balletbo@collabora.com>
 <20180326095213.18362-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180326095213.18362-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com
List-Id: linux-pwm@vger.kernel.org

On Mon, Mar 26, 2018 at 11:52:10AM +0200, Enric Balletbo i Serra wrote:
> Hardware needs a delay between setting an initial (non-zero) PWM and
> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> this delay in milli seconds. Hardware also needs a delay between disabing
> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> is this delay in milli seconds.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> Based on the original Huang Lin <hl@rock-chips.com> work.
> Changes since v5:
>  - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
>  - CC DT mainling list (for some reason dropped at some point, my
>    fault)
> Changes since v4:
>  - Rebase on top of mainline.
> Changes since v3:
>  - Replace us for ms.
>  - Add Acked-by: Pavel Machek <pavel@ucw.cz>
> Changes since v2:
>  - Use separate properties (Rob Herring)
> Changes since v1:
>  - As suggested by Daniel Thompson
>    - Do not assume power-on delay and power-off delay will be the same
> ---
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86d441a..310810906613 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,10 @@ Optional properties:
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                    and disables the backlight (see GPIO binding[1])
> +  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-zero) PWM
> +                          and enabling the backlight using GPIO.
> +  - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
> +                      and setting PWM value to 0.
>  
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -32,4 +36,6 @@ Example:
>  
>  		power-supply = <&vdd_bl_reg>;
>  		enable-gpios = <&gpio 58 0>;
> +		post-pwm-on-delay-ms = <10>;
> +		pwm-off-delay-ms = <10>;
>  	};
> -- 
> 2.16.2
> 
