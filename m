From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add pwm-delay-us property
Date: Wed, 28 Jun 2017 15:30:04 +0200
Message-ID: <20170628133004.GA3507@localhost>
References: <20170628111632.22582-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54012 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdF1NaM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Jun 2017 09:30:12 -0400
Content-Disposition: inline
In-Reply-To: <20170628111632.22582-1-enric.balletbo@collabora.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Rob Herring <robh+dt@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, groeck@chromium.org, huang lin <hl@rock-chips.com>

On Wed 2017-06-28 13:16:31, Enric Balletbo i Serra wrote:
> From: huang lin <hl@rock-chips.com>
> 
> Add a pwm-delay-us property to specify the delay between setting an
> initial (non-zero) PWM value and enabling the backlight, and also the
> delay between disabling the backlight and setting PWM value to 0.



> Signed-off-by: huang lin <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..f75b08f 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,9 @@ Optional properties:
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                    and disables the backlight (see GPIO binding[1])
> +  - pwm-delay-us: delay between setting an initial (non-zero) PWM value and
> +                  enabling the backlight, and also the delay between disabling
> +                  the backlight and setting PWM value to 0.
>

I understood it as "you set PWM and it takes a while for display to
light up"
but that's not correct. Changelog from second patch makes it
clear. Please
clarify it here, too.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
