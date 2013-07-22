Return-Path: <daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
Message-ID: <51ECAE15.4000507@linaro.org>
Date: Mon, 22 Jul 2013 05:59:17 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 09/20] ARM: SAMSUNG: Move all platforms to new clocksource
 driver
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <1374278673-25615-11-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-11-git-send-email-tomasz.figa@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>

On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> This patch moves all Samsung platforms using PWM clocksource from legacy
> samsung-time to new samsung-pwm-timer driver.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  arch/arm/Kconfig                | 10 +++++-----
>  arch/arm/mach-s3c24xx/Kconfig   |  6 ------
>  arch/arm/mach-s3c24xx/common.c  | 16 ++++++++++++++++
>  arch/arm/mach-s3c64xx/Kconfig   |  2 --
>  arch/arm/mach-s3c64xx/common.c  | 21 +++++++++++++++++----
>  arch/arm/mach-s5p64x0/Kconfig   |  2 --
>  arch/arm/mach-s5p64x0/common.c  | 17 +++++++++++++++++
>  arch/arm/mach-s5pc100/Kconfig   |  1 -
>  arch/arm/mach-s5pc100/common.c  | 17 +++++++++++++++++
>  arch/arm/mach-s5pv210/Kconfig   |  1 -
>  arch/arm/mach-s5pv210/common.c  | 17 +++++++++++++++++
>  arch/arm/plat-samsung/s5p-irq.c |  3 ---
>  12 files changed, 89 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba412e0..486ab0a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -700,7 +700,7 @@ config ARCH_S3C24XX
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
> -	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
>  	select HAVE_CLK
> @@ -723,7 +723,7 @@ config ARCH_S3C64XX
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_VIC
>  	select CLKDEV_LOOKUP
> -	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V6
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
> @@ -748,7 +748,7 @@ config ARCH_S3C64XX
>  config ARCH_S5P64X0
>  	bool "Samsung S5P6440 S5P6450"
>  	select CLKDEV_LOOKUP
> -	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V6
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
> @@ -767,7 +767,7 @@ config ARCH_S5PC100
>  	bool "Samsung S5PC100"
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
> -	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
> @@ -787,7 +787,7 @@ config ARCH_S5PV210
>  	select ARCH_HAS_HOLES_MEMORYMODEL
>  	select ARCH_SPARSEMEM_ENABLE
>  	select CLKDEV_LOOKUP
> -	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select GPIO_SAMSUNG
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 6d9252e..b8ec0ec 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -30,7 +30,6 @@ config CPU_S3C2410
>  	select S3C2410_CLOCK
>  	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
>  	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
>  	select SAMSUNG_WDT_RESET
>  	help
>  	  Support for S3C2410 and S3C2410A family from the S3C24XX line
> @@ -42,7 +41,6 @@ config CPU_S3C2412
>  	select CPU_LLSERIAL_S3C2440
>  	select S3C2412_DMA if S3C24XX_DMA
>  	select S3C2412_PM if PM
> -	select SAMSUNG_HRT
>  	help
>  	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
>  
> @@ -54,7 +52,6 @@ config CPU_S3C2416
>  	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
>  	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
>  	help
>  	  Support for the S3C2416 SoC from the S3C24XX line
>  
> @@ -65,7 +62,6 @@ config CPU_S3C2440
>  	select S3C2410_CLOCK
>  	select S3C2410_PM if PM
>  	select S3C2440_DMA if S3C24XX_DMA
> -	select SAMSUNG_HRT
>  	help
>  	  Support for S3C2440 Samsung Mobile CPU based systems.
>  
> @@ -75,7 +71,6 @@ config CPU_S3C2442
>  	select CPU_LLSERIAL_S3C2440
>  	select S3C2410_CLOCK
>  	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
>  	help
>  	  Support for S3C2442 Samsung Mobile CPU based systems.
>  
> @@ -91,7 +86,6 @@ config CPU_S3C2443
>  	select S3C2443_COMMON
>  	select S3C2443_DMA if S3C24XX_DMA
>  	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
>  	help
>  	  Support for the S3C2443 SoC from the S3C24XX line
>  
> diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
> index e5e7d7d..457261c 100644
> --- a/arch/arm/mach-s3c24xx/common.c
> +++ b/arch/arm/mach-s3c24xx/common.c
> @@ -245,6 +245,22 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
>  	samsung_pwm_set_platdata(&s3c24xx_pwm_variant);
>  }
>  
> +void __init samsung_set_timer_source(unsigned int event, unsigned int source)
> +{
> +	s3c24xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
> +	s3c24xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
> +}
> +
> +void __init samsung_timer_init(void)
> +{
> +	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
> +		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2, IRQ_TIMER3, IRQ_TIMER4,
> +	};
> +
> +	samsung_pwm_clocksource_init(S3C_VA_TIMER,
> +					timer_irqs, &s3c24xx_pwm_variant);
> +}
> +
>  /* Serial port registrations */
>  
>  #define S3C2410_PA_UART0      (S3C24XX_PA_UART)
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 2057853..041da51 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -17,13 +17,11 @@ config PLAT_S3C64XX
>  # Configuration options for the S3C6410 CPU
>  
>  config CPU_S3C6400
> -	select SAMSUNG_HRT
>  	bool
>  	help
>  	  Enable S3C6400 CPU support
>  
>  config CPU_S3C6410
> -	select SAMSUNG_HRT
>  	bool
>  	help
>  	  Enable S3C6410 CPU support
> diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
> index ca05e61..73d79cf 100644
> --- a/arch/arm/mach-s3c64xx/common.c
> +++ b/arch/arm/mach-s3c64xx/common.c
> @@ -43,7 +43,6 @@
>  #include <plat/pm.h>
>  #include <plat/gpio-cfg.h>
>  #include <plat/irq-uart.h>
> -#include <plat/irq-vic-timer.h>
>  #include <plat/pwm-core.h>
>  #include <plat/regs-irqtype.h>
>  #include <plat/regs-serial.h>
> @@ -158,6 +157,23 @@ static struct samsung_pwm_variant s3c64xx_pwm_variant = {
>  	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
>  };
>  
> +void __init samsung_set_timer_source(unsigned int event, unsigned int source)
> +{
> +	s3c64xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
> +	s3c64xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
> +}
> +
> +void __init samsung_timer_init(void)
> +{
> +	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
> +		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
> +		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
> +	};
> +
> +	samsung_pwm_clocksource_init(S3C_VA_TIMER,
> +					timer_irqs, &s3c64xx_pwm_variant);
> +}
> +
>  /* read cpu identification code */
>  
>  void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
> @@ -206,9 +222,6 @@ void __init s3c64xx_init_irq(u32 vic0_valid, u32 vic1_valid)
>  	/* initialise the pair of VICs */
>  	vic_init(VA_VIC0, IRQ_VIC0_BASE, vic0_valid, IRQ_VIC0_RESUME);
>  	vic_init(VA_VIC1, IRQ_VIC1_BASE, vic1_valid, IRQ_VIC1_RESUME);
> -
> -	/* add the timer sub-irqs */
> -	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
>  }
>  
>  #define eint_offset(irq)	((irq) - IRQ_EINT(0))
> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
> index 5a707bd..bb2111b 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -11,14 +11,12 @@ config CPU_S5P6440
>  	bool
>  	select S5P_SLEEP if PM
>  	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>  	select SAMSUNG_WAKEMASK if PM
>  	help
>  	  Enable S5P6440 CPU support
>  
>  config CPU_S5P6450
>  	bool
> -	select SAMSUNG_HRT
>  	select S5P_SLEEP if PM
>  	select SAMSUNG_DMADEV
>  	select SAMSUNG_WAKEMASK if PM
> diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
> index 49687f2..42e14f2 100644
> --- a/arch/arm/mach-s5p64x0/common.c
> +++ b/arch/arm/mach-s5p64x0/common.c
> @@ -166,6 +166,23 @@ static struct samsung_pwm_variant s5p64x0_pwm_variant = {
>  	.tclk_mask	= 0,
>  };
>  
> +void __init samsung_set_timer_source(unsigned int event, unsigned int source)
> +{
> +	s5p64x0_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
> +	s5p64x0_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
> +}
> +
> +void __init samsung_timer_init(void)
> +{
> +	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
> +		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
> +		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
> +	};
> +
> +	samsung_pwm_clocksource_init(S3C_VA_TIMER,
> +					timer_irqs, &s5p64x0_pwm_variant);
> +}
> +
>  /*
>   * s5p64x0_map_io
>   *
> diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
> index 2f456a4..15170be 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -11,7 +11,6 @@ config CPU_S5PC100
>  	bool
>  	select S5P_EXT_INT
>  	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>  	help
>  	  Enable S5PC100 CPU support
>  
> diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
> index e0600af..c5a8eea 100644
> --- a/arch/arm/mach-s5pc100/common.c
> +++ b/arch/arm/mach-s5pc100/common.c
> @@ -141,6 +141,23 @@ static struct samsung_pwm_variant s5pc100_pwm_variant = {
>  	.tclk_mask	= (1 << 5),
>  };
>  
> +void __init samsung_set_timer_source(unsigned int event, unsigned int source)
> +{
> +	s5pc100_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
> +	s5pc100_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
> +}
> +
> +void __init samsung_timer_init(void)
> +{
> +	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
> +		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
> +		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
> +	};
> +
> +	samsung_pwm_clocksource_init(S3C_VA_TIMER,
> +					timer_irqs, &s5pc100_pwm_variant);
> +}
> +
>  /*
>   * s5pc100_map_io
>   *
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 0963283..caaedaf 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -15,7 +15,6 @@ config CPU_S5PV210
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
>  	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>  	help
>  	  Enable S5PV210 CPU support
>  
> diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
> index 306b29a..26027a2 100644
> --- a/arch/arm/mach-s5pv210/common.c
> +++ b/arch/arm/mach-s5pv210/common.c
> @@ -157,6 +157,23 @@ static struct samsung_pwm_variant s5pv210_pwm_variant = {
>  	.tclk_mask	= (1 << 5),
>  };
>  
> +void __init samsung_set_timer_source(unsigned int event, unsigned int source)
> +{
> +	s5pv210_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
> +	s5pv210_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
> +}
> +
> +void __init samsung_timer_init(void)
> +{
> +	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
> +		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
> +		IRQ_TIMER3_VIC, IRQ_TIMER4_VIC,
> +	};
> +
> +	samsung_pwm_clocksource_init(S3C_VA_TIMER,
> +					timer_irqs, &s5pv210_pwm_variant);
> +}
> +
>  /*
>   * s5pv210_map_io
>   *
> diff --git a/arch/arm/plat-samsung/s5p-irq.c b/arch/arm/plat-samsung/s5p-irq.c
> index ff1a760..6729cb2 100644
> --- a/arch/arm/plat-samsung/s5p-irq.c
> +++ b/arch/arm/plat-samsung/s5p-irq.c
> @@ -19,7 +19,6 @@
>  #include <mach/map.h>
>  #include <plat/regs-timer.h>
>  #include <plat/cpu.h>
> -#include <plat/irq-vic-timer.h>
>  
>  void __init s5p_init_irq(u32 *vic, u32 num_vic)
>  {
> @@ -30,6 +29,4 @@ void __init s5p_init_irq(u32 *vic, u32 num_vic)
>  	for (irq = 0; irq < num_vic; irq++)
>  		vic_init(VA_VIC(irq), VIC_BASE(irq), vic[irq], 0);
>  #endif
> -
> -	s3c_init_vic_timer_irq(5, IRQ_TIMER0);
>  }
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
