Return-Path: <kgene.kim@gmail.com>
Return-Path: <kgene.kim@gmail.com>
Sender: Kukjin Kim <kgene.kim@gmail.com>
Message-ID: <51C866AD.6010406@samsung.com>
Date: Tue, 25 Jun 2013 00:33:01 +0900
From: Kukjin Kim <kgene.kim@samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/18] ARM: SAMSUNG: Move all platforms to new clocksource
 driver
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <1371766383-29077-8-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1371766383-29077-8-git-send-email-tomasz.figa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Olof Johansson <olof@lixom.net>, Thierry Reding <thierry.reding@gmail.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-arm-kernel@lists.infradead.org

On 06/21/13 07:12, Tomasz Figa wrote:
> This patch moves all Samsung platforms using PWM clocksource from legacy
> samsung-time to new samsung-pwm-timer driver.
>
> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> ---
>   arch/arm/mach-s3c24xx/Kconfig  | 12 ++++++------
>   arch/arm/mach-s3c24xx/common.c | 16 ++++++++++++++++
>   arch/arm/mach-s3c64xx/Kconfig  |  4 ++--
>   arch/arm/mach-s3c64xx/common.c | 17 +++++++++++++++++
>   arch/arm/mach-s5p64x0/Kconfig  |  4 ++--
>   arch/arm/mach-s5p64x0/common.c | 17 +++++++++++++++++
>   arch/arm/mach-s5pc100/Kconfig  |  2 +-
>   arch/arm/mach-s5pc100/common.c | 17 +++++++++++++++++
>   arch/arm/mach-s5pv210/Kconfig  |  2 +-
>   arch/arm/mach-s5pv210/common.c | 17 +++++++++++++++++
>   10 files changed, 96 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
> index 6d9252e..46f9a9c 100644
> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -30,7 +30,7 @@ config CPU_S3C2410
>   	select S3C2410_CLOCK
>   	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
>   	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Please put this in alphabetical ordering, this is just replacing though.

>   	select SAMSUNG_WDT_RESET
>   	help
>   	  Support for S3C2410 and S3C2410A family from the S3C24XX line
> @@ -42,7 +42,7 @@ config CPU_S3C2412
>   	select CPU_LLSERIAL_S3C2440
>   	select S3C2412_DMA if S3C24XX_DMA
>   	select S3C2412_PM if PM
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same as above.

>   	help
>   	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
>
> @@ -54,7 +54,7 @@ config CPU_S3C2416
>   	select S3C2443_COMMON
>   	select S3C2443_DMA if S3C24XX_DMA
>   	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same as above.

>   	help
>   	  Support for the S3C2416 SoC from the S3C24XX line
>
> @@ -65,7 +65,7 @@ config CPU_S3C2440
>   	select S3C2410_CLOCK
>   	select S3C2410_PM if PM
>   	select S3C2440_DMA if S3C24XX_DMA
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same as above.

>   	help
>   	  Support for S3C2440 Samsung Mobile CPU based systems.
>
> @@ -75,7 +75,7 @@ config CPU_S3C2442
>   	select CPU_LLSERIAL_S3C2440
>   	select S3C2410_CLOCK
>   	select S3C2410_PM if PM
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

>   	help
>   	  Support for S3C2442 Samsung Mobile CPU based systems.
>
> @@ -91,7 +91,7 @@ config CPU_S3C2443
>   	select S3C2443_COMMON
>   	select S3C2443_DMA if S3C24XX_DMA
>   	select SAMSUNG_CLKSRC
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

[...]

>
>   config CPU_S3C6400
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

>   	bool
>   	help
>   	  Enable S3C6400 CPU support
>
>   config CPU_S3C6410
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

>   	bool
>   	help
>   	  Enable S3C6410 CPU support

[...]

> @@ -11,14 +11,14 @@ config CPU_S5P6440
>   	bool
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

>   	select SAMSUNG_WAKEMASK if PM
>   	help
>   	  Enable S5P6440 CPU support
>
>   config CPU_S5P6450
>   	bool
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

[...]

> @@ -11,7 +11,7 @@ config CPU_S5PC100
>   	bool
>   	select S5P_EXT_INT
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

[...]

> @@ -15,7 +15,7 @@ config CPU_S5PV210
>   	select S5P_PM if PM
>   	select S5P_SLEEP if PM
>   	select SAMSUNG_DMADEV
> -	select SAMSUNG_HRT
> +	select CLKSRC_SAMSUNG_PWM

Same.

[...]

Let me fix it...

- Kukjin
