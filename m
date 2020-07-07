From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Tue, 7 Jul 2020 10:04:58 +0200
Message-ID: <c2143daa-cdc0-0a72-196f-f27d1677278f@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 7/7/20 9:34 AM, Uwe Kleine-König wrote:
> On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> Thank you for your review and sorry for the slow reply.
> 
> No problem for me, I didn't hold my breath :-)
>   
>>>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>>>> index 43b1fc634af1..80d0f9c64f9d 100644
>>>> --- a/drivers/pwm/pwm-lpss.c
>>>> +++ b/drivers/pwm/pwm-lpss.c
>>>> @@ -97,6 +97,9 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>>>>    	freq *= base_unit_range;
>>>>    	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
>>>
>>> DIV_ROUND_CLOSEST_ULL is most probably wrong, too. But I didn't spend
>>> the time to actually confirm that.
>>
>> Yes I saw your comment elsewhere that the PWM API defines rounding
>> in a certain direction, but fixing that falls outside of this patch.
> 
> Yeah, sure.
> 
>> [...]
>> I hope this helps to explain what is going on a bit.
> 
> I will try to make sense of that and reply to the patch directly when I
> succeeded.

In case it helps here is the datasheet for the LPSS PWM controller
(somewhat hard to find if you don't know what you are looking for):

https://cdrdv2.intel.com/v1/dl/getcontent/332065
https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-2.pdf

The first link contains a description about how the PWM controller works in
section 17.5  "SIO - Pulse Width Modulation (PWM)", the second link contains
all register definitions for the SoC and is not all that interesting other
then for verifying the existing register bits defines.

Regards,

Hans



> 
>> ###
>>
>> As for the behavior on base_unit==0 in the get_state method,
>> as mentioned above I wrote that when I did not fully understood
>> how the controller works.
>>
>> We really should never encounter this.
>>
>> But if we do then I think closest to the truth would be:
>>
>> state->period     = UINT_MAX;
>> state->duty_cycle = 0;
> 
> I'd say state->period = 1 & state->duty_cycle = 0 is a better
> representation.
> 
> Best regards
> Uwe
> 
