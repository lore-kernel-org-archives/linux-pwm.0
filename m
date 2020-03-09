From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Date: Mon, 9 Mar 2020 10:21:59 +0530
Message-ID: <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200306181443.GJ37466@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Tony,

On 06/03/20 11:44 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
>> pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
>> timer counter. This doesn't complete the current pwm cycle and
>> immediately disables the pwm. Instead disable the auto reload
>> functionality which allows to complete the current pwm cycle and then
>> disables the timer.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index bc338619232d..89b3c25d02b8 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
>>  {
>>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>>  
>> +	/*
>> +	 * Disable auto reload so that the current cycle gets completed and
>> +	 * then the counter stops.
>> +	 */
>>  	mutex_lock(&omap->mutex);
>> -	omap->pdata->stop(omap->dm_timer);
>> +	omap->pdata->set_pwm(omap->dm_timer,
>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
>> +			     false);
>> +
>>  	mutex_unlock(&omap->mutex);
>>  }
> 
> I'm seeing an issue with this patch where after use something is
> left on and power consumption stays higher by about 30 mW after
> use.

Interesting...What is the PWM period and duty cycle in the test case?
Can you dump the following registers before and after disabling:
- TLDR
- TMAR
- TCLR

> 
> I can reproduce this easily on droid4 with Sebastian's rumble-test
> app[0]. After use, I sometimes also hear the vibrator keep chirping
> quietly, so there seems to be some pwm still happening after disable :)

hmm..The line clearly goes down on the scope after the current pwm duty cycle is
done and never comes back.

> 
> Reloading modules for pwm-vibra and pwm-omap-dmtimer make the power
> consumption go back down again.
> 
> If you have a scope set up, maybe check the lines are quiet after
> disable after this patch?
> 
> Regards,
> 
> Tony
> 
> 
> [0] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

This is redirecting to collabora.com. Is this code available in github or some
public repo?

Thanks and regards,
Lokesh
