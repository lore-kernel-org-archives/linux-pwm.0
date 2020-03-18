From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Date: Wed, 18 Mar 2020 10:10:37 +0530
Message-ID: <12f9a721-efd5-d5c0-1468-995b5674ff13@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
 <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46840 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgCRElg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 00:41:36 -0400
In-Reply-To: <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>, kernel@pengutronix.de

Hi Uwe,

On 12/03/20 4:14 PM, Lokesh Vutla wrote:
> Hi Uwe,
> 
> On 12/03/20 2:17 PM, Uwe Kleine-König wrote:
>> On Thu, Mar 12, 2020 at 01:35:32PM +0530, Lokesh Vutla wrote:
>>> On 12/03/20 12:10 PM, Uwe Kleine-König wrote:
>>>> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
>>>>> Only the Timer control register(TCLR) cannot be updated when the timer
>>>>> is running. Registers like Counter register(TCRR), loader register(TLDR),
>>>>> match register(TMAR) can be updated when the counter is running. Since
>>>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>>>>> timer for period/duty_cycle update.
>>>>
>>>> I'm not sure what is sensible here. Stopping the PWM for a short period
>>>> is bad, but maybe emitting a wrong period isn't better. You can however
>>>> optimise it if only one of period or duty_cycle changes.
>>>>
>>>> @Thierry, what is your position here? I tend to say a short stop is
>>>> preferable.
>>>
>>> Short stop has side effects especially in the case where 1PPS is generated using
>>> this PWM. In this case where PWM period is continuously synced with PTP clock,
>>> cannot expect any breaks in PWM. This doesn't fall in the above limitations as
>>> well. as duty_cycle is not a worry and only the rising edge is all that matters.
>>>
>>> Also any specific reason why you wanted to stop rather than having the mentioned
>>> limitation? it is just a corner anyway and doesn't happen all the time.
>>
>> I'm a bit torn here. Which of the two steps out of line is worse depends
>> on what is driven by the PWM in question. And also I think ignoring
>> "just corner cases" is a reliable way into trouble.
> 
> I do agree that corner cases should not be ignored. But in this particular
> driver, just trying to explain the effect of this corner case. On dynamic pwm
> period update, the current pwm cycle might generate a period with mixed
> settings. IMHO, it is okay to live with it and mark it as a limitation as you
> pointed out in case of sifive driver[0].

Not sure what is the conclusion here. If there are no objections on this series,
can it be merged?

Thanks and regards,
Lokesh

> 
> 
>>
>> The usual PWM contributer (understandably) cares mostly about their own
>> problem they have to solve. If however you take a step back and care
>> about the PWM framework as a whole to be capable to solve problems in
>> general, such that any consumer just has to know that there is a PWM and
>> start requesting specific settings for their work to get done, it gets
>> obvious that you want some kind of uniform behaviour of each hardware
>> driver. And then a short inactive break between two periods is more
>> common and better understandable than a mixed period.
> 
> But the problem here is that inactive breaks between two periods is not desired.
> Because the pwm is used to generate a 1PPS signal and is continuously
> synchronized with PTP clock.
> 
> I am up if this can be solved generically. But updating period is very specific
> to hardware implementation. Not sure what generic solution can be brought out of
> this. Please correct me if I am wrong.
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-sifive.c#n7
> 
> Thanks and regards,
> Lokesh
> 
