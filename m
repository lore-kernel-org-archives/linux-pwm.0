From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] spi: kconfig: Remove AVR32 dep. from SPI_ATMEL
Date: Thu, 8 Feb 2018 17:33:51 +0100
Message-ID: <97250c63-cb2b-b1e8-63ac-59b9c749fd52@gmail.com>
References: <20180206120825.GF5681@sirena.org.uk>
 <20180206225519.20248-1-ulfalizer@gmail.com>
 <7f2bebe1-2931-7ec9-ef9f-0d3e6dda6c0b@gmail.com>
 <a8d2076b-6863-6ff1-5442-0587ad973766@gmail.com>
 <20180208024414.jjcxvd2q4o5rifgh@huvuddator>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180208024414.jjcxvd2q4o5rifgh@huvuddator>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, clabbe.montjoie@gmail.com, viresh.kumar@linaro.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch, christophe.leroy@c-s.fr, seanpaul@chromium.org, linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org



On 02/08/2018 03:44 AM, Ulf Magnusson wrote:
> The AVR32 symbol was removed in commit 26202873bb51 ("avr32: remove
> support for AVR32 architecture").

You forgot the Signed-off-by tag.

> ---
> Changes in v2:
> Remove the AVR32 reference from the help text too.
> 
>  drivers/spi/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 603783976b81..6fb0347a24f2 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -72,10 +72,10 @@ config SPI_ARMADA_3700
>  config SPI_ATMEL
>  	tristate "Atmel SPI Controller"
>  	depends on HAS_DMA
> -	depends on (ARCH_AT91 || AVR32 || COMPILE_TEST)
> +	depends on (ARCH_AT91 || COMPILE_TEST)
>  	help
>  	  This selects a driver for the Atmel SPI Controller, present on
> -	  many AT32 (AVR32) and AT91 (ARM) chips.
> +	  many AT91 (ARM) chips.
>  
>  config SPI_AU1550
>  	tristate "Au1550/Au1200/Au1300 SPI Controller"
> 
