From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before changing
 period/duty_cycle
Date: Tue, 25 Feb 2020 10:32:42 +0530
Message-ID: <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
 <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
>> Only the Timer control register(TCLR) can be updated only when the timer
>> is stopped. Registers like Counter register(TCRR), loader register(TLDR),
>> match register(TMAR) can be updated when the counter is running. Since
>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>> timer for period/duty_cycle update.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index f13be7216847..58c61559e72f 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  	u32 load_value, match_value;
>>  	struct clk *fclk;
>>  	unsigned long clk_rate;
>> -	bool timer_active;
>>  
>>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>>  		duty_ns, period_ns);
>> @@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  	load_value = (DM_TIMER_MAX - period_cycles) + 1;
>>  	match_value = load_value + duty_cycles - 1;
>>  
>> -	/*
>> -	 * We MUST stop the associated dual-mode timer before attempting to
>> -	 * write its registers, but calls to omap_dm_timer_start/stop must
>> -	 * be balanced so check if timer is active before calling timer_stop.
>> -	 */
>> -	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
>> -	if (timer_active)
>> -		omap->pdata->stop(omap->dm_timer);
>> -
>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
> 
> (Without having looked into the depths of the driver I assume
> .set_load() sets the period of the PWM and .set_match() the duty cycle.)

Right.

> 
> What happens on a running PWM if you change the period? Consider you
> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
> period = 10000. As you set the period first, can it happen the hardware
> produces a cycle with duty_cycle = 1000, period = 10000?

No. So, the current cycle is un affected with duty_cycle = 1000 and period =
5000. Starting from next cycle new settings gets reflected with duty_cycle =
4000 and period = 10000.

Thanks and regards,
Lokesh
