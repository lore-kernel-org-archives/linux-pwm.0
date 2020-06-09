From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 11/15] pwm: crc: Implement get_state() method
Date: Tue, 9 Jun 2020 14:32:54 +0300
Message-ID: <20200609113254.GN2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-12-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:36PM +0200, Hans de Goede wrote:
> Implement the pwm_ops.get_state() method to complete the support for the
> new atomic PWM API.

This one is good.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 58c7e9ef7278..6c75a3470bc8 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -114,8 +114,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;
>  }
>  
> +static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       struct pwm_state *state)
> +{
> +	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
> +	struct device *dev = crc_pwm->chip.dev;
> +	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
> +	int error;
> +
> +	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
> +	if (error) {
> +		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
> +		return;
> +	}
> +
> +	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
> +	if (error) {
> +		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
> +		return;
> +	}
> +
> +	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
> +
> +	state->period     = clk_div * NSEC_PER_MHZ * 256 / PWM_BASE_CLK_MHZ;
> +	state->duty_cycle = duty_cycle_reg * state->period / PWM_MAX_LEVEL;
> +	state->polarity   = PWM_POLARITY_NORMAL;
> +	state->enabled    = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
> +}
> +
>  static const struct pwm_ops crc_pwm_ops = {
>  	.apply = crc_pwm_apply,
> +	.get_state = crc_pwm_get_state,
>  };
>  
>  static int crystalcove_pwm_probe(struct platform_device *pdev)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko
