From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 21 Jan 2019 14:23:55 +0100
Message-ID: <20190121132355.vqwmwzzcwrqgcxrm@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <20190121113039.GI16756@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190121113039.GI16756@ulmo>
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
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, palmer@sifive.com, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>, robh+dt@kernel.org, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, Jan 21, 2019 at 12:30:39PM +0100, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:00:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> > =

> > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed S=
oC.
> > > =

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
> > > =

> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a8f47df..3bcaf6a 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-samsung.
> > >  =

> > > +config PWM_SIFIVE
> > > +	tristate "SiFive PWM support"
> > > +	depends on OF
> > > +	depends on COMMON_CLK
> > =

> > I'd say add:
> > =

> > 	depends on MACH_SIFIVE || COMPILE_TEST
> > =

> > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> > =

> > > +	help
> > > +	  Generic PWM framework driver for SiFive SoCs.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-sifive.
> > > +
> > >  config PWM_SPEAR
> > >  	tristate "STMicroelectronics SPEAr PWM support"
> > >  	depends on PLAT_SPEAR
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 9c676a0..30089ca 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > > +obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
> > >  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
> > >  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > new file mode 100644
> > > index 0000000..7fee809
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -0,0 +1,246 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2017-2018 SiFive
> > > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.=
pdf
> > =

> > I wonder if such an instance should be only a single PWM instead of
> > four. Then you were more flexible with the period lengths (using
> > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
> =

> I thought this IP only allowed a single period for all PWM channels in
> the IP. If so, splitting this into four different devices is going to
> complicate things because you'd have to coordinate between all four as
> to which period is currently set.

Take a look at the above link, figure 6 is depicting how this IP works
(page 92 of the pdf). If you have pwmzerocmp=3D0 (and pwmcmpXgang=3D0) the
four outputs (pwmcmpXgpio) are independant and the counter only resets
on overflow of pwms. Then you have 4 outputs that can have their
duty_cycle (but not period) set individually. So period is restricted to
a count of clk cycles that is a power of two.

With pwmzerocmp=3D1, pwmcmp0 resets the counter with the following
effects:

 - pwmcmp0gpio is always 0 (bad?)
 - more finegrained control over the period length as the restriction to
   powers of two is gone (good)

The other three output can then either be used as 3 PWM outputs with the
more flexible (but identical) period or only pwmcmp1gpio is used as a
single output (my favourite) and with pwmcmp2, pwmcmp3 and pwmcmp2gang=3D1
the output pwmcmp2gpio can be used as a secondary output to implement
stuff that was called "complementary mode" or "Push-pull mode" by
Claudiu Beznea.

> > > +struct sifive_pwm_device {
> > > +	struct pwm_chip	chip;
> > > +	struct notifier_block notifier;
> > > +	struct clk *clk;
> > > +	void __iomem *regs;
> > > +	unsigned int approx_period;
> > > +	unsigned int real_period;
> > > +};
> > =

> > I'd call this pwm_sifive_ddata. The prefix because the driver is called
> > pwm-sifive and ddata because this is driver data and not a device.
> =

> I don't think there's a need to have an extra suffix. Just call this
> sifive_pwm or pwm_sifive. There's no ambiguity in that name and it's
> short and crisp.

fine for me if "_device" goes away.

> > > +	if (state->enabled)
> > > +		sifive_pwm_get_state(chip, dev, state);
> > =

> > @Thierry: Should we bless this correction of state?
> =

> I'm not sure I understand why this correction is necessary. Is it okay
> to request a state to be applied and when we're not able to set that
> state we just set anything as close as possible? Sounds a bit risky to
> me. What if somebody wants to use this in a case where precision
> matters?

There is always rounding involved. Where should we draw a line then?
Consider a parent clk running at 1000000001 Hz. Can you provide a duty
cycle of 1 ps? Of if the clk runs at 500000000 Hz, I can implement even
periods, but not the uneven. Should the driver fail if an uneven period
is requested? What should a user do if setting

	.duty_cycle =3D 55, .period =3D 100,

fails? Assume the pwm can set only even duty_cycles? Or maybe duty_cycle
and period must be dividable by 3? Or maybe only periods that are a
power of two are possible? To get both, an API that can actually be
worked with and that provides precision, the driver needs to be allowed
to round (preferably in some defined way that is used for all devices)
and we need a function to determine the result without actually
configuring. That's how it works in the clk_* universe. There is
clk_round_rate and clk_set_rate and the explicit condition that

	clk_set_rate(clk, somerate)

has the same effect as

	clk_set_rate(clk, clk_round_rate(clk, somerate))

and after one of them we have

	clk_get_rate(clk) =3D clk_round_rate(clk, somerate))

> Now, if you're saying that there can't be such cases and we should
> support this, then why restrict the state correction to when the PWM is
> enabled? What's wrong with correcting it in either case?

Either the correction should be done always or never.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
