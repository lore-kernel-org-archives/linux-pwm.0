From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Re: pwm: atmel: PWM may not properly disable
Date: Fri, 13 May 2016 13:14:59 +0200
Message-ID: <CABDcavYDRwtPnSB1Hcyg2E0Jn+D8vUwFo986Kdhh6FaC0TOSKg@mail.gmail.com>
References: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
	<20160511133905.GA15651@ulmo.ba.sec>
	<CABDcavZi6ofS5YUTicV8EeASMn1gG8J9X5KZidkxCf=aVZXEFg@mail.gmail.com>
	<CABDcavYxH2B34vtAdVz=173A0Z0iEY7aNZJ1paFAt8xan5B1MQ@mail.gmail.com>
	<CABDcavZv3KSz4a5s3f5iusF6rCnyT2-10HCR1Ns5SaJuAwptxQ@mail.gmail.com>
	<20160512121402.GA26824@ulmo.ba.sec>
	<CABDcavb73Ak7HX-1G1tpadahW8tgA1aC4cHjz3_9L6wCRqi3Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33332 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbcEMLPB (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 13 May 2016 07:15:01 -0400
In-Reply-To: <CABDcavb73Ak7HX-1G1tpadahW8tgA1aC4cHjz3_9L6wCRqi3Cw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Hello,

2016-05-12 15:24 GMT+02:00 Guillermo Rodriguez Garcia
<guille.rodriguez@gmail.com>:
> 2016-05-12 14:14 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
>> On Thu, May 12, 2016 at 01:49:12PM +0200, Guillermo Rodriguez Garcia wrote:
>>> Hello,
>>>
>>> [...]
>>> >>> One thing that I'd request is that instead of the cpu_relax() you use a
>>> >>> usleep_range() within the loop instead. I assume it can potentially take
>>> >>> a long time for the current period to finish, so busy looping isn't such
>>> >>> a great idea. You could possibly use the current period_ns to derive a
>>> >>> meaningful value to pass to usleep_range().
>>> >>
>>> >> I am not sure yet but I believe disabling does not really need to wait for the
>>> >> current period to finish (at least the datasheets do not mention this anywhere).
>>> >> I think that the after writing to PWM_DIS, the actual disable operation is
>>> >> initiated immediately in the PWM subsystem, but is executed asynchronously
>>> >> and requires the pwm_clk to complete. If this assumption is correct, perhaps
>>> >> it is enough to do one single read from PWM_SR so that the disable operation
>>> >> has had the chance to propagate. This is again assuming that all operations
>>> >> are executed sequentially within the PWM subsystem.
>>> >>
>>> >> If the above is correct, then we would not need a loop at all.
>>> >
>>> > I was wrong. The required delay indeed seems to depend on the current PWM
>>> > frequency, suggesting that indeed disabling does not take effect until
>>> > the current
>>> > period is finished.
>>> >
>>> > I will prepare a patch using usleep_range instead of cpu_relax.
>>>
>>> I have found a problem while preparing this. If I use usleep_range I
>>> keep running
>>> into "BUG: scheduling while atomic". This is because I am using the PWM to
>>> drive a buzzer with pwm-beeper, and pwm-beeper currently crashes if the PWM
>>> driver sleeps. Apparently this patch is needed:
>>>
>>> https://lkml.org/lkml/2016/2/22/757
>>>
>>> However this has not been merged yet.
>>>
>>> How should I proceed ?
>>
>> The PWM API really shouldn't be used within atomic contexts. There was a
>> change recently that marked all of the PWM devices as "might sleep". The
>> reason for the change was that we introduced a mutex in pwm_enable() and
>> hence every user would have to deal with this eventually. That mutex has
>> since been removed again, but the fact remains that users shouldn't
>> assume that a PWM can be used in atomic context, because the PWM chip
>> could equally well be behind a slow bus such as I2C and hence sleep for
>> every register access.
>>
>> So the correct thing to do would be to follow what leds-pwm did and
>> implement a workqueue. Also might as well make it the only code path as
>> Dmitry suggested in the linked thread, I don't see any point in any kind
>> of fast path here.
>
> I understand. So I assume this pwm-beeper patch will be merged sooner
> or later.
>
> The reason why I was asking is that if I patch the Atmel PWM driver in
> order to use usleep_range in pwm_disable, then pwm-beeper will not work
> anymore on Atmel platforms until the pwm-beeper patch is merged.
> I was not sure about the status of the pwm-beeper patch (the last message
> in the linked thread is from March 30), hence my question.
>
> I'll go ahead with the Atmel PWM patch then.

I have just submitted a patch.

By the way, the following article in Atmel's KB indicates that writing
to PWM_DIS
is not enough for the channel to be effectively disabled -- the PWM_SR register
must be polled until the corresponding bit goes to 0.

It does not explicitly mention that the actual disabling happens at
the end of the
current period, although my tests seem to suggest that this is indeed the case.

http://atmel.force.com/support/articles/en_US/FAQ/Why-PWM-Channel-Polarity-Inversion

As mentioned in my previous mail, this patch fixes the disabling of PWM channels
in the Atmel PWM driver, but it immediately exposes the problem in pwm-beeper
when running on Atmel platforms (https://lkml.org/lkml/2016/2/22/757).

Best,

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
