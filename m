From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add pwm-delay-us property
Date: Wed, 28 Jun 2017 14:16:58 +0100
Message-ID: <0a52509d-3420-1820-b8fb-9e13f45bc02c@linaro.org>
References: <20170628111632.22582-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35070 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdF1NRE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Jun 2017 09:17:04 -0400
Received: by mail-wm0-f48.google.com with SMTP id w126so53079276wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jun 2017 06:17:03 -0700 (PDT)
In-Reply-To: <20170628111632.22582-1-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, huang lin <hl@rock-chips.com>

On 28/06/17 12:16, Enric Balletbo i Serra wrote:
> From: huang lin <hl@rock-chips.com>
> 
> Add a pwm-delay-us property to specify the delay between setting an
> initial (non-zero) PWM value and enabling the backlight, and also the
> delay between disabling the backlight and setting PWM value to 0.
> 
> Signed-off-by: huang lin <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>   Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..f75b08f 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,9 @@ Optional properties:
>                  "pwms" property (see PWM binding[0])
>     - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                     and disables the backlight (see GPIO binding[1])
> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
> +                  enabling the backlight, and also the delay between disabling
> +                  the backlight and setting PWM value to 0.

If is safe to assume power-on delay and power-off delay will be the same?

I've only took a quick look but several backlight controllers support 
asymetric power-on/off sequences...


Daniel.


>   
>   [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>   [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -32,4 +35,5 @@ Example:
>   
>   		power-supply = <&vdd_bl_reg>;
>   		enable-gpios = <&gpio 58 0>;
> +		pwm-delay-us = <10000>;
>   	};
> 
