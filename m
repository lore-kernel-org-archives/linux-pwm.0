From: Daniel Drake <drake@endlessm.com>
Subject: Re: pwm-samsung: incorrect register values for 100% duty cycle
Date: Thu, 2 Oct 2014 13:27:00 -0600
Message-ID: <CAD8Lp46mjChkpNmGvUy+P9ZzKU5yoVBd7A-FLfobFx110-5DQg@mail.gmail.com>
References: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>
	<542BDDBD.1070708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <542BDDBD.1070708@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi,

Thanks for looking into this.

On Wed, Oct 1, 2014 at 4:55 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> I think that comment is incorrect. If tcmp is written as -1UL then the
>> LED totally turns off. And there is nothing in the Exynos4412 manual
>> to suggest that -1UL should be set in the TCMP register for 100% duty.
>
> Looking at Figure 11-3 in 11.3.2 Basic Timer Operation chapter of Exynos
> 4412 public datasheet [1] (page 659), the calculation above seems
> correct. The default state of timer output is high and if TCMP is set to
> a value higher than TCNT, then it will never toggle to low.
>
> [1]
> http://www.samsung.com/global/business/semiconductor/file/product/Exynos_4_Quad_User_Manaul_Public_REV1.00-0.pdf

I read that diagram a bit differently.
The default state of the output is high, but that is while PWM is
"inactive". It goes low at the point when the timer starts, and it
also goes low when the timer later restarts every time. So once we
enable PWM the output should be low.
It will go high once TCMP == TCNT, but because TCMP is placed at the
maximum value which is never hit, that will never happen, so the LED
stays off.

But I am confused on a few counts here...

I may have identified above why a maximum TCMP value would not result
in the output going high, but then why does the rest of the brightness
scale work? If I set brightness 200 (tcmp=6470, tcnt=29999) then the
LED is on dimly. If I set brightness 254 (tcmp=117, tcnt=29999) then
the LED comes on much brighter. But according to my above explanation
and looking at the diagram you referenced, such a decrease in the tcmp
value would result in a shorter time for which the output is high,
i.e. lower brightness, but actually the brightness increases.

If the output is high by default, why don't I see the LED turning on
in uboot before Linux has even loaded?

Does the above diagram really apply to Linux? Because Linux sets the
invert bit for all the channels in pwm_samsung_probe. So maybe that
diagram is irrelevant until we invert the TOUT signal shown there?

Daniel
