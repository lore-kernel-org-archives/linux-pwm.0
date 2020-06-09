From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Date: Tue, 9 Jun 2020 15:44:18 +0200
Message-ID: <93c7843d-1225-c8c6-9eb7-1f11b44bec34@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-11-hdegoede@redhat.com>
 <20200609113220.GM2428291@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200609113220.GM2428291@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 6/9/20 1:32 PM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:
>> Replace the enable, disable and config pwm_ops with an apply op,
>> to support the new atomic PWM API.
> 
> ...
> 
>> -static int crc_pwm_calc_clk_div(int period_ns)
>> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>>   {
>> -	int clk_div;
>> -
>> -	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
>> -	/* clk_div 1 - 128, maps to register values 0-127 */
>> -	if (clk_div > 0)
>> -		clk_div--;
>> -
>> -	return clk_div;
>> -}
> 
> ...
> 
>> +		clk_div = PWM_BASE_CLK_MHZ * state->period /
>> +			  (256 * NSEC_PER_MHZ);
>> +		/* clk_div 1 - 128, maps to register values 0-127 */
>> +		if (clk_div > 0)
>> +			clk_div--;
> 
> And again... :-(

Well yes I cannot help it that the original code, as submitted by Intel,
was of very questionable quality, so instead of just converting it to the
atomic PWM API I had to do a ton of bugfixes first...   I tried to do
this all in small bits rather then in a single big rewrite the buggy
<beep> commit to make life easier for reviewers.

I can introduce the crc_pwm_calc_clk_div helper earlier as you suggested
in an earlier mail. I guess I could also keep the helper here, and then
fold it into the function in a later commit (*).

Would that work for you ?

Regards,

Hans



*) Because having a helper for 3 lines of code when it is used only
once is not helpful IMHO, it only makes it harder to figure out what
the code is exactly doing when readin the code.
