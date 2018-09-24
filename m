Return-Path: <hdegoede@redhat.com>
Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Add pwm_lpss_get_put_runtime_pm helper
 function
References: <20180911174533.4484-1-hdegoede@redhat.com>
 <20180911174533.4484-2-hdegoede@redhat.com>
 <20180924091653.GF15943@smile.fi.intel.com>
 <88a8e7b3-5c8e-2783-8972-1a1e495d3f28@redhat.com>
 <20180924100505.GK15943@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <658bf04b-5040-5eb4-6492-3ffad778e415@redhat.com>
Date: Mon, 24 Sep 2018 14:13:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180924100505.GK15943@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On 24-09-18 12:05, Andy Shevchenko wrote:
> On Mon, Sep 24, 2018 at 11:58:42AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 24-09-18 11:16, Andy Shevchenko wrote:
>>> On Tue, Sep 11, 2018 at 07:45:32PM +0200, Hans de Goede wrote:
>>>> Add a helper function to properly get / put the pwm's runtime_pm
>>>> reference when changing from enabled to disable or vice versa.
>>>>
>>>> And use this to ensure the pwm's runtime_pm reference is properly
>>>> released on remove.
>>>>
>>>
>>> Can you provide a test sequence to reproduce the issue?
>>
>> This patch is mostly a preparation patch for adding the get_state
>> callback to make the driver fully support the pwm-atomic model.
>>
>> When I first tried to upstream the get_state code about a year
>> ago, there was some not pretty code in there to deal with getting
>> the runtime pm reference if the backlight was already enabled when
>> the driver loads. One of the review requests was to factor out the
>> code dealing with getting/putting the runtime_pm reference when
>> changing state from enabled to disabled or the other way around.
>> That is the mean reason for this commit.
>>
>> When writing this I noticed that if we rmmod the driver while
>> the backlight has been enabled through the driver (e.g. through
>> the sysfs interface) that we then leak the runtime-pm reference
>> which we get when we enable the pwm.
>>
>> Note the purpose of adding a get_state callback is to have the i915
>> driver eventually read back the backlight state at boot and avoid
>> the backlight always jumping to 100% brightness at boot which
>> causes an ugly visual flicker.
> 
> Thanks.
> 
> I'm just wondering if we can leave pwm_lpss_apply() untouched and use a new helper for ->remove() and ->get_state() only.

The idea was to have a single place doing the pm_runtime_get() and
pm_runtime_put() calls. Leaving pwm_lpss_apply() as is and this not
using this helper there is fine with me, but then we might just as
well directly do the [un]ref directly in >remove() and ->get_state()
as well, that is just 2 lines (instead of 1) for each.

I'm not against leaving pwm_lpss_apply() as is, but then we might
just as well drop this patch, so do you want to drop this patch
for v2 ?

Also do you have any remarks on the patch adding the get_stage
callback before I send out a v2?

Regards,

Hans




>>>> --- a/drivers/pwm/pwm-lpss.c
>>>> +++ b/drivers/pwm/pwm-lpss.c
>>>> @@ -120,43 +120,58 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
>>>>    		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
>>>>    }
>>>> +static void pwm_lpss_get_put_runtime_pm(struct pwm_chip *chip,
>>>> +					bool old_enabled, bool new_enabled)
>>>> +{
>>>> +	if (new_enabled == old_enabled)
>>>> +		return;
>>>> +
>>>> +	if (new_enabled)
>>>> +		pm_runtime_get(chip->dev);
>>>> +	else
>>>> +		pm_runtime_put(chip->dev);
>>>> +}
>>>> +
>>>>    static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>>>    			  struct pwm_state *state)
>>>>    {
>>>>    	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>>>> -	int ret;
>>>> +	int ret = 0;
>>>> +
>>>> +	pm_runtime_get_sync(chip->dev);
>>>>    	if (state->enabled) {
>>>>    		if (!pwm_is_enabled(pwm)) {
>>>> -			pm_runtime_get_sync(chip->dev);
>>>>    			ret = pwm_lpss_is_updating(pwm);
>>>> -			if (ret) {
>>>> -				pm_runtime_put(chip->dev);
>>>> -				return ret;
>>>> -			}
>>>> +			if (ret)
>>>> +				goto out;
>>>> +
>>>>    			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>>>>    			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
>>>>    			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
>>>>    			ret = pwm_lpss_wait_for_update(pwm);
>>>> -			if (ret) {
>>>> -				pm_runtime_put(chip->dev);
>>>> -				return ret;
>>>> -			}
>>>> +			if (ret)
>>>> +				goto out;
>>>> +
>>>>    			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
>>>>    		} else {
>>>>    			ret = pwm_lpss_is_updating(pwm);
>>>>    			if (ret)
>>>> -				return ret;
>>>> +				goto out;
>>>> +
>>>>    			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>>>>    			pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_SW_UPDATE);
>>>> -			return pwm_lpss_wait_for_update(pwm);
>>>> +			ret = pwm_lpss_wait_for_update(pwm);
>>>>    		}
>>>>    	} else if (pwm_is_enabled(pwm)) {
>>>>    		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>>>> -		pm_runtime_put(chip->dev);
>>>>    	}
>>>> -	return 0;
>>>> +	pwm_lpss_get_put_runtime_pm(chip, pwm_is_enabled(pwm), state->enabled);
>>>> +
>>>> +out:
>>>> +	pm_runtime_put(chip->dev);
>>>> +	return ret;
>>>>    }
>>>>    static const struct pwm_ops pwm_lpss_ops = {
>>>> @@ -205,6 +220,10 @@ EXPORT_SYMBOL_GPL(pwm_lpss_probe);
>>>>    int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
>>>>    {
>>>> +	bool enabled = pwm_is_enabled(&lpwm->chip.pwms[0]);
>>>> +
>>>> +	pwm_lpss_get_put_runtime_pm(&lpwm->chip, enabled, false);
>>>> +
>>>>    	return pwmchip_remove(&lpwm->chip);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pwm_lpss_remove);
> 
