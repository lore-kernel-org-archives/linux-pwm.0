From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Wed, 16 Jan 2019 11:29:35 -0800 (PST)
Message-ID: <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com> <1547194964-16718-3-git-send-email-yash.shah@sifive.com> <20190115220046.etgbno6ymsux75dk@pengutronix.de> <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de> <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com> <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-266195263-1547665898=:19681"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
Content-ID: <alpine.DEB.2.21.9999.1901161115270.19681@viisi.sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Yash Shah <yash.shah@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>
List-Id: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-266195263-1547665898=:19681
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.9999.1901161115271.19681@viisi.sifive.com>



On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:

> On Wed, Jan 16, 2019 at 09:18:45AM -0800, Paul Walmsley wrote:
> > On Wed, 16 Jan 2019, Uwe Kleine-K=F6nig wrote:
> >=20
> > > On Wed, Jan 16, 2019 at 04:40:42PM +0530, Yash Shah wrote:
> > > > On Wed, Jan 16, 2019 at 3:30 AM Uwe Kleine-K=F6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > > index a8f47df..3bcaf6a 100644
> > > > > > --- a/drivers/pwm/Kconfig
> > > > > > +++ b/drivers/pwm/Kconfig
> > > > > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > > > > >         To compile this driver as a module, choose M here: the =
module
> > > > > >         will be called pwm-samsung.
> > > > > >
> > > > > > +config PWM_SIFIVE
> > > > > > +     tristate "SiFive PWM support"
> > > > > > +     depends on OF
> > > > > > +     depends on COMMON_CLK
> > > > >
> > > > > I'd say add:
> > > > >
> > > > >         depends on MACH_SIFIVE || COMPILE_TEST
> > > > >
> > > > > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean=
=2E)
> > > >=20
> > > > As of now, MACH_SIFIVE/ARCH_SIFIVE isn't available.
> > > > @Paul, Do you have any comments on this?
> > >=20
> > > If this is not going to be available at least protect it by
> > >=20
> > > =09depends RISCV || COMPILE_TEST
> >=20
> > There's nothing RISC-V or SiFive SoC-specific about this driver or IP=
=20
> > block.  The HDL for this IP block is open-source and posted on Github. =
=20
> > The IP block and driver would work unchanged on an ARM or MIPS SoC, and=
 in=20
> > fact, SiFive does design ARM-based SoCs as well.  Likewise, any other S=
oC=20
> > vendor could take the HDL for this IP block from the git tree and=20
> > implement it on their own SoC.
> >=20
> > More generally: it's a basic principle of Linux device drivers that the=
y=20
> > should be buildable for any architecture.  The idea here is to prevent=
=20
> > developers from burying architecture or SoC-specific hacks into the=20
> > driver.  So there shouldn't be any architecture or SoC-specific code in=
=20
> > any device driver, unless it's abstracted in some way - ideally through=
 a=20
> > common framework.
> >=20
> > So from this point of view, neither "depends MACH_SIFIVE" nor "depends=
=20
> > RISCV" would be appropriate.  Similarly, the equivalents for other=20
> > architectures (e.g. "ARCH_ARM") or SoC manufacturers (e.g.,=20
> > "MACH_SAMSUNG") wouldn't be appropriate for any generic IP block device=
=20
> > driver like this one.
>=20
> The dependency serves two purposes:
>=20
>  a) ensure that the build requirements are fulfilled.
>  b) restrict configuration to actually existing machines
>=20
> When considering b) it doesn't make sense to enable the driver for (say)
> a machine that is powered by an ARM SoC by TI. If you still want to
> compile test the sifive driver for ARM, enable COMPILE_TEST. That's what
> this symbol is there for.

COMPILE_TEST made slightly more sense before the broad availability of=20
open-source soft cores, SoC integration, and IP; and before powerful,=20
inexpensive FPGAs and SoCs with FPGA fabrics were common.

Even back then, COMPILE_TEST was starting to look questionable.  IP blocks=
=20
from CPU- and SoC vendor-independent libraries, like DesignWare and the=20
Cadence IP libraries, were integrated on SoCs across varying CPU=20
architectures.  (Fortunately, looking at the tree, subsystem maintainers=20
with DesignWare drivers seem to have largely avoided adding architecture=20
or SoC-specific Kconfig restrictions there - and thus have also avoided=20
the need for COMPILE_TEST.)  If an unnecessary architecture Kconfig=20
dependency was added for a leaf driver, that Kconfig line would either=20
need to be patched out by hand, or if present, COMPILE_TEST would need to=
=20
be enabled.

This was less of a problem then.  There were very few FPGA Linux users,=20
and they were mostly working on internal proprietary projects. FPGAs that=
=20
could run Linux at a reasonable speed, including MMUs and FPUs, were=20
expensive or were missing good tool support.  So most FPGA Linux=20
development was restricted to ASIC vendors - the Samsungs, Qualcomms,=20
NVIDIAs of the world - for prototyping, and those FPGA platforms never=20
made it outside those companies.

The situation is different now.  The major FPGA vendors have inexpensive=20
FPGA SoCs with full-featured CPU hard macros.  The development boards can=
=20
be quite affordable (< USD 300 for the Xilinx Ultra96).  There are also=20
now open-source SoC HDL implementations - including MMUs, FPUs, and=20
peripherals like PWM and UART - for the conventional FPGA market.  These=20
can run at mid-1990's clock rates - slow by modern standards but still=20
quite usable.

So or vendor-specific IP blocks that are unlikely to ever be reused by=20
anyone else, like the NVIDIA or TI PWM blocks, maybe there's still some=20
justification for COMPILE_TEST.  But for drivers for open-source,=20
SoC-independent peripheral IP blocks - or even for proprietary IP blocks=20
from library vendors like Synopsys or Cadence - like this PWM driver, we=20
shouldn't add unnecessary architecture, SoC vendor, or COMPILE_TEST=20
Kconfig dependencies.  They will just force users to patch the kernel or=20
enable COMPILE_TEST for kernels that are actually meant to run on real=20
hardware.


- Paul

--8323329-266195263-1547665898=:19681--
