From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can find the
 pwm_backlight
Date: Wed, 8 Mar 2017 14:41:59 +0100
Message-ID: <1acd14d3-207d-2330-6d92-dc7113835025@redhat.com>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120095519.GF17297@lahna.fi.intel.com> <87varkhzt9.fsf@intel.com>
 <2fe8a18f-260a-c035-5424-e28bd0bd5c16@redhat.com> <87shmohy6j.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752820AbdCHNmb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Mar 2017 08:42:31 -0500
In-Reply-To: <87shmohy6j.fsf@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jani Nikula <jani.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-pwm@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hi,

On 08-03-17 11:15, Jani Nikula wrote:
> On Wed, 08 Mar 2017, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 08-03-17 10:40, Jani Nikula wrote:
>>> On Fri, 20 Jan 2017, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
>>>> On Fri, Jan 20, 2017 at 10:02:50AM +0200, Jani Nikula wrote:
>>>>> That said, I suppose there could be an alternative to handling pwm_get()
>>>>> failures at probe. We could just go on with our init, but schedule a
>>>>> retry later. Perhaps a bit hacky, but it would address both of the
>>>>> concerns above. Again, this patch seems a simple workaround in the mean
>>>>> time.
>>>>
>>>> Not sure if this works or how hacky it is, but can't you
>>>> request_module() before you start looking up for the pwm?
>>>
>>> I eyeballed this a little, and noticed:
>>>
>>> drivers/acpi/acpi_lpss.c:
>>>
>>> static struct pwm_lookup bsw_pwm_lookup[] = {
>>> 	PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
>>> 			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
>>> 			       "pwm-lpss-platform"),
>>> };
>>>
>>> drivers/mfd/intel_soc_pmic_core.c:
>>>
>>> static struct pwm_lookup crc_pwm_lookup[] = {
>>> 	PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_backlight", 0, PWM_POLARITY_NORMAL),
>>> };
>>>
>>> Should crc_pwm_lookup also use PWM_LOOKUP_WITH_MODULE? And which module
>>> exactly? pwm_get() does an automatic request_module(), if the module is
>>> given.
>>>
>>> And will this still be enough?
>>
>> I was thinking about this a couple of days ago, unfortunately the
>> situation with pwm_crc is more complicated as that is part of
>> an i2c mfd device, so both the i2c-adapter driver and the mfd driver
>> (intel_soc_pmic_crc) need to be builtin currently the mfd driver
>> cannot be modular, but the i2c-adapter driver can (and on most
>> Linux distribution kernels is) configured to be modular.
>>
>> So just doing request module for pwm-crc is not going to help
>> since the i2c-adapter driver may not yet have loaded / initialized.
>>
>> All in all we really need to find a way to figure out if we will need
>> to do a pwm_get earlier on during i915 initialization (by moving the
>> VBT parsing to earlier, or at least part of it) and do the pwm_get
>> before we do anything i-reversible and if it fails then return
>> -EPROBE_DEFER. Then we can make pwm_crc modular as well as all of
>> intel_soc_pmic* as it really should be.
>
> The other alternatives are:
>
> 1) Handle defers using a workqueue within i915. It's a bit tedious, but
> I didn't spot any show stoppers with the approach. We'd register a
> non-functional backlight interface until the pwm_get() succeeds.

Ack, although I would prefer for i915 just to properly at deferred
probing handling instead of this hack. But if doing the VBT parsing
earlier so we know in advance if we will need the pwm or not turns
out to be really tricky we could go with this instead.

> 2) Rip out pwm backlight from i915 altogether, and turn it into a
> separate platform backlight that uses pwm. I think there's ready
> infrastructure for that. It's not without problems, though, as then we
> lose control over the sequence in which backlight gets enabled/disabled.

Yeah, not a fan of this.

Regards,

Hans
