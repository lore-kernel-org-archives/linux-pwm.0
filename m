From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: pwm-samsung: incorrect register values for 100% duty cycle
Date: Wed, 01 Oct 2014 12:55:57 +0200
Message-ID: <542BDDBD.1070708@gmail.com>
References: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:41685 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAK4B (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Oct 2014 06:56:01 -0400
In-Reply-To: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

Hi Daniel,

On 18.09.2014 01:42, Daniel Drake wrote:
> Hi,
> 
> I'm using pwm-samsung on Exynos4412 for a variable-brightness LED.
> 
> When the LED is set to maximum brightness via the pwm-leds driver, we
> arrive at pwm_samsung_config with duty_ns = period_ns, i.e. 100% duty
> cycle.
> 
> This function does:
> 
>     /* -1UL will give 100% duty. */
>     --tcmp;
>     writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));
> 
> I think that comment is incorrect. If tcmp is written as -1UL then the
> LED totally turns off. And there is nothing in the Exynos4412 manual
> to suggest that -1UL should be set in the TCMP register for 100% duty.

Looking at Figure 11-3 in 11.3.2 Basic Timer Operation chapter of Exynos
4412 public datasheet [1] (page 659), the calculation above seems
correct. The default state of timer output is high and if TCMP is set to
a value higher than TCNT, then it will never toggle to low.

[1]
http://www.samsung.com/global/business/semiconductor/file/product/Exynos_4_Quad_User_Manaul_Public_REV1.00-0.pdf

> 
> If I remove that --tcmp line, so that 100% duty cycle is handled as
> tcmp=0, the problem is solved: the LED turns on at max brightness when
> the leds subsystem requests so.

According to my computations, with tcmp=0 you should get exactly the
minimum supported duty cycle (1 / N, where N is the number of ticks of
period), not full brightness. Are you sure that you have the right
output polarity configured?

> 
> Any ideas? Is this -1UL thing a quirk from older chip versions not
> applicable to Exynos4?

Comparing few datasheets, the timers seem identical in this aspect.

Best regards,
Tomasz
