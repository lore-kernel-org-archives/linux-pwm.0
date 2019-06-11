From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm-backlight: Add 'max-brightness'
 property
Date: Tue, 11 Jun 2019 22:02:23 +0200
Message-ID: <00220cd7-ed4b-5250-d448-cf83ed4c2012@gmail.com>
References: <20190610233739.29477-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610233739.29477-1-mka@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pwm@vger.kernel.org

Hi Matthias,

On 6/11/19 1:37 AM, Matthias Kaehlcke wrote:
> Add an optional 'max-brightness' property, which is used to specify
> the number of brightness levels (max-brightness + 1) when the node
> has no 'brightness-levels' table.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   .../devicetree/bindings/leds/backlight/pwm-backlight.txt       | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 64fa2fbd98c9..98f4ba626054 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -27,6 +27,9 @@ Optional properties:
>                               resolution pwm duty cycle can be used without
>                               having to list out every possible value in the
>                               brightness-level array.
> +  - max-brightness: Maximum brightness value. Used to specify the number of
> +                    brightness levels (max-brightness + 1) when the node
> +                    has no 'brightness-levels' table.

In the LED subsystem we have led-max-microamp property which seems to
better describe hardware capabilities. It says just: this is the current
level the LED can withstand. max-brightness does not implicitly convey
this kind of information.

Why the need for the property at all? If for the reasons other than
hardware capabilities than it should be more likely handled
by userspace.

>   [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>   [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> 

-- 
Best regards,
Jacek Anaszewski
