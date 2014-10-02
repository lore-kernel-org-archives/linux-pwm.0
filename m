From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: pwm-samsung: incorrect register values for 100% duty cycle
Date: Thu, 02 Oct 2014 21:49:51 +0200
Message-ID: <542DAC5F.90309@gmail.com>
References: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>	<542BDDBD.1070708@gmail.com> <CAD8Lp46mjChkpNmGvUy+P9ZzKU5yoVBd7A-FLfobFx110-5DQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:51258 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbaJBTty (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Oct 2014 15:49:54 -0400
In-Reply-To: <CAD8Lp46mjChkpNmGvUy+P9ZzKU5yoVBd7A-FLfobFx110-5DQg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

On 02.10.2014 21:27, Daniel Drake wrote:
> Hi,
> 
> Thanks for looking into this.
> 
> On Wed, Oct 1, 2014 at 4:55 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> I think that comment is incorrect. If tcmp is written as -1UL then the
>>> LED totally turns off. And there is nothing in the Exynos4412 manual
>>> to suggest that -1UL should be set in the TCMP register for 100% duty.
>>
>> Looking at Figure 11-3 in 11.3.2 Basic Timer Operation chapter of Exynos
>> 4412 public datasheet [1] (page 659), the calculation above seems
>> correct. The default state of timer output is high and if TCMP is set to
>> a value higher than TCNT, then it will never toggle to low.
>>
>> [1]
>> http://www.samsung.com/global/business/semiconductor/file/product/Exynos_4_Quad_User_Manaul_Public_REV1.00-0.pdf
> 
> I read that diagram a bit differently.
> The default state of the output is high, but that is while PWM is
> "inactive". It goes low at the point when the timer starts, and it
> also goes low when the timer later restarts every time. So once we
> enable PWM the output should be low.

That's right. I believe this should match what I wrote in my mail.

> It will go high once TCMP == TCNT, but because TCMP is placed at the
> maximum value which is never hit, that will never happen, so the LED
> stays off.

Right. Although all the levels above don't take into account state of
the inverter. What's shown on the diagram in the datasheet is with
inverter disabled, which corresponds to Linux's PWM_POLARITY_INVERSED.

> 
> But I am confused on a few counts here...
> 
> I may have identified above why a maximum TCMP value would not result
> in the output going high, but then why does the rest of the brightness
> scale work? If I set brightness 200 (tcmp=6470, tcnt=29999) then the
> LED is on dimly. If I set brightness 254 (tcmp=117, tcnt=29999) then
> the LED comes on much brighter. But according to my above explanation
> and looking at the diagram you referenced, such a decrease in the tcmp
> value would result in a shorter time for which the output is high,
> i.e. lower brightness, but actually the brightness increases.

This is strange. I remember verifying various edge cases with a scope on
an Exynos4210-based Origen board and I don't recall any issues.
Unfortunately I don't have appropriate hardware to recheck this specific
case anymore.

Could you specify on what board you are testing this or how the LED is
wired?

> 
> If the output is high by default, why don't I see the LED turning on
> in uboot before Linux has even loaded?

Most likely because u-boot doesn't switch the pinmux from default input
to respective special function.

> 
> Does the above diagram really apply to Linux? Because Linux sets the
> invert bit for all the channels in pwm_samsung_probe. So maybe that
> diagram is irrelevant until we invert the TOUT signal shown there?

The diagram illustrates how the hardware works. It shows TOUT levels
without inverter enabled. Still, the inverter simply negates the signal,
so the diagram is applicable, just with the exception that you need to
consider the output inverted.

Best regards,
Tomasz
