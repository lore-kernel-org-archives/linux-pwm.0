From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
Date: Wed, 7 Feb 2018 09:58:50 +0100
Message-ID: <7f2bebe1-2931-7ec9-ef9f-0d3e6dda6c0b@gmail.com>
References: <20180206120825.GF5681@sirena.org.uk>
 <20180206225519.20248-1-ulfalizer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180206225519.20248-1-ulfalizer@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Magnusson <ulfalizer@gmail.com>, broonie@kernel.org, linux-kernel@vger.kernel.org
Cc: clabbe.montjoie@gmail.com, viresh.kumar@linaro.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org, linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org



On 02/06/2018 11:55 PM, Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture").
> 
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 603783976b81..c1e455d46c7f 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -72,7 +72,7 @@ config SPI_ARMADA_3700
>  config SPI_ATMEL
>  	tristate "Atmel SPI Controller"
>  	depends on HAS_DMA
> -	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
> +	depends on (ARCH_AT91 || COMPILE_TEST)
>  	help
>  	  This selects a driver for the Atmel SPI Controller, present on
>  	  many AT32 (AVR32) and AT91 (ARM) chips.
> 
