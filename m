From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Date: Tue, 7 Jan 2020 12:03:59 +0100
Message-ID: <20200107110359.GA32423@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107104234.wq74fska3szrg4ii@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, kernel@pengutronix.de, Richard Weinberger <richard@nod.at>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 11:42:34AM +0100, Uwe Kleine-König wrote:
> > I guess other solution would be to add stubs for few clk functions...
> > 
> > > Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> > > config (which does't have HAS_IOMEM) and they all compile fine.
> > 
> > Because of !HAS_IOMEM, since some time ARCH=um does not support
> > COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
> > testing (and for regular build it is selected by ARCH).
> 
> Hehe, I didn't notice because for testing I just dropped the "depends on
> ..." lines in Kconfig instead of adding "|| COMPILE_TEST" :-) Still they
> compile fine on UML.
> 
> Ah, since bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on
> !UML") == v4.8-rc1~52^2~83 COMPILE_TEST cannot be enabled on UML, but
> later 1bcbfbfdeb00 ("um: add dummy ioremap and iounmap functions")
> == v4.13-rc1~8^2~6 UM got a dummy implementation. So maybe we could
> revert bc083a64b6c0 today? (And if not, a comment about why near the
> "depends on !UML" in init/Kconfig would be great.)
> 
> Orthogonal to that, I wonder if depending on HAS_IOMEM is right even
> though the compile testers won't notice it missing. Or should HAS_IOMEM
> be dropped?

I think yes, it can be dropped, but this would require:
1. Fixing any dependencies on HAS_IOMEM, e.g.:
    WARNING: unmet direct dependencies detected for MFD_SYSCON
      Depends on [n]: HAS_IOMEM [=n]
      Selected by [y]:
      - PHY_DA8XX_USB [=y] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

2. Checking if all of stubs are implemented (not only IOMEM but maybe
   DMA as well). Also 1bcbfbfdeb00 brought only few stubs. Still we
   need devm_ioremap_resource() and others.

Quick test shows mentioned "unmet direct dependencies" and:
    phy-pxa-usb.c:(.text+0x2f5): undefined reference to `devm_ioremap_resource'
    dma-iommu.c:(.text+0x179): undefined reference to `dma_pgprot'

> 
> > > > @@ -318,7 +319,7 @@ config PWM_MEDIATEK
> > > >  
> > > >  config PWM_MXS
> > > >  	tristate "Freescale MXS PWM support"
> > > > -	depends on ARCH_MXS && OF
> > > > +	depends on (ARCH_MXS && OF) || COMPILE_TEST
> > > >  	select STMP_DEVICE
> > > >  	help
> > > >  	  Generic PWM framework driver for Freescale MXS.
> > > > @@ -328,7 +329,8 @@ config PWM_MXS
> > > >  
> > > >  config PWM_OMAP_DMTIMER
> > > >  	tristate "OMAP Dual-Mode Timer PWM support"
> > > > -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> > > > +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> > > > +	depends on OF
> > > 
> > > I'm surprised that OF isn't required for PWM_MXS but is is for
> > > PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
> > > pwm-omap-dmtimer.
> > 
> > Since some time !OF has all necessary stubs so OF is actually needed
> > only for binding, not compiling.
> 
> That doesn't explain why you handle PWM_MXS and PWM_OMAP_DMTIMER
> differently though.

You're right, I missed this. None of them require OF for building so
separate "depends on OF" makes sense only for readability of this.  Let
me send v2 to make it similar to PWM_MXS.


Best regards,
Krzysztof
