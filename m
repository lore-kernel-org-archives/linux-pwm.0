From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 16 Jan 2019 09:18:45 -0800 (PST)
Message-ID: <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com> <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de> <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-800223328-1547659125=:19681"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-800223328-1547659125=:19681
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:

> On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > index a8f47df..3bcaf6a 100644
> > > > --- a/drivers/pwm/Kconfig
> > > > +++ b/drivers/pwm/Kconfig
> > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > >         To compile this driver as a module, choose M here: the modu=
le
> > > >         will be called pwm-samsung.
> > > >
> > > > +config PWM_SIFIVE
> > > > +     tristate "SiFive PWM support"
> > > > +     depends on OF
> > > > +     depends on COMMON_CLK
> > >
> > > I'd say add:
> > >
> > >         depends on MACH_SIFIVE || COMPILE_TEST
> > >
> > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> >=20
> > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > @Paul, Do you have any comments on this?
>=20
> If this is not going to be available at least protect it by
>=20
> =09depends RISCV || COMPILE_TEST

There's nothing RISC-V or SiFive SoC-specific about this driver or IP=20
block.  The HDL for this IP block is open-source and posted on Github. =20
The IP block and driver would work unchanged on an ARM or MIPS SoC, and in=
=20
fact, SiFive does design ARM-based SoCs as well.  Likewise, any other SoC=
=20
vendor could take the HDL for this IP block from the git tree and=20
implement it on their own SoC.

More generally: it's a basic principle of Linux device drivers that they=20
should be buildable for any architecture.  The idea here is to prevent=20
developers from burying architecture or SoC-specific hacks into the=20
driver.  So there shouldn't be any architecture or SoC-specific code in=20
any device driver, unless it's abstracted in some way - ideally through a=
=20
common framework.

So from this point of view, neither "depends MACH_SIFIVE" nor "depends=20
RISCV" would be appropriate.  Similarly, the equivalents for other=20
architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g.,=20
"MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device=20
driver like this one.


- Paul
--8323329-800223328-1547659125=:19681--
