From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
Date: Tue, 25 Feb 2020 10:32:04 +0530
Message-ID: <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
 <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 1:23 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
>> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  		load_value, load_value,	match_value, match_value);
>>  
>>  	omap->pdata->set_pwm(omap->dm_timer,
>> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> -			      true,
>> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> 
> This is unrelated.

PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE is deleted along with header file
and used OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE. I should have mentioned this
in my commit description. Will fix it in v2.

Thanks and regards,
Lokesh
