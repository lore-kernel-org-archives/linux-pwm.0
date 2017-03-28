From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH REGRESSION-FIX resend] pwm: lpss: Set enable-bit before
 waiting for update-bit
Date: Tue, 28 Mar 2017 21:16:06 +0200
Message-ID: <f2687abf-1fbb-de12-ab1f-be5056cddb70@redhat.com>
References: <20170325140658.26868-1-hdegoede@redhat.com>
 <1490712327.708.30.camel@linux.intel.com>
 <d24997bc-9afc-00ec-425d-92a2d48ec2c6@redhat.com>
 <1490722132.708.43.camel@linux.intel.com>
 <1490722434.708.45.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754821AbdC1TQ2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Mar 2017 15:16:28 -0400
In-Reply-To: <1490722434.708.45.camel@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, "Koskinen, Ilkka" <ilkka.koskinen@intel.com>

Hi,

On 03/28/2017 07:33 PM, Andy Shevchenko wrote:
> On Tue, 2017-03-28 at 20:28 +0300, Andy Shevchenko wrote:
>> On Tue, 2017-03-28 at 19:20 +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 03/28/2017 04:45 PM, Andy Shevchenko wrote:
>>>> On Sat, 2017-03-25 at 15:06 +0100, Hans de Goede wrote:
>>>>> Hi Andy, Thierry,
>>>>>
>>>>> This patch fixes a regression with the pwm-lpss driver in 4.11,
>>>>> where it once turned off will not turn back on again on some
>>>>> machines. Yet it has been silent around this patch for some
>>>>> time now. Can you please review this and get it queued as a fix
>>>>> for 4.11 ?
>>>>
>>>> I have tested this patch (*) on 3 boards:
>>>> 1) internal development board (ApolloLake)
>>>> 2) MinnowBoard MAX (BayTrail)
>>>> 3) Intel Edison / Arduino break out (Tangier)
>>>> 4) ...not yet... (CherryTrail / Braswell)
>>>>
>>>> So, the patch *broke* functionality on 1), while 2) and 3) are
>>>> survived.
>>>
>>> Bummer, so on Apollo Lake we need to set the update bit
>>> *and* wait for it to get acked before setting enable ?
>>
>> It's designed behaviour as far as I know.
>>
>> Let me cite a bit of documentation (the wordings is the same across
>> *all* supported Intel SoCs):
>>
>> --- 8< --- 8< ---
>>
>> 9.8.2 Programming Sequence
>> To ensure that there are no operational issues with PWM the following
>> programming sequences must be performed in the order defined.
>>
>> • Initial Enable or First Activation
>> — Program the Base Unit and On Time Divisor values
>> — Set the Software Update Bit
>> — Enable the PWM Output by setting the PWM Enable bit
>> — Repeat the above steps for the next PWM module
>>
>> • Dynamic update while PWM is Enabled
>> — Program the Base Unit and On Time Divisor values
>> — Set the Software Update Bit
>> — Repeat the above steps for the next PWM module
>>
>> --- 8< --- 8< ---
>>
>> (I'm a bit confused about last item in each list, it doesn't clarify
>> should we use _same_ values or different ones. I hope it just a
>> recommendation how to program multiple PWMs, not an *obligation*)
>>
>
> Missed additional part
>
> --- 8< --- 8< ---
>
> 9.8.1 Functional Description
> Software controls the PWM block by updating the PWMCTRL register and
> setting the sw_update bit whenever a change in frequency or duty cycle
> of the PWM output signal is required. When the sw_update bit is set the
> PWM block applies the new settings at the start of the next output cycle
> and resets the sw_update bit.
>
> --- 8< --- 8< ---

Right, notice the "pplies the new settings at the start of the next output cycle"
with the enable bit not set the next cycle never starts, at least that seems to
be the case on Cherry Trail.

Regards,

Hans

>
