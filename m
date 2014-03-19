From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 10/16] avr32: MRMT: use generic leds_pwm driver
Date: Wed, 19 Mar 2014 15:19:24 +0100
Message-ID: <20140319141924.GB20872@samfundet.no>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-11-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1395234209-15546-11-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bryan Wu <cooloney@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Around Wed 19 Mar 2014 14:03:23 +0100 or thereabout, Alexandre Belloni wrote:
> Switch to the generic leds_pwm driver instead of leds-atmel-pwm.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

I do not have this add-on board either, so I can only provide compile tests
myself.

> ---
>  arch/avr32/boards/atngw100/mrmt.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
> index 1ba09e4c02b1..134e94c3d504 100644
> --- a/arch/avr32/boards/atngw100/mrmt.c
> +++ b/arch/avr32/boards/atngw100/mrmt.c
> @@ -17,6 +17,8 @@
>  #include <linux/types.h>
>  #include <linux/fb.h>
>  #include <linux/leds.h>
> +#include <linux/pwm.h>
> +#include <linux/leds_pwm.h>
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/atmel_serial.h>
> @@ -155,21 +157,29 @@ static struct platform_device rmt_ts_device = {
>  
>  #ifdef CONFIG_BOARD_MRMT_BL_PWM
>  /* PWM LEDs: LCD Backlight, etc */
> -static struct gpio_led rmt_pwm_led[] = {
> -	/* here the "gpio" is actually a PWM channel */
> -	{ .name = "backlight",	.gpio = PWM_CH_BL, },
> +static struct pwm_lookup pwm_lookup[] = {
> +	PWM_LOOKUP("at91sam9rl-pwm", PWM_CH_BL, "leds_pwm", "ds1"),
>  };
>  
> -static struct gpio_led_platform_data rmt_pwm_led_data = {
> -	.num_leds	= ARRAY_SIZE(rmt_pwm_led),
> -	.leds		= rmt_pwm_led,
> +static struct led_pwm pwm_leds[] = {
> +	{
> +		.name = "backlight",
> +		.max_brightness = 255,
> +		.pwm_period_ns  = 5000,
> +		.active_low = 1,
> +	},
> +};
> +
> +static struct led_pwm_platform_data pwm_data = {
> +	.num_leds       = ARRAY_SIZE(pwm_leds),
> +	.leds           = pwm_leds,
>  };
>  
> -static struct platform_device rmt_pwm_led_dev = {
> -	.name		= "leds-atmel-pwm",
> -	.id		= -1,
> -	.dev		= {
> -		.platform_data	= &rmt_pwm_led_data,
> +static struct platform_device leds_pwm = {
> +	.name   = "leds_pwm",
> +	.id     = -1,
> +	.dev    = {
> +		.platform_data = &pwm_data,
>  	},
>  };
>  #endif
> @@ -325,7 +335,8 @@ static int __init mrmt1_init(void)
>  #ifdef CONFIG_BOARD_MRMT_BL_PWM
>  	/* Use PWM for Backlight controls */
>  	at32_add_device_pwm(1 << PWM_CH_BL);
> -	platform_device_register(&rmt_pwm_led_dev);
> +	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
> +	platform_device_register(&leds_pwm);
>  #else
>  	/* Backlight always on */
>  	udelay( 1 );
-- 
mvh
Hans-Christian Egtvedt
