From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 16 Jan 2019 17:46:40 +0100
Message-ID: <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Yash Shah <yash.shah@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed S=
oC.
> > >
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Various fixes and code cleanup]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  drivers/pwm/Kconfig      |  10 ++
> > >  drivers/pwm/Makefile     |   1 +
> > >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  3 files changed, 257 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sifive.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a8f47df..3bcaf6a 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-samsung.
> > >
> > > +config PWM_SIFIVE
> > > +     tristate "SiFive PWM support"
> > > +     depends on OF
> > > +     depends on COMMON_CLK
> >
> > I'd say add:
> >
> >         depends on MACH_SIFIVE || COMPILE_TEST
> >
> > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> =

> As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> @Paul, Do you have any comments on this?

If this is not going to be available at least protect it by

	depends RISCV || COMPILE_TEST
 =

> > I wonder if such an instance should be only a single PWM instead of
> > four. Then you were more flexible with the period lengths (using
> > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
> >
> > I didn't understand how the deglitch logic works yet. Currently it is
> > not used which might result in four edges in a single period (which is
> > bad).
> =

> I can enable deglitch logic by just setting a bit (BIT_PWM_DEGLITCH) in
> REG_PWMCFG. Will do that.

This only works for the first pwm output though.

> > > +struct sifive_pwm_device {
> > > +     struct pwm_chip chip;
> > > +     struct notifier_block notifier;
> > > +     struct clk *clk;
> > > +     void __iomem *regs;
> > > +     unsigned int approx_period;

When thinking about this a bit more, I think the better approach would
be to let the consumer change the period iff there is only one consumer.
Then you can drop that approx-period stuff and the result is more
flexible. (Having said that I still prefer making the driver provide
only a single PWM with the ability to have periods other than powers of
two.)

> > > +     writel(frac, pwm->regs + REG_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP=
);
> >
> > If you get a constant inactive output with frac=3D0 and a constant acti=
ve
> > output with frac=3D0xffff the calculation above seems wrong to me.
> > (A value i written to the pwmcmpX register means a duty cycle of
> > (i * period / 0xffff). Your calculation assumes a divisor of 0x10000
> > however.)
> =

> Not sure if I get you completely. But, if divisor of 0xffff is your conce=
rn then
> does the below look ok?
> =

> frac =3D div_u64(((u64)duty_cycle << 16) - duty_cycle, state->period);

This works (I think, didn't redo the maths), but I would prefer

	frac =3D div_u64((u64)duty_cycle * 0xffff, state->period);

for better readability. (Maybe the compiler is even clever enough to see
this can be calculated as you suggested.)

> > > +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> > > +                                  unsigned long event, void *data)
> > > +{
> > > +     struct clk_notifier_data *ndata =3D data;
> > > +     struct sifive_pwm_device *pwm =3D
> > > +             container_of(nb, struct sifive_pwm_device, notifier);
> > > +
> > > +     if (event =3D=3D POST_RATE_CHANGE)
> > > +             sifive_pwm_update_clock(pwm, ndata->new_rate);
> >
> > Does this need locking? (Maybe not with the current state.)
> =

> No. We can add it when required.

My thought was, that the clk freq might change while .apply is active.
But given that you only configure the relative duty cycle this is
independent of the actual clk freq.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
