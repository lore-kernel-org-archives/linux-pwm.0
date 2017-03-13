From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] pwm: lpss: Do not set / wait_for update_bit when not
 enabled
Date: Mon, 13 Mar 2017 16:29:26 +0100
Message-ID: <ef125e5c-cd6d-ab0b-3a7f-199b0b2c80a4@redhat.com>
References: <20170220201657.24801-1-hdegoede@redhat.com>
 <20170220201657.24801-2-hdegoede@redhat.com> <20170223080623.GB61837@kammari>
 <1488275185.20145.48.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40902 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbdCMP3a (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 13 Mar 2017 11:29:30 -0400
In-Reply-To: <1488275185.20145.48.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi,

On 28-02-17 10:46, Andy Shevchenko wrote:
> On Thu, 2017-02-23 at 00:06 -0800, Ilkka Koskinen wrote:
>
>>> At least on cherrytrail, the update bit will never go low when the
>>> enabled bit is not set.
>>>
>>> This causes the backlight on my cube iwork8 air tablet to never go
>>> on
>>> again after being turned off, because the enable path does:
>>>
>>> 	pwm_lpss_prepare();
>>> 	ret = pwm_lpss_update(pwm);
>>> 	if (ret)
>>> 		return ret;
>>> 	pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
>>>
>>> And the pwm_lpss_update() call fails, as the setting of the
>>> UPDATE bit never gets acked, because the ENABLE bit is not set.
>>>
>>> Subsequent calls then all fail because of the pwm_lpss_is_updating()
>>> check done by pwm_lpss_apply().
>>>
>
>>> This commit fixes this by setting the enable bit before calling
>>> pwm_lpss_update().
>
> This might break other systems.
>
>>> @@ -137,12 +137,12 @@ static int pwm_lpss_apply(struct pwm_chip
>>> *chip, struct pwm_device *pwm,
>>>  				return ret;
>>>  			}
>>>  			pwm_lpss_prepare(lpwm, pwm, state-
>>>> duty_cycle, state->period);
>>> +			pwm_lpss_write(pwm, pwm_lpss_read(pwm) |
>>> PWM_ENABLE);
>>>  			ret = pwm_lpss_update(pwm);
>>
>> The BXT documentation that I have recommends to set update bit before
>> enable
>> one.
>
> We have the same work flow for all SoCs that have this PWM IP. I suspect
> it might be a silicon bug somewhere, but I have never heard of it.
>
>>  However, based on your experiment on Cherryview, we still have to set
>> it
>> before read_poll_timeout().
>
> I would test and confirm the issue on our machines to see that the fix
> doesn't break the rest. Seems like we have several subtle different
> implementation of it: BYT, CHT, MRFLD, BXT.
>
>> Andy, should we indeed remove the return value from apply() and just
>> print a warning
>> like Mika initially suggested?
>
> I definitely consider it better than Hans' initial proposal.
>
> Hans, can you just replace
>
>  return ret;
>
> by
>
>  dev_warn(..., "UPDATE bit is not cleared!\n");
>
> and test it?

Sure, done, as expected that fixes it, but not really in a pretty way,
now at boot and every time the screen goes into DPMS / off I get:

[    9.461180] pwm-lpss 80862288:00: PWM_SW_UPDATE was not cleared
[    9.461190] pwm-lpss 80862288:00: UPDATE bit is not cleared!
[  124.642002] pwm-lpss 80862288:00: PWM_SW_UPDATE was not cleared
[  124.642007] pwm-lpss 80862288:00: UPDATE bit is not cleared!

I believe it would be better to split pwm_lpss_update into setting the
update-bit and pwm_lpss_wait_for_update, and move the
pwm_lpss_wait_for_update call in the enable path to after setting the
enable-bit.

I've just finished testing a patch which does that, probably easier
to discuss it when you can see the code, so I will send that out as
a v2 of this one.

Regards,

Hans
