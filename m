From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 03/12] misc: atmel_tclib: move definitions to header file
Date: Thu, 11 Apr 2019 17:00:26 +0200
Message-ID: <63e25c2f-2e10-9c6e-9bfa-7b7220377bd8@linaro.org>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-4-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-4-alexandre.belloni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 03/04/2019 16:11, Alexandre Belloni wrote:
> Move atmel_tc_divisors and atmel_tcb_dt_ids definitions to the header file
> so they can be used without using tclib.

Why not kill those structure and use the TIMER_OF_DECLARE with the
corresponding probe function which will initialize to 16 or 32 counter
width?



> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/misc/atmel_tclib.c   | 24 ------------------------
>  include/soc/at91/atmel_tcb.h | 21 ++++++++++++++++++++-
>  2 files changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
> index 3af27ce7e514..c79190525862 100644
> --- a/drivers/misc/atmel_tclib.c
> +++ b/drivers/misc/atmel_tclib.c
> @@ -17,10 +17,6 @@
>   * share individual timers between different drivers.
>   */
>  
> -/* AT91 has these divide MCK */
> -const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> -EXPORT_SYMBOL(atmel_tc_divisors);
> -
>  static DEFINE_SPINLOCK(tc_list_lock);
>  static LIST_HEAD(tc_list);
>  
> @@ -72,26 +68,6 @@ void atmel_tc_free(struct atmel_tc *tc)
>  EXPORT_SYMBOL_GPL(atmel_tc_free);
>  
>  #if defined(CONFIG_OF)
> -static struct atmel_tcb_config tcb_rm9200_config = {
> -	.counter_width = 16,
> -};
> -
> -static struct atmel_tcb_config tcb_sam9x5_config = {
> -	.counter_width = 32,
> -};
> -
> -static const struct of_device_id atmel_tcb_dt_ids[] = {
> -	{
> -		.compatible = "atmel,at91rm9200-tcb",
> -		.data = &tcb_rm9200_config,
> -	}, {
> -		.compatible = "atmel,at91sam9x5-tcb",
> -		.data = &tcb_sam9x5_config,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -
>  MODULE_DEVICE_TABLE(of, atmel_tcb_dt_ids);
>  #endif
>  
> diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> index c3c7200ce151..cb0c5f53cd46 100644
> --- a/include/soc/at91/atmel_tcb.h
> +++ b/include/soc/at91/atmel_tcb.h
> @@ -76,8 +76,27 @@ extern struct atmel_tc *atmel_tc_alloc(unsigned block);
>  extern void atmel_tc_free(struct atmel_tc *tc);
>  
>  /* platform-specific ATMEL_TC_TIMER_CLOCKx divisors (0 means 32KiHz) */
> -extern const u8 atmel_tc_divisors[5];
> +static const u8 atmel_tc_divisors[] = { 2, 8, 32, 128, 0, };
>  
> +static const struct atmel_tcb_config tcb_rm9200_config = {
> +	.counter_width = 16,
> +};
> +
> +static const struct atmel_tcb_config tcb_sam9x5_config = {
> +	.counter_width = 32,
> +};
> +
> +static const struct of_device_id atmel_tcb_dt_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-tcb",
> +		.data = &tcb_rm9200_config,
> +	}, {
> +		.compatible = "atmel,at91sam9x5-tcb",
> +		.data = &tcb_sam9x5_config,
> +	}, {
> +		/* sentinel */
> +	}
> +};
>  
>  /*
>   * Two registers have block-wide controls.  These are: configuring the three
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
