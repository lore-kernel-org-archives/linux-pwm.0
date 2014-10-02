From: Daniel Drake <drake@endlessm.com>
Subject: Re: pwm-samsung: incorrect register values for 100% duty cycle
Date: Thu, 2 Oct 2014 14:20:00 -0600
Message-ID: <CAD8Lp44Nn5O-J_d0QuAittL92mNnpeJuye709opTEXbvd6ySuQ@mail.gmail.com>
References: <CAD8Lp46rh80KD=jXoGTLt2SzH+zfnuyd=QHrKZncx+YYCp-8dA@mail.gmail.com>
	<542BDDBD.1070708@gmail.com>
	<CAD8Lp46mjChkpNmGvUy+P9ZzKU5yoVBd7A-FLfobFx110-5DQg@mail.gmail.com>
	<542DAC5F.90309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <542DAC5F.90309@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Oct 2, 2014 at 1:49 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> This is strange. I remember verifying various edge cases with a scope on
> an Exynos4210-based Origen board and I don't recall any issues.
> Unfortunately I don't have appropriate hardware to recheck this specific
> case anymore.
>
> Could you specify on what board you are testing this or how the LED is
> wired?

Its a new board prototype with Exynos4412. The PWM output connects to
a APL5606AKI-TRG chip which does AC-to-DC conversion and multiplies
the voltage, and outputs to a simple LED.

Not the easiest unknown setup to work with, I know. I'll get hold of a
multimeter and try to get a better understanding of what is happening.
You've given me a few ideas.

Thanks
Daniel
