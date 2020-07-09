From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
Date: Thu, 9 Jul 2020 17:47:59 +0200
Message-ID: <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
 <20200709145013.GA3703480@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200709145013.GA3703480@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 7/9/20 4:50 PM, Andy Shevchenko wrote:
> On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
>> The datasheet specifies that programming the base_unit part of the
>> ctrl register to 0 results in a contineous low signal.
>>
>> Adjust the get_state method to reflect this by setting pwm_state.period
>> to 1 and duty_cycle to 0.
> 
> ...
> 
>> +	if (freq == 0) {
>> +		/* In this case the PWM outputs a continous low signal */
> 
>> +		state->period = 1;
> 
> I guess this should be something like half of the range (so base unit calc
> will give 128). Because with period = 1 (too small) it will give too small
> base unit (if apply) and as a result we get high frequency pulses.

You are right, that if after this the user only changes the duty-cycle
things will work very poorly, we will end up with a base_unit value of
e.g 65535 and then have almost no duty-cycle resolution at all.

How about using a value here which results in a base_unit value of
256 (for 16 bit base-unit registers), that is the highest frequency we
can do while still having full duty-cycle resolution and it also
is the power-on-reset value, so using a higher period which translates
to a base_unit value of 256 (the por calue) seems like a sensible thing to do.

Uwe what do you think about this?

Regards,

Hans



> 
>> +		state->duty_cycle = 0;
>> +	} else {
>>   		state->period = NSEC_PER_SEC / (unsigned long)freq;
>> +		on_time_div *= state->period;
>> +		do_div(on_time_div, 255);
>> +		state->duty_cycle = on_time_div;
>> +	}
> 
