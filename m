From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in
 lpc32xx_pwm_disable
Date: Wed, 22 Jun 2016 18:10:10 +0300
Message-ID: <5d139118-5b9c-954c-3f3c-310c1a7342f5@mleia.com>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <20160622123222.GD26943@ulmo.ba.sec> <1466601964.5316.19.camel@localhost>
 <20160622143650.GO26943@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:41382 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcFVPKO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 22 Jun 2016 11:10:14 -0400
In-Reply-To: <20160622143650.GO26943@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org

Hi Thierry,

On 22.06.2016 17:36, Thierry Reding wrote:
> On Wed, Jun 22, 2016 at 09:26:04AM -0400, Sylvain Lemieux wrote:
>> Hi Thierry,
>>
>> On Wed, 2016-06-22 at 14:32 +0200, Thierry Reding wrote:
>>> On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
>>>> From: Sylvain Lemieux <slemieux@tycoint.com>
>>>>
>>>> If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the kernel
>>>> disable the PWM, the PWM output is always set as a logic 1.
>>>
>>> I presume there's a reason why the bootloader set this bit to 1. Why do
>>> you assume it's the right thing to clear it?
>>>
>> There is an alternative mode for the PWM output pin; using the 
>> PWM_PIN_LEVEL bit to control the PWM output (logical 0 or 1 on 
>> output) when the PWM is disable.
>>
>> In this case, the bootloader is using the PWM_PIN_LEVEL bit
>> to control the PWM output (always 1) to enable the LCD; the 
>> application is using the PWM to control the intensity of the 
>> LCD output. When disabling the PWM, the line level should be 
>> setup to 0.
> 
> But doesn't that mean that if the pin is used in PWM mode there's never
> a use-case for having it go high when disabled? Given that this is a PWM
> driver I don't see how we'd ever be in the case where the alternate
> setting makes sense.
> 

to some extend when PWM is disabled, both options of pin output high
and low level values are valid if we consider variable PWM polarity
setting in general, however this particular controller does not have
this control and thus there is no need to extend it to 2-cell type.

Another alternative to avoid a new property may be to extend period_ns
to its apparently valid boundaries - 0 and duty_ns, both options are not
supported properly in the driver at the moment. But then the question
what to do with it on boot is still open, just leaving it untouched
is nondeterministic in my opinion.

>> A version 2 of this patch will be send with support to select 
>> the alternate PWM disable level high from the device tree.
>>
>> For details, you can refer to:
>> http://thread.gmane.org/gmane.linux.pwm/3882/focus=508758
> 
> Given the above I don't think we should add this new device tree
> property until we encounter a setup where it's needed.
> 

--
With best wishes,
Vladimir
