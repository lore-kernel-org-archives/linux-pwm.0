From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Tue, 7 Jul 2020 21:41:35 +0200
Message-ID: <0e79b176-7e58-7ecb-0f82-ebfd0c777af3@redhat.com>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
 <1496178b-ce39-9285-ff75-cd39bc0e9aa7@redhat.com>
 <20200707190955.e7wzmphdgi5reeyg@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726951AbgGGTll (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 15:41:41 -0400
Received: by mail-ed1-f71.google.com with SMTP id m12so54276217edv.3
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2020 12:41:38 -0700 (PDT)
In-Reply-To: <20200707190955.e7wzmphdgi5reeyg@pengutronix.de>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de

Hi,

On 7/7/20 9:09 PM, Uwe Kleine-König wrote:
> Hello Hans,
> 
> On Tue, Jul 07, 2020 at 07:31:29PM +0200, Hans de Goede wrote:
>> On 7/7/20 9:34 AM, Uwe Kleine-König wrote:
>>> On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
>>>> But if we do then I think closest to the truth would be:
>>>>
>>>> state->period     = UINT_MAX;
>>>> state->duty_cycle = 0;
>>>
>>> I'd say state->period = 1 & state->duty_cycle = 0 is a better
>>> representation.
>>
>> But that would suggest the output is configured for an
>> infinitely high output frequency, but the frequency is
>> actually 0, the reason why get_state needs to treat a
>> base_unit val of 0 special at all is to avoid a division
>> by 0, and in math dividing by 0 gives infinite, isn't
>> UINT_MAX a better way to represent infinity ?
> 
> Given that duty_cycle is 0, how can to tell anything about the period
> when only seeing the signal (= a constant low)?
> 
> Given that (ideally) a period is completed when pwm_apply_state() is
> called, a short period is much more sensible.

Ok, I will add a patch to v4 of the patch-set to adjust the pwm-lpss
driver's get_state method accordingly.

Regards,

Hans
