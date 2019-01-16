From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 16 Jan 2019 18:28:49 +0100
Message-ID: <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Yash Shah <yash.shah@sifive.com>, Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jan 16, 2019 at 09:18:45AM -0800, Paul Walmsley wrote:
> On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:
> =

> > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index a8f47df..3bcaf6a 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > >         To compile this driver as a module, choose M here: the mo=
dule
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
> > > =

> > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > @Paul, Do you have any comments on this?
> > =

> > If this is not going to be available at least protect it by
> > =

> > 	depends RISCV || COMPILE_TEST
> =

> There's nothing RISC-V or SiFive SoC-specific about this driver or IP =

> block.  The HDL for this IP block is open-source and posted on Github.  =

> The IP block and driver would work unchanged on an ARM or MIPS SoC, and i=
n =

> fact, SiFive does design ARM-based SoCs as well.  Likewise, any other SoC =

> vendor could take the HDL for this IP block from the git tree and =

> implement it on their own SoC.
> =

> More generally: it's a basic principle of Linux device drivers that they =

> should be buildable for any architecture.  The idea here is to prevent =

> developers from burying architecture or SoC-specific hacks into the =

> driver.  So there shouldn't be any architecture or SoC-specific code in =

> any device driver, unless it's abstracted in some way - ideally through a =

> common framework.
> =

> So from this point of view, neither "depends MACH_SIFIVE" nor "depends =

> RISCV" would be appropriate.  Similarly, the equivalents for other =

> architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g., =

> "MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device =

> driver like this one.

The dependency serves two purposes:

 a) ensure that the build requirements are fulfilled.
 b) restrict configuration to actually existing machines

When considering b) it doesn't make sense to enable the driver for (say)
a machine that is powered by an ARM SoC by TI. If you still want to
compile test the sifive driver for ARM, enable COMPILE_TEST. That's what
this symbol is there for.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
