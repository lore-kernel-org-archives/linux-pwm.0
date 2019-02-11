From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 11 Feb 2019 13:29:54 +0100
Message-ID: <20190211122954.33thpip3yhtdw5x6@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
 <CAJ2_jOGYkwb2QSUH1UU_QoGXE5LFoR0XGJmuYfNtYcZXHXyfaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOGYkwb2QSUH1UU_QoGXE5LFoR0XGJmuYfNtYcZXHXyfaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Feb 11, 2019 at 04:56:27PM +0530, Yash Shah wrote:
> On Thu, Feb 7, 2019 at 3:47 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> > > +struct pwm_sifive_ddata {
> > > +     struct pwm_chip chip;
> > > +     struct notifier_block notifier;
> > > +     struct clk *clk;
> > > +     void __iomem *regs;
> > > +     unsigned int approx_period;
> > > +     unsigned int real_period;
> > > +};
> > > +
> > > +static inline struct pwm_sifive_ddata *to_pwm_sifive_chip(struct pwm_chip *c)
> >
> > even though this is inlined I would like this to have use the
> > pwm_sifive_ prefix, too.
> 
> Not sure what exactly you want me to do here.

I want this function to be named something like pwm_sifive_chip_to_ddata.
This way it has the common prefix (and is less confusing because
to..chip suggests that is converts something to a chip, but the outcome
is ...ddata).
 
> > In a previous review round I had doubts about the calculation of frac
> > and I think they were addressed wrongly.
> > Looking at the figure at the start of chapter 14.9 in the reference
> > manual: They use (different than the driver here) pwmcmp0=6 and
> > pwmzerocmp=1. Then a period is 7 clock cycles long and pwmcmpX must be 7
> > (for X > 0) to yield a 100% signal. So pwmcmpX must be greater than or
> > equal to the period (in clock cycles).
> >
> > Here we're using pwmzerocmp=0, still the constraint
> >
> >         pwmcmpX >= period
> >
> > must be true for a 100% cycle. (Right?) With pwmzerocmp=0 the period is
> > 0x10000 clock cycles, so pwmcmpX must be >= 0x10000 to yield a 100%
> > signal. As this is not possible (pwmcmpX is a 16 bit value that can only
> > hold up to 0xffff) the output cannot yield 100%.
> >
> > So I think the most correct implementation here is:
> >
> >         frac = (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 << PWM_SIFIVE_CMPWIDTH) / 2) / period;
> >         /* Sorry, we cannot do 100% :-( */
> >         frac = min(frac, (1 << PWM_SIFIVE_CMPWIDTH) - 1);
> >
> 
> I will once again go through the specs, if it seems correct I will
> implement the above.

I would just test this at runtime. Configure for 100% and check the wave
form if it is constant.

> > > +static int pwm_sifive_probe(struct platform_device *pdev)
> > > +{
> > > [...]
> > > +     /* Watch for changes to underlying clock frequency */
> > > +     pwm->notifier.notifier_call = pwm_sifive_clock_notifier;
> > > +     ret = clk_notifier_register(pwm->clk, &pwm->notifier);
> > > +     if (ret) {
> > > +             dev_err(dev, "failed to register clock notifier: %d\n", ret);
> > > +             goto disable_clk;
> > > +     }
> >
> > Would it make sense to only enable the clock when the pwm is enabled?
> > (If yes, how does the output behave if the clock is disabled while the
> > hardware is enabled? I assume the output just freezes at the state where
> > it happens to be?)
> 
> Yes. Not sure about the behaviour of hardware when the clock is disabled.
> The behaviour should be like you said. If there is no strong reason
> then we can keep it as it is right now
> or else if you want I can make the necessary change.

I would prefer to only have the clock enabled when it is actually used.
Note the common pitfall that you cannot disable the clk immediately
after configureing the duty cycle to 100% or 0% though because you must
only stop the clock when the newly configured parameters are active.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
