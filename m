From: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Date: Mon, 24 Jul 2017 16:21:44 +0100
Message-ID: <61fbc94d-76d7-be7e-c0b3-30d27845434b@linaro.org>
References: <20170721104813.5389-1-enric.balletbo@collabora.com>
 <20170721104813.5389-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170721104813.5389-2-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On 21/07/17 11:48, Enric Balletbo i Serra wrote:
> Hardware needs a delay between setting an initial (non-zero) PWM and
> enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> this delay in milli seconds. Hardware also needs a delay between disabing
> the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> is this delay in milli seconds.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> ---
> Based on the original Huang Lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org> work.
> 
> Changes since v3:
>   - Replace us for ms.
>   - Add Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> Changes since v2:
>   - Use separate properties (Rob Herring)
> Changes since v1:
>   - As suggested by Daniel Thompson
>     - Do not assume power-on delay and power-off delay will be the same
> 
>   Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..3108109 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,10 @@ Optional properties:
>                  "pwms" property (see PWM binding[0])
>     - enable-gpios: contains a single GPIO specifier for the GPIO which enables
>                     and disables the backlight (see GPIO binding[1])
> +  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-zero) PWM
> +                          and enabling the backlight using GPIO.
> +  - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
> +                      and setting PWM value to 0.

Whilst it is strictly true that the delay you added to the driver is 
currently between disabling the backlight and setting PWM value to 0 I 
don't think the action should be described at this level of detail in 
the DT bindings.

The semantic action that is being performed is "stopping the PWM". This 
is currently implemented by setting the duty cycle to 0 and then calling 
disable but that could change (especially so since the current behavior 
looks asymmetric versus the enable sequence).


Daniel.


>   
>   [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>   [1]: Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -32,4 +36,6 @@ Example:
>   
>   		power-supply = <&vdd_bl_reg>;
>   		enable-gpios = <&gpio 58 0>;
> +		post-pwm-on-delay-ms = <10>;
> +		pwm-off-delay-ms = <10>;
>   	};
> 
