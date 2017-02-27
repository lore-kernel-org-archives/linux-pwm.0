From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/3] pwm: lpss: Add get_state callback
Date: Mon, 27 Feb 2017 15:09:27 +0100
Message-ID: <c08dc4d3-be13-d71d-086e-944a6bfc0855@redhat.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
 <20170220201657.24801-4-hdegoede@redhat.com>
 <1487673196.20145.7.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbdB0OR2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Feb 2017 09:17:28 -0500
In-Reply-To: <1487673196.20145.7.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Hi,

On 21-02-17 11:33, Andy Shevchenko wrote:
> On Mon, 2017-02-20 at 21:16 +0100, Hans de Goede wrote:
>> Add a get_state callback so that the initial state correctly reflects
>> the actual hardware state.
>>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>
>
>> +static void pwm_lpss_get_state(struct pwm_chip *chip, struct
>> pwm_device *pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>> +	unsigned long base_unit_range, freq;
>> +	unsigned long long base_unit, on_time_div;
>
> Something with types.
>
> on_time_div is 8-bit only.

Right, but state->period can be up to 1000000000, so we need
64 bits after multiplying that by max 255:

	state->duty_cycle = state->period * on_time_div / 255ULL;

Basically I've forced base_unit and on_time_div to be 64 bits
to avoid overflows when multiplying them later. Just like
pwm_lpss_prepare is doing.

> OTOH freq (due to multiplication below) might need bigger type.

base_unit is never bigger then base_unit_range, so:

	freq = base_unit * lpwm->info->clk_rate / base_unit_range;

Can never result in freq > lpwm->info->clk_rate which is an
unsigned long, so using an unsigned long should be enough,
but to be able to use do_div I need to make it an unsigned long long
regardless.

> Have you tried 32-bit compilation, btw? No warnings for division?

No, I have not tried, but you're right I need to use do_div here to
avoid issues with 64 bit division on 32 bit archs.


>
>> +	u32 ctrl;
>> +
>> +	base_unit_range = BIT(lpwm->info->base_unit_bits);
>> +
>> +	ctrl = pwm_lpss_read(pwm);
>> +	on_time_div = ctrl & PWM_ON_TIME_DIV_MASK;
>> +	base_unit = (ctrl >> PWM_BASE_UNIT_SHIFT) & (base_unit_range
>> - 1);
>> +
>> +	freq = base_unit * lpwm->info->clk_rate / base_unit_range;
>
>> +	if (freq == 0)
>> +		freq = 1;
>
> Why?
> I'm not sure it will give correct value.

To avoid divide by 0 in case the ctrl register reads
all 0 for the base_unit, but I've solved this slightly
different for v2.

>
>> +
>
>> +	state->period = NSEC_PER_SEC / freq;
>
>
>> +	state->duty_cycle = state->period * on_time_div / 255ULL;
>> +	state->polarity = PWM_POLARITY_NORMAL;
>
>> +	state->enabled = (ctrl & PWM_ENABLE) ? true : false;
>
> !!(ctrl & PWM_ENABLE)

Will fix for v2.

>> +
>
>> +	if (state->enabled)
>> +		pm_runtime_get_sync(chip->dev);
>
> How is this supposed to work in balance with ->apply() ?

apply() only does the pm_runtime_get when going from not
enabled to enabled (and releases it in the other direction):

         if (state->enabled) {
                 if (!pwm_is_enabled(pwm)) {
                         pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->pe
                         pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
                         ret = pwm_lpss_update(pwm);
                         if (ret == 0)
                                 pm_runtime_get(chip->dev);
                 } else {
                         pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->pe
                         ret = pwm_lpss_update(pwm);
                 }
         } else if (pwm_is_enabled(pwm)) {

Where state->enabled is looking at the new state and
pwm_is_enabled(pwm) at the current state, which on the
first call to apply is the state returned by
pwm_lpss_get_state during probe.

If the pwm is enabled when we get probed, we need to do a
pm_runtime_get to avoid runtime suspend kicking in while
enabled and to balance the put which apply() will do an
a transition to disabled.

Regards,

Hans


>
>> +}
>> +
>>  static const struct pwm_ops pwm_lpss_ops = {
>>  	.apply = pwm_lpss_apply,
>> +	.get_state = pwm_lpss_get_state,
>>  	.owner = THIS_MODULE,
>>  };
>>
>
