Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 07/18] ARM: SAMSUNG: Move all platforms to new clocksource driver
Date: Mon, 24 Jun 2013 17:49:01 +0200
Message-ID: <1526371.oK01FDVHb7@flatron>
In-Reply-To: <51C869BE.3020800@samsung.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <1446181.qPbsJvieFG@flatron> <51C869BE.3020800@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Olof Johansson <olof@lixom.net>, Thierry Reding <thierry.reding@gmail.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tuesday 25 of June 2013 00:46:06 Kukjin Kim wrote:
> On 06/25/13 00:38, Tomasz Figa wrote:
> 
> [...]
> 
> >>> -	select SAMSUNG_HRT
> >>> +	select CLKSRC_SAMSUNG_PWM
> >> 
> >> Please put this in alphabetical ordering, this is just replacing
> >> though.> 
> > Argh, I always forget about this ordering, sorry.
> 
> no problem ;-)
> 
> [...]
> 
> >> Let me fix it...
> 
> like following :-)
> 
> 8<----------------------------------------------
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 49d993c..734d85b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -694,6 +694,7 @@ config ARCH_S3C24XX
>   	select ARCH_REQUIRE_GPIOLIB
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>   	select GENERIC_CLOCKEVENTS
>   	select HAVE_CLK
>   	select HAVE_S3C2410_I2C if I2C
> @@ -715,6 +716,7 @@ config ARCH_S3C64XX
>   	select ARM_VIC
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>   	select CPU_V6
>   	select GENERIC_CLOCKEVENTS
>   	select HAVE_CLK
> @@ -737,6 +739,7 @@ config ARCH_S5P64X0
>   	bool "Samsung S5P6440 S5P6450"
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>   	select CPU_V6
>   	select GENERIC_CLOCKEVENTS
>   	select HAVE_CLK
> @@ -753,6 +756,7 @@ config ARCH_S5PC100
>   	select ARCH_REQUIRE_GPIOLIB
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>   	select CPU_V7
>   	select GENERIC_CLOCKEVENTS
>   	select HAVE_CLK
> @@ -770,6 +774,7 @@ config ARCH_S5PV210
>   	select ARCH_SPARSEMEM_ENABLE
>   	select CLKDEV_LOOKUP
>   	select CLKSRC_MMIO
> +	select CLKSRC_SAMSUNG_PWM
>   	select CPU_V7
>   	select GENERIC_CLOCKEVENTS
>   	select HAVE_CLK
> diff --git a/arch/arm/mach-s3c24xx/Kconfig
> b/arch/arm/mach-s3c24xx/Kconfig index f2f7088..8124ec7 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -30,7 +30,6 @@ config CPU_S3C2410
>   	select S3C2410_CLOCK
>   	select S3C2410_CPUFREQ if CPU_FREQ_S3C24XX
>   	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
>   	help
>   	  Support for S3C2410 and S3C2410A family from the S3C24XX line
>   	  of Samsung Mobile CPUs.
> @@ -41,7 +40,6 @@ config CPU_S3C2412
>   	select CPU_LLSERIAL_S3C2440
>   	select S3C2412_DMA if S3C24XX_DMA
>   	select S3C2412_PM if PM
> -	select SAMSUNG_HRT
>   	help
>   	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
> 
> @@ -53,7 +51,6 @@ config CPU_S3C2416
>   	select S3C2443_COMMON
>   	select S3C2443_DMA if S3C24XX_DMA
>   	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
>   	help
>   	  Support for the S3C2416 SoC from the S3C24XX line
> 
> @@ -64,7 +61,6 @@ config CPU_S3C2440
>   	select S3C2410_CLOCK
>   	select S3C2410_PM if PM
>   	select S3C2440_DMA if S3C24XX_DMA
> -	select SAMSUNG_HRT
>   	help
>   	  Support for S3C2440 Samsung Mobile CPU based systems.
> 
> @@ -74,7 +70,6 @@ config CPU_S3C2442
>   	select CPU_LLSERIAL_S3C2440
>   	select S3C2410_CLOCK
>   	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
>   	help
>   	  Support for S3C2442 Samsung Mobile CPU based systems.
> 
> @@ -89,7 +84,6 @@ config CPU_S3C2443
>   	select S3C2443_COMMON
>   	select S3C2443_DMA if S3C24XX_DMA
>   	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
>   	help
>   	  Support for the S3C2443 SoC from the S3C24XX line
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig
> b/arch/arm/mach-s3c64xx/Kconfig index 2057853..041da51 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -17,13 +17,11 @@ config PLAT_S3C64XX
>   # Configuration options for the S3C6410 CPU
> 
>   config CPU_S3C6400
> -	select SAMSUNG_HRT
>   	bool
>   	help
>   	  Enable S3C6400 CPU support
> 
>   config CPU_S3C6410
> -	select SAMSUNG_HRT
>   	bool
>   	help
>   	  Enable S3C6410 CPU support
> diff --git a/arch/arm/mach-s5p64x0/Kconfig
> b/arch/arm/mach-s5p64x0/Kconfig index 5a707bd..bb2111b 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -11,14 +11,12 @@ config CPU_S5P6440
>   	bool
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>   	select SAMSUNG_WAKEMASK if PM
>   	help
>   	  Enable S5P6440 CPU support
> 
>   config CPU_S5P6450
>   	bool
> -	select SAMSUNG_HRT
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
>   	select SAMSUNG_WAKEMASK if PM
> diff --git a/arch/arm/mach-s5pc100/Kconfig
> b/arch/arm/mach-s5pc100/Kconfig index 2f456a4..15170be 100644
> --- a/arch/arm/mach-s5pc100/Kconfig
> +++ b/arch/arm/mach-s5pc100/Kconfig
> @@ -11,7 +11,6 @@ config CPU_S5PC100
>   	bool
>   	select S5P_EXT_INT
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>   	help
>   	  Enable S5PC100 CPU support
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig
> b/arch/arm/mach-s5pv210/Kconfig index 0963283..caaedaf 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -15,7 +15,6 @@ config CPU_S5PV210
>   	select S5P_PM if PM
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
>   	help
>   	  Enable S5PV210 CPU support

Looks good, thanks.

Best regards,
Tomasz
