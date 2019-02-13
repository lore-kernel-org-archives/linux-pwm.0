From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 13 Feb 2019 18:39:31 +0100
Message-ID: <20190213173931.bhw74djming5oil6@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
 <CAJ2_jOGYkwb2QSUH1UU_QoGXE5LFoR0XGJmuYfNtYcZXHXyfaA@mail.gmail.com>
 <20190211122954.33thpip3yhtdw5x6@pengutronix.de>
 <20190213123405.GD647@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190213123405.GD647@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 13, 2019 at 01:34:05PM +0100, Thierry Reding wrote:
> On Mon, Feb 11, 2019 at 01:29:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > On Mon, Feb 11, 2019 at 04:56:27PM +0530, Yash Shah wrote:
> > > On Thu, Feb 7, 2019 at 3:47 PM Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> > > > > +struct pwm_sifive_ddata {
> > > > > +     struct pwm_chip chip;
> > > > > +     struct notifier_block notifier;
> > > > > +     struct clk *clk;
> > > > > +     void __iomem *regs;
> > > > > +     unsigned int approx_period;
> > > > > +     unsigned int real_period;
> > > > > +};
> > > > > +
> > > > > +static inline struct pwm_sifive_ddata *to_pwm_sifive_chip(struct=
 pwm_chip *c)
> > > >
> > > > even though this is inlined I would like this to have use the
> > > > pwm_sifive_ prefix, too.
> > > =

> > > Not sure what exactly you want me to do here.
> > =

> > I want this function to be named something like pwm_sifive_chip_to_ddat=
a.
> > This way it has the common prefix (and is less confusing because
> > to..chip suggests that is converts something to a chip, but the outcome
> > is ...ddata).
> =

> We've got plenty of these cast functions that are named to_*(). I would
> argue that naming this one differently is confusing.

The benefit of consistenly use a common prefix for all functions of a
driver is that applying a filter when tracing is much easier. Sure, you
could argue that this function is inlined and too trivial to care about
in a trace. Recommending to not make any exceptions to the "common
prefix" rule is easier though than to judge all functions that don't use
it if it is worth to adhere to the rule or not.

> Also, I think this may have come from earlier review comments where I
> suggested to name this structure struct pwm_sifive_chip, or just struct
> pwm_sifive.

Even with this argument to_pwm_sifive_chip is a bad name as the driver
data structure is named neither pwm_sifive_chip nor pwm_sifive.

> > > > In a previous review round I had doubts about the calculation of fr=
ac
> > > > and I think they were addressed wrongly.
> > > > Looking at the figure at the start of chapter 14.9 in the reference
> > > > manual: They use (different than the driver here) pwmcmp0=3D6 and
> > > > pwmzerocmp=3D1. Then a period is 7 clock cycles long and pwmcmpX mu=
st be 7
> > > > (for X > 0) to yield a 100% signal. So pwmcmpX must be greater than=
 or
> > > > equal to the period (in clock cycles).
> > > >
> > > > Here we're using pwmzerocmp=3D0, still the constraint
> > > >
> > > >         pwmcmpX >=3D period
> > > >
> > > > must be true for a 100% cycle. (Right?) With pwmzerocmp=3D0 the per=
iod is
> > > > 0x10000 clock cycles, so pwmcmpX must be >=3D 0x10000 to yield a 10=
0%
> > > > signal. As this is not possible (pwmcmpX is a 16 bit value that can=
 only
> > > > hold up to 0xffff) the output cannot yield 100%.
> > > >
> > > > So I think the most correct implementation here is:
> > > >
> > > >         frac =3D (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 << P=
WM_SIFIVE_CMPWIDTH) / 2) / period;
> > > >         /* Sorry, we cannot do 100% :-( */
> > > >         frac =3D min(frac, (1 << PWM_SIFIVE_CMPWIDTH) - 1);
> > > >
> > > =

> > > I will once again go through the specs, if it seems correct I will
> > > implement the above.
> > =

> > I would just test this at runtime. Configure for 100% and check the wave
> > form if it is constant.
> > =

> > > > > +static int pwm_sifive_probe(struct platform_device *pdev)
> > > > > +{
> > > > > [...]
> > > > > +     /* Watch for changes to underlying clock frequency */
> > > > > +     pwm->notifier.notifier_call =3D pwm_sifive_clock_notifier;
> > > > > +     ret =3D clk_notifier_register(pwm->clk, &pwm->notifier);
> > > > > +     if (ret) {
> > > > > +             dev_err(dev, "failed to register clock notifier: %d=
\n", ret);
> > > > > +             goto disable_clk;
> > > > > +     }
> > > >
> > > > Would it make sense to only enable the clock when the pwm is enable=
d?
> > > > (If yes, how does the output behave if the clock is disabled while =
the
> > > > hardware is enabled? I assume the output just freezes at the state =
where
> > > > it happens to be?)
> > > =

> > > Yes. Not sure about the behaviour of hardware when the clock is disab=
led.
> > > The behaviour should be like you said. If there is no strong reason
> > > then we can keep it as it is right now
> > > or else if you want I can make the necessary change.
> > =

> > I would prefer to only have the clock enabled when it is actually used.
> > Note the common pitfall that you cannot disable the clk immediately
> > after configureing the duty cycle to 100% or 0% though because you must
> > only stop the clock when the newly configured parameters are active.
> =

> You can also disable the clock if the hardware will still apply the
> configured parameters.

I read the pwm part of the reference manual and I'm convinced the
pitfall I pointed out is relevant here and the hardware will not put the
pin to the inactive level but just freeze on disable if the document is
accurate.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
