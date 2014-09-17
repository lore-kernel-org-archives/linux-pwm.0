From: Daniel Drake <drake@endlessm.com>
Subject: pwm-samsung: incorrect register values for 100% duty cycle
Date: Wed, 17 Sep 2014 17:42:09 -0600
Message-ID: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hi,

I'm using pwm-samsung on Exynos4412 for a variable-brightness LED.

When the LED is set to maximum brightness via the pwm-leds driver, we
arrive at pwm_samsung_config with duty_ns = period_ns, i.e. 100% duty
cycle.

This function does:

    /* -1UL will give 100% duty. */
    --tcmp;
    writel(tcmp, our_chip->base + REG_TCMPB(pwm->hwpwm));

I think that comment is incorrect. If tcmp is written as -1UL then the
LED totally turns off. And there is nothing in the Exynos4412 manual
to suggest that -1UL should be set in the TCMP register for 100% duty.

If I remove that --tcmp line, so that 100% duty cycle is handled as
tcmp=0, the problem is solved: the LED turns on at max brightness when
the leds subsystem requests so.

Any ideas? Is this -1UL thing a quirk from older chip versions not
applicable to Exynos4?

Thanks
Daniel
