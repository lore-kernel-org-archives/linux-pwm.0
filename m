From: Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Subject: Re: pwm: atmel: PWM may not properly disable
Date: Thu, 12 May 2016 13:49:12 +0200
Message-ID: <CABDcavZv3KSz4a5s3f5iusF6rCnyT2-10HCR1Ns5SaJuAwptxQ@mail.gmail.com>
References: <CABDcavZXCGWGajRucaFztg98KCoUi-bLxV1fj+j8mW+WdSuLBQ@mail.gmail.com>
	<20160511133905.GA15651@ulmo.ba.sec>
	<CABDcavZi6ofS5YUTicV8EeASMn1gG8J9X5KZidkxCf=aVZXEFg@mail.gmail.com>
	<CABDcavYxH2B34vtAdVz=173A0Z0iEY7aNZJ1paFAt8xan5B1MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34026 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbcELLtN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 May 2016 07:49:13 -0400
In-Reply-To: <CABDcavYxH2B34vtAdVz=173A0Z0iEY7aNZJ1paFAt8xan5B1MQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Hello,

[...]
>>> One thing that I'd request is that instead of the cpu_relax() you use a
>>> usleep_range() within the loop instead. I assume it can potentially take
>>> a long time for the current period to finish, so busy looping isn't such
>>> a great idea. You could possibly use the current period_ns to derive a
>>> meaningful value to pass to usleep_range().
>>
>> I am not sure yet but I believe disabling does not really need to wait for the
>> current period to finish (at least the datasheets do not mention this anywhere).
>> I think that the after writing to PWM_DIS, the actual disable operation is
>> initiated immediately in the PWM subsystem, but is executed asynchronously
>> and requires the pwm_clk to complete. If this assumption is correct, perhaps
>> it is enough to do one single read from PWM_SR so that the disable operation
>> has had the chance to propagate. This is again assuming that all operations
>> are executed sequentially within the PWM subsystem.
>>
>> If the above is correct, then we would not need a loop at all.
>
> I was wrong. The required delay indeed seems to depend on the current PWM
> frequency, suggesting that indeed disabling does not take effect until
> the current
> period is finished.
>
> I will prepare a patch using usleep_range instead of cpu_relax.

I have found a problem while preparing this. If I use usleep_range I
keep running
into "BUG: scheduling while atomic". This is because I am using the PWM to
drive a buzzer with pwm-beeper, and pwm-beeper currently crashes if the PWM
driver sleeps. Apparently this patch is needed:

https://lkml.org/lkml/2016/2/22/757

However this has not been merged yet.

How should I proceed ?

Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
