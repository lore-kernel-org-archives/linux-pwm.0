From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/7] pwm: jz4740: Use clocks from TCU driver
Date: Fri, 9 Aug 2019 18:55:09 +0200
Message-ID: <20190809165509.odbmz4wy2ijl6vh2@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809123031.24219-3-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>
List-Id: linux-pwm@vger.kernel.org

On Fri, Aug 09, 2019 at 02:30:26PM +0200, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with clocks, that can be
> (un)gated, reparented or reclocked from devicetree, instead of having
> these settings hardcoded in this driver.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/pwm/Kconfig      |  1 +
>  drivers/pwm/pwm-jz4740.c | 40 ++++++++++++++++++++++++++--------------
>  2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cc4df0ec978a..d2557c6fcf65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -225,6 +225,7 @@ config PWM_IMX_TPM
>  config PWM_JZ4740
>  	tristate "Ingenic JZ47xx PWM support"
>  	depends on MACH_INGENIC
> +	depends on COMMON_CLK
>  	select MFD_SYSCON
>  	help
>  	  Generic PWM framework driver for Ingenic JZ47xx based
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 7aea5e0c6e18..6ec8794d3b99 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -20,7 +20,6 @@
>  
>  struct jz4740_pwm_chip {
>  	struct pwm_chip chip;
> -	struct clk *clk;
>  	struct regmap *map;
>  };
>  
> @@ -32,6 +31,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
>  static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct jz4740_pwm_chip *jz = to_jz4740(chip);
> +	struct clk *clk;
> +	char clk_name[16];
> +	int ret;
>  
>  	/*
>  	 * Timers 0 and 1 are used for system tasks, so they are unavailable
> @@ -40,16 +42,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  	if (pwm->hwpwm < 2)
>  		return -EBUSY;
>  
> -	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
> +	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);

This undoes stuff from the previous patch. Maybe swap the order of the
two patches?

Other than that the patch looks fine on a quick glance.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
