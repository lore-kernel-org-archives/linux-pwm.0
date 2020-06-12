From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 11/15] pwm: crc: Implement get_state() method
Date: Fri, 12 Jun 2020 19:00:42 +0200
Message-ID: <f2a268ef-2b65-d027-0b0c-b83e12a04f20@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-12-hdegoede@redhat.com>
 <20200611213744.6gg2oy45cende6ba@taurus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27223 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbgFLRAs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:00:48 -0400
Received: by mail-ej1-f70.google.com with SMTP id do21so4455706ejc.2
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:00:45 -0700 (PDT)
In-Reply-To: <20200611213744.6gg2oy45cende6ba@taurus.defre.kleine-koenig.org>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

Hi,

On 6/11/20 11:37 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Sun, Jun 07, 2020 at 08:18:36PM +0200, Hans de Goede wrote:
>> Implement the pwm_ops.get_state() method to complete the support for the
>> new atomic PWM API.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-crc.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
>> index 58c7e9ef7278..6c75a3470bc8 100644
>> --- a/drivers/pwm/pwm-crc.c
>> +++ b/drivers/pwm/pwm-crc.c
>> @@ -114,8 +114,37 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	return 0;
>>   }
>>   
>> +static void crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
>> +	struct device *dev = crc_pwm->chip.dev;
>> +	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
>> +	int error;
>> +
>> +	error = regmap_read(crc_pwm->regmap, PWM0_CLK_DIV, &clk_div_reg);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_CLK_DIV %d\n", error);
>> +		return;
>> +	}
>> +
>> +	error = regmap_read(crc_pwm->regmap, PWM0_DUTY_CYCLE, &duty_cycle_reg);
>> +	if (error) {
>> +		dev_err(dev, "Error reading PWM0_DUTY_CYCLE %d\n", error);
>> +		return;
>> +	}
> 
> I assume that duty_cycle_reg cannot be bigger than 0xff? Would it make
> sense to mask the value accordingly to get more robust code?
> 
>> +	clk_div = (clk_div_reg & ~PWM_OUTPUT_ENABLE) + 1;
>> +
>> +	state->period     = clk_div * NSEC_PER_MHZ * 256 / PWM_BASE_CLK_MHZ;
>> +	state->duty_cycle = duty_cycle_reg * state->period / PWM_MAX_LEVEL;
>> +	state->polarity   = PWM_POLARITY_NORMAL;
>> +	state->enabled    = !!(clk_div_reg & PWM_OUTPUT_ENABLE);
> 
> These aligned = look strange (IMHO). If you don't feel strong here I'd
> like to see a single space before a =.

Ok, will change for the next version.

Regards,

Hans
