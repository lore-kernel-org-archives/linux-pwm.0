From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 04/12] clocksource/drivers/tcb_clksrc: stop depending on
 atmel_tclib
Date: Thu, 11 Apr 2019 18:19:34 +0200
Message-ID: <7ce7342d-7fa2-d2b0-621d-2c47a0e5cdba@linaro.org>
References: <20190403141120.32754-1-alexandre.belloni@bootlin.com>
 <20190403141120.32754-5-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403141120.32754-5-alexandre.belloni@bootlin.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexander Dahl <ada@thorsis.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 03/04/2019 16:11, Alexandre Belloni wrote:
> atmel_tclib is probed too late in the boot process to be able to use the
> TCB as the boot clocksource. This is an issue for SoCs without the PIT
> (sams70, samv70 and samv71 families) as they simply currently can't boot.
> 
> Get rid of the atmel_tclib dependency and probe everything on our own using
> the correct device tree binding.
> 
> This also allows getting rid of ATMEL_TCB_CLKSRC_BLOCK and makes the driver
> a bit more flexible as the TCB is not hardcoded in the kernel anymore.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/clocksource/tcb_clksrc.c | 103 +++++++++++++++++++------------
>  drivers/misc/Kconfig             |  14 +----
>  2 files changed, 66 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> index 138a12090149..c7eec9808289 100644
> --- a/drivers/clocksource/tcb_clksrc.c
> +++ b/drivers/clocksource/tcb_clksrc.c
> @@ -9,7 +9,8 @@
>  #include <linux/err.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> -#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/syscore_ops.h>
>  #include <soc/at91/atmel_tcb.h>
>  
> @@ -28,13 +29,6 @@
>   *     source, used in either periodic or oneshot mode.  This runs
>   *     at 32 KiHZ, and can handle delays of up to two seconds.
>   *
> - * A boot clocksource and clockevent source are also currently needed,
> - * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
> - * this code can be used when init_timers() is called, well before most
> - * devices are set up.  (Some low end AT91 parts, which can run uClinux,
> - * have only the timers in one TC block... they currently don't support
> - * the tclib code, because of that initialization issue.)
> - *
>   * REVISIT behavior during system suspend states... we should disable
>   * all clocks and save the power.  Easily done for clockevent devices,
>   * but clocksources won't necessarily get the needed notifications.
> @@ -112,7 +106,6 @@ void tc_clksrc_resume(struct clocksource *cs)
>  }
>  
>  static struct clocksource clksrc = {
> -	.name           = "tcb_clksrc",
>  	.rating         = 200,
>  	.read           = tc_get_cycles,
>  	.mask           = CLOCKSOURCE_MASK(32),
> @@ -214,7 +207,6 @@ static int tc_next_event(unsigned long delta, struct clock_event_device *d)
>  
>  static struct tc_clkevt_device clkevt = {
>  	.clkevt	= {
> -		.name			= "tc_clkevt",
>  		.features		= CLOCK_EVT_FEAT_PERIODIC |
>  					  CLOCK_EVT_FEAT_ONESHOT,
>  		/* Should be lower than at91rm9200's system timer */
> @@ -330,33 +322,64 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
>  	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
>  }
>  
> -static int __init tcb_clksrc_init(void)
> +static int __init tcb_clksrc_init(struct device_node *node)
>  {
> -	static char bootinfo[] __initdata
> -		= KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
> -
> -	struct platform_device *pdev;
> -	struct atmel_tc *tc;
> +	struct atmel_tc tc;
>  	struct clk *t0_clk;
> +	const struct of_device_id *match;
> +	int irq;
>  	u32 rate, divided_rate = 0;
>  	int best_divisor_idx = -1;
>  	int clk32k_divisor_idx = -1;
>  	int i;
>  	int ret;
>  
> -	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
> -	if (!tc) {
> -		pr_debug("can't alloc TC for clocksource\n");
> -		return -ENODEV;
> -	}
> -	tcaddr = tc->regs;
> -	pdev = tc->pdev;
> +	/* Protect against multiple calls */
> +	if (tcaddr)
> +		return 0;
> +
> +	tc.regs = of_iomap(node->parent, 0);
> +	if (!tc.regs)
> +		return -ENXIO;
> +
> +	t0_clk = of_clk_get_by_name(node->parent, "t0_clk");
> +	if (IS_ERR(t0_clk))
> +		return PTR_ERR(t0_clk);
> +
> +	tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
> +	if (IS_ERR(tc.slow_clk))
> +		return PTR_ERR(tc.slow_clk);
> +
> +	irq = of_irq_get(node->parent, 0);
> +	if (irq <= 0)
> +		return -EINVAL;
> +
> +	tc.clk[0] = t0_clk;
> +	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
> +	if (IS_ERR(tc.clk[1]))
> +		tc.clk[1] = t0_clk;
> +	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
> +	if (IS_ERR(tc.clk[2]))
> +		tc.clk[2] = t0_clk;
> +	tc.irq[0] = irq;
> +	tc.irq[1] = of_irq_get(node->parent, 1);
> +	if (tc.irq[1] <= 0)
> +		tc.irq[1] = irq;
> +	tc.irq[2] = of_irq_get(node->parent, 2);
> +	if (tc.irq[2] <= 0)
> +		tc.irq[2] = irq;

Why are clk[1/2] and irq[1/2] defaulting back to t0 in case of error?


[ ... ]



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
