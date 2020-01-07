From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Date: Tue, 7 Jan 2020 13:09:26 +0100
Message-ID: <20200107120926.cgrxk6b4rchf6i42@pengutronix.de>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
 <20200107110359.GA32423@pi3>
 <20200107113354.ggq6zarewq5ip354@pengutronix.de>
 <20200107115429.GA32632@pi3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200107115429.GA32632@pi3>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hello Krzysztof,

On Tue, Jan 07, 2020 at 12:54:29PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Jan 07, 2020 at 12:33:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 07, 2020 at 12:03:59PM +0100, Krzysztof Kozlowski wrote:
> > > On Tue, Jan 07, 2020 at 11:42:34AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > > I guess other solution would be to add stubs for few clk function=
s...
> > > > > =

> > > > > > Also HAS_IOMEM is a typical requirement, but I tested with an A=
RCH=3Dum
> > > > > > config (which does't have HAS_IOMEM) and they all compile fine.
> > > > > =

> > > > > Because of !HAS_IOMEM, since some time ARCH=3Dum does not support
> > > > > COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for co=
mpile
> > > > > testing (and for regular build it is selected by ARCH).
> > > > =

> > > > Hehe, I didn't notice because for testing I just dropped the "depen=
ds on
> > > > ..." lines in Kconfig instead of adding "|| COMPILE_TEST" :-) Still=
 they
> > > > compile fine on UML.
> > > > =

> > > > Ah, since bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on
> > > > !UML") =3D=3D v4.8-rc1~52^2~83 COMPILE_TEST cannot be enabled on UM=
L, but
> > > > later 1bcbfbfdeb00 ("um: add dummy ioremap and iounmap functions")
> > > > =3D=3D v4.13-rc1~8^2~6 UM got a dummy implementation. So maybe we c=
ould
> > > > revert bc083a64b6c0 today? (And if not, a comment about why near the
> > > > "depends on !UML" in init/Kconfig would be great.)
> > > > =

> > > > Orthogonal to that, I wonder if depending on HAS_IOMEM is right even
> > > > though the compile testers won't notice it missing. Or should HAS_I=
OMEM
> > > > be dropped?
> > > =

> > > I think yes, it can be dropped, but this would require:
> > > 1. Fixing any dependencies on HAS_IOMEM, e.g.:
> > >     WARNING: unmet direct dependencies detected for MFD_SYSCON
> > >       Depends on [n]: HAS_IOMEM [=3Dn]
> > >       Selected by [y]:
> > >       - PHY_DA8XX_USB [=3Dy] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=
=3Dy])
> > =

> > I don't understand that warning. What did you modify to trigger that?
> > Probably related to the big "if HAS_IOMEM" in drivers/mfd/Kconfig?!
> =

> OK, that's actually from my other patch to illustrate the problem:
> https://lore.kernel.org/linux-arm-kernel/20200103164710.4829-2-krzk@kerne=
l.org/
> =

> After reverting of bc083a64b6c0, every driver that selects MFD_SYSCON
> (or some other parts) has to depend on HAS_IOMEM.

OK, understood, thanks.

> > > 2. Checking if all of stubs are implemented (not only IOMEM but maybe
> > >    DMA as well). Also 1bcbfbfdeb00 brought only few stubs. Still we
> > >    need devm_ioremap_resource() and others.
> > =

> > A problem is that it's unclear (to me at least) what the presence of
> > HAS_IOMEM actually implies. I thought it's about ioremap + readl +
> > writel (including their respective variants). Does it really include dma
> > stuff, too?
> > =

> > > Quick test shows mentioned "unmet direct dependencies" and:
> > >     phy-pxa-usb.c:(.text+0x2f5): undefined reference to `devm_ioremap=
_resource'
> > >     dma-iommu.c:(.text+0x179): undefined reference to `dma_pgprot'
> > =

> > dma_pgprot seems to depend on HAS_DMA though, not HAS_IOMEM.
> > =

> > (Oh, HAS_DMA is defined using "depends on !NO_DMA" + "default y".
> > NO_DMA has three different definitions. Two of them (in
> > drivers/crypto/ccree/cc_hw_queue_defs.h and arch/arm/include/asm/dma.h)
> > unrelated.)
> =

> Yes, HAS_DMA is the second missing piece for UM.

So something like:

	# Usermode linux doesn't provide HAS_DMA and HAS_IOMEM.  To not have to
	# clutter most dependencies with these just exclude UML from compile
	# testing.

as comment for COMPILE_TEST's depend line should be fine, right?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
