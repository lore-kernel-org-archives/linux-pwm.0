From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
Date: Mon, 24 Feb 2020 08:53:02 +0100
Message-ID: <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224052135.17278-2-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  		load_value, load_value,	match_value, match_value);
>  
>  	omap->pdata->set_pwm(omap->dm_timer,
> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> -			      true,
> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);

This is unrelated.

>  
>  	/* If config was called while timer was running it must be reenabled. */
>  	if (timer_active)
> @@ -220,9 +219,8 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
>  	 */
>  	mutex_lock(&omap->mutex);
>  	omap->pdata->set_pwm(omap->dm_timer,
> -			      polarity == PWM_POLARITY_INVERSED,
> -			      true,
> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +			     polarity == PWM_POLARITY_INVERSED,
> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);

ditto

>  	mutex_unlock(&omap->mutex);
>  
>  	return 0;
> @@ -244,7 +242,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>  	struct pwm_omap_dmtimer_chip *omap;
>  	struct dmtimer_platform_data *timer_pdata;
>  	const struct omap_dm_timer_ops *pdata;
> -	pwm_omap_dmtimer *dm_timer;
> +	struct omap_dm_timer *dm_timer;
>  	u32 v;
>  	int ret = 0;
>  

Other than that looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
