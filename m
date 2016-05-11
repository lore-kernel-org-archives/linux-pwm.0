From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Re: pwm: atmel: PWM may not properly disable
Date: Wed, 11 May 2016 16:31:44 +0200
Message-ID: <CABDcavZi6ofS5YUTicV8EeASMn1gG8J9X5KZidkxCf=aVZXEFg@mail.gmail.com>
References: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
	<20160511133905.GA15651@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35180 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbcEKObp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 May 2016 10:31:45 -0400
In-Reply-To: <20160511133905.GA15651@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Hello,

2016-05-11 15:39 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> On Wed, May 11, 2016 at 10:48:38AM +0200, Guillermo Rodriguez Garcia wrote:
>> Hello all,
>>
>> I am seeing a problem with the atmel-pwm driver where disabling a PWM
>> channel sometimes leaves the output at the wrong level ("wrong" == not
>> idle, as per the configured polarity). This causes problems when the
>> PWM is used to drive a LED or certain types of buzzers.
>>
>> The issue seems to be in the atmel_pwm_disable function [1], which
>> disables the clock immediately after writing to the PWM_DIS register.
>> As a result, the write does not seem to take effect.
>>
>> I have verified that this is the cause of the problem this by waiting
>> until the channel is effectively disabled (by checking the PWM_SR
>> register) before disabling the clock. This fixes the issue and the PWM
>> output now stays at the idle level after the channel is disabled.
>>
>> For the above I used a modified version of a patch that was posted to
>> the list some time ago [2]. Note that only atmel_pwm_disable needs to
>> be patched, there seems to be no need to patch atmel_pwm_enable. The
>> code is as follows:
>>
>>      atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
>> +    while (atmel_pwm_readl(atmel_pwm, PWM_SR) & (1 << pwm->hwpwm)) {
>> +        cpu_relax();
>> +    }
>>
>>      clk_disable(atmel_pwm->clk);
>>
>> Is this acceptable? Should I submit an updated patch?
>>
>>  [1]: http://lxr.free-electrons.com/source/drivers/pwm/pwm-atmel.c#L253
>>  [2]: https://lkml.org/lkml/2014/10/1/605
>>
>> (If possible, please CC me in any replies)
>
> Okay, so the above makes a lot more sense than Robert's original patch.
> The biggest issue that stuck out at the time was that the code kept
> writing to the PWM_DIS register. Your example shows that PWM_SR is the
> status register and your loop shows that it's enough to simply wait for
> the PWM to become enabled (Robert's patch suggested that writes to
> PWM_DIS might not make it through, and hence they had to be repeated).
>
> As for atmel_pwm_enable() I'm tempted to request a similar change. The
> reason is that the PWM API expects (though it isn't technically enforced
> in any way) that the PWM output is enabled after the function exits. It
> seems reasonable to me that disabling would take a while (the remainder
> of the current period for example) whereas enabling might always be
> immediate. As such it wouldn't be technically necessary to have the loop
> so I'm not going to insist if everything indicates the above is indeed
> how the hardware works.
>
> One thing that I'd request is that instead of the cpu_relax() you use a
> usleep_range() within the loop instead. I assume it can potentially take
> a long time for the current period to finish, so busy looping isn't such
> a great idea. You could possibly use the current period_ns to derive a
> meaningful value to pass to usleep_range().

I am not sure yet but I believe disabling does not really need to wait for the
current period to finish (at least the datasheets do not mention this anywhere).
I think that the after writing to PWM_DIS, the actual disable operation is
initiated immediately in the PWM subsystem, but is executed asynchronously
and requires the pwm_clk to complete. If this assumption is correct, perhaps
it is enough to do one single read from PWM_SR so that the disable operation
has had the chance to propagate. This is again assuming that all operations
are executed sequentially within the PWM subsystem.

If the above is correct, then we would not need a loop at all.

Let me do some checks on this and I'll come back with my findings.

>
> Otherwise it'd be great if you submitted this again. Also make sure to
> use a proper commit message as I suggested in a response to Robert's
> original patch.

Perfect, will do.

Thank you,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
