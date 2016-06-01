From: Dan O'Donovan <dan@emutex.com>
Subject: Re: [PATCH] pwm: lpss: fix base_unit calculation for PWM frequency
Date: Wed, 1 Jun 2016 11:33:20 +0100
Message-ID: <574EB9F0.9020001@emutex.com>
References: <1464706264-19344-1-git-send-email-dan@emutex.com>
 <20160601102037.GR1743@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bert.emutex.com ([91.103.1.109]:60606 "EHLO bert.emutex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751303AbcFAKdZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 1 Jun 2016 06:33:25 -0400
In-Reply-To: <20160601102037.GR1743@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org

Hi Mika

On 06/01/2016 11:20 AM, Mika Westerberg wrote:
> On Tue, May 31, 2016 at 03:51:04PM +0100, Dan O'Donovan wrote:
>> The base_unit calculation applies an offset of 0x2 which adds
>> significant error for lower frequencies and doesn't appear to be
>> warranted - rounding the division result gives a correct value.
> I don't even remember where that 2 originally came from. Maybe it was
> fix for some early silicon issue. Happy to see it go away :)
>
>> Also, the upper limit check for base_unit is off-by-one; the upper
>> nibble of base_unit is invalid if >=128 according to the Table 88
>> in the Z8000 Processor Series Datasheet Volume 1 (Rev. 2).
>>
>> Verified on UP Board (Cherry Trail) and Minnowboard Max (Bay Trail).
>>
>> Signed-off-by: Dan O'Donovan <dan@emutex.com>
>> ---
>>  drivers/pwm/pwm-lpss.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
>> index 295b963..01cc708 100644
>> --- a/drivers/pwm/pwm-lpss.c
>> +++ b/drivers/pwm/pwm-lpss.c
>> @@ -27,7 +27,6 @@
>>  #define PWM_SW_UPDATE			BIT(30)
>>  #define PWM_BASE_UNIT_SHIFT		8
>>  #define PWM_ON_TIME_DIV_MASK		0x000000ff
>> -#define PWM_DIVISION_CORRECTION		0x2
>>  
>>  /* Size of each PWM register space if multiple */
>>  #define PWM_SIZE			0x400
>> @@ -101,17 +100,16 @@ static int pwm_lpss_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>  
>>  	/*
>>  	 * The equation is:
>> -	 * base_unit = ((freq / c) * base_unit_range) + correction
>> +	 * base_unit = (round(freq / c) * 65536)
> Please leave this as 
>
> 	base_unit = (round(freq / c) * base_unit_range)
>
> because Broxton uses 22 bits for base unit.
Oops, thanks for pointing that out!  I had developed the patch on an older kernel without Broxton support, and missed this when rebasing.  I'll submit a new version with that change.
>
> Otherwise, looks good to me:
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
>>  	 */
>>  	base_unit_range = BIT(lpwm->info->base_unit_bits);
>> -	base_unit = freq * base_unit_range;
>> +	freq *= base_unit_range;
>>  
>>  	c = lpwm->info->clk_rate;
>>  	if (!c)
>>  		return -EINVAL;
>>  
>> -	do_div(base_unit, c);
>> -	base_unit += PWM_DIVISION_CORRECTION;
>> +	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
>>  
>>  	if (duty_ns <= 0)
>>  		duty_ns = 1;
>> -- 
>> 2.1.4
