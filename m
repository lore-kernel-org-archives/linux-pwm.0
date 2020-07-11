From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
Date: Sat, 11 Jul 2020 15:58:02 +0200
Message-ID: <d98c758b-711d-baae-e752-1b32040128a4@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
 <20200709145013.GA3703480@smile.fi.intel.com>
 <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
 <20200711061120.di53sk5utjerb72q@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200711061120.di53sk5utjerb72q@pengutronix.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 7/11/20 8:11 AM, Uwe Kleine-König wrote:
> On Thu, Jul 09, 2020 at 05:47:59PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/9/20 4:50 PM, Andy Shevchenko wrote:
>>> On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
>>>> The datasheet specifies that programming the base_unit part of the
>>>> ctrl register to 0 results in a contineous low signal.
>>>>
>>>> Adjust the get_state method to reflect this by setting pwm_state.period
>>>> to 1 and duty_cycle to 0.
>>>
>>> ...
>>>
>>>> +	if (freq == 0) {
>>>> +		/* In this case the PWM outputs a continous low signal */
>>>
>>>> +		state->period = 1;
>>>
>>> I guess this should be something like half of the range (so base unit calc
>>> will give 128). Because with period = 1 (too small) it will give too small
>>> base unit (if apply) and as a result we get high frequency pulses.
>>
>> You are right, that if after this the user only changes the duty-cycle
>> things will work very poorly, we will end up with a base_unit value of
>> e.g 65535 and then have almost no duty-cycle resolution at all.
> 
> Is this a problem of the consumer that we don't need to solve? Are there
> known consumers running into this problem?

AFAICT we never ever actually see freq == 0 here, this is just a code-path
to avoid a divide by 0 in case we somehow mysteriously do get freq == 0
here.

On boot the PWM controller is either not used and then the default freq =
input-clock / 256, or it is used and programmed to same sane value.

> pwm_lpss_prepare() is buggy here, a request for a too low period should be
> refused.

So instead of clamping as is done in an earlier patch, we should return
-EINVAL ?  Only for too low periods, or also for too high periods ?

I must say this does worry me a bit, the VBT may request 200Hz output
frequency and some revisions of the PWM controller can do 283Hz as
lowest output freq. ATM we just give the i915 code the 283 Hz if it
request 200, that seems more sane then to give it -EINVAL, since -EINVAL
would require the i915 driver to know the exact limits of each PWM
controller and then to clamp the VBT value before passing it to the
PWM driver, that means moving knowledge out of the PWM driver into
the i915 code.

I believe that without first amending the PWM API too allow a consumer
to query the period min/max values, returning -EINVAL is not the right
thing to do here.

Regards,

Hans
