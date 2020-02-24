From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Mon, 24 Feb 2020 09:55:31 +0100
Message-ID: <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200224052135.17278-4-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
> Only the Timer control register(TCLR) can be updated only when the timer
> is stopped. Registers like Counter register(TCRR), loader register(TLDR),
> match register(TMAR) can be updated when the counter is running. Since
> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> timer for period/duty_cycle update.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index f13be7216847..58c61559e72f 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	u32 load_value, match_value;
>  	struct clk *fclk;
>  	unsigned long clk_rate;
> -	bool timer_active;
>  
>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>  		duty_ns, period_ns);
> @@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	load_value = (DM_TIMER_MAX - period_cycles) + 1;
>  	match_value = load_value + duty_cycles - 1;
>  
> -	/*
> -	 * We MUST stop the associated dual-mode timer before attempting to
> -	 * write its registers, but calls to omap_dm_timer_start/stop must
> -	 * be balanced so check if timer is active before calling timer_stop.
> -	 */
> -	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
> -	if (timer_active)
> -		omap->pdata->stop(omap->dm_timer);
> -
>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>  	omap->pdata->set_match(omap->dm_timer, true, match_value);

(Without having looked into the depths of the driver I assume
.set_load() sets the period of the PWM and .set_match() the duty cycle.)

What happens on a running PWM if you change the period? Consider you
change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
period = 10000. As you set the period first, can it happen the hardware
produces a cycle with duty_cycle = 1000, period = 10000?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
