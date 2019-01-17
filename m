From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Thu, 17 Jan 2019 08:28:41 +0100
Message-ID: <20190117072841.e57tilkbrtnifss4@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <CAJ2_jOEuE1Y8G3xnYqa+aA9GSRGmN8xN7fh4nBs0_Yb68Br9bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOEuE1Y8G3xnYqa+aA9GSRGmN8xN7fh4nBs0_Yb68Br9bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Jan 17, 2019 at 12:15:38PM +0530, Yash Shah wrote:
> On Wed, Jan 16, 2019 at 10:16 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello,
> >
> > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> > > > >
> > > > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > > > [Atish: Various fixes and code cleanup]
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > ---
> > > > >  drivers/pwm/Kconfig      |  10 ++
> > > > >  drivers/pwm/Makefile     |   1 +
> > > > >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 257 insertions(+)
> > > > >  create mode 100644 drivers/pwm/pwm-sifive.c
> > > > >
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index a8f47df..3bcaf6a 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > >         To compile this driver as a module, choose M here: the module
> > > > >         will be called pwm-samsung.
> > > > >
> > > > > +config PWM_SIFIVE
> > > > > +     tristate "SiFive PWM support"
> > > > > +     depends on OF
> > > > > +     depends on COMMON_CLK
> > > >
> > > > I'd say add:
> > > >
> > > >         depends on MACH_SIFIVE || COMPILE_TEST
> > > >
> > > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> > >
> > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > @Paul, Do you have any comments on this?
> >
> > If this is not going to be available at least protect it by
> >
> >         depends RISCV || COMPILE_TEST
> >
> > > > I wonder if such an instance should be only a single PWM instead of
> > > > four. Then you were more flexible with the period lengths (using
> > > > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
> > > >
> > > > I didn't understand how the deglitch logic works yet. Currently it is
> > > > not used which might result in four edges in a single period (which is
> > > > bad).
> > >
> > > I can enable deglitch logic by just setting a bit (BIT_PWM_DEGLITCH) in
> > > REG_PWMCFG. Will do that.
> >
> > This only works for the first pwm output though.

I mixed this up with pwmzerocmp; deglitch should work on all four
outputs.

> > > > > +struct sifive_pwm_device {
> > > > > +     struct pwm_chip chip;
> > > > > +     struct notifier_block notifier;
> > > > > +     struct clk *clk;
> > > > > +     void __iomem *regs;
> > > > > +     unsigned int approx_period;
> >
> > When thinking about this a bit more, I think the better approach would
> > be to let the consumer change the period iff there is only one consumer.
> > Then you can drop that approx-period stuff and the result is more
> > flexible. (Having said that I still prefer making the driver provide
> > only a single PWM with the ability to have periods other than powers of
> > two.)
> >
> 
> I am not confident about the implementation of the way you are suggesting.
> As of now, I am going to stick with the current implementation.

The idea is to count the users using the .request and .free callbacks.
Iff there is exactly one, allow changes to period.

But please consider moving to an abstraction that only provides a single
pwm instead.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
