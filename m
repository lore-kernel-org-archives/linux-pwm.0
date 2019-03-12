From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: Kconfig: Enable ehrpwm driver to be compiled
 for ARCH_K3
Date: Tue, 12 Mar 2019 10:30:12 +0100
Message-ID: <20190312093012.g4rnis37nltzbygz@pengutronix.de>
References: <20190312091629.31701-1-vigneshr@ti.com>
 <20190312091629.31701-3-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312091629.31701-3-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 12, 2019 at 02:46:29PM +0530, Vignesh Raghavendra wrote:
> K3 devices have the same EHRPWM IP as OMAP SoCs. Enable driver to be built
> for K3 devices. Also, drop reference to AM33xx in help text, as IP is
> found on multiple TI SoCs.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/pwm/Kconfig | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 54f8238aac0d..c054bd1dba36 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -467,10 +467,9 @@ config  PWM_TIECAP
>  
>  config  PWM_TIEHRPWM
>  	tristate "EHRPWM PWM support"
> -	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
> +	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3
>  	help
> -	  PWM driver support for the EHRPWM controller found on AM33XX
> -	  TI SOC
> +	  PWM driver support for the EHRPWM controller found on TI SOCs

It would be great to be able to compile this driver with COMPILE_TEST.
From a quick look the following would be appropriate:

	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_K3 || COMPILE_TEST
	depends on HAVE_CLK && HAS_IOMEM
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
