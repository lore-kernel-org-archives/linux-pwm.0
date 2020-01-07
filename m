From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Date: Tue, 7 Jan 2020 09:25:39 +0100
Message-ID: <20200107082539.GA31827@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 08:26:45AM +0100, Uwe Kleine-König wrote:
> Hello Krzysztof,
> 
> On Mon, Dec 30, 2019 at 06:21:13PM +0100, Krzysztof Kozlowski wrote:
> > Some of the PWM drivers can be compile tested to increase build
> > coverage.
> > 
> > The Meson PWM driver requires COMMON_CLK dependency.
> 
> I'm surprised that there are not more that need this. Is HAVE_CLK not
> enough?

Nope. E.g. for alpha architecture, HAVE_CLK is not set and without
COMMON_CLK:

drivers/pwm/pwm-meson.o: In function `meson_pwm_init_channels':
(.text+0x244): undefined reference to `devm_clk_register'

I guess other solution would be to add stubs for few clk functions...

> Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> config (which does't have HAS_IOMEM) and they all compile fine.

Because of !HAS_IOMEM, since some time ARCH=um does not support
COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
testing (and for regular build it is selected by ARCH).

> 
> > @@ -318,7 +319,7 @@ config PWM_MEDIATEK
> >  
> >  config PWM_MXS
> >  	tristate "Freescale MXS PWM support"
> > -	depends on ARCH_MXS && OF
> > +	depends on (ARCH_MXS && OF) || COMPILE_TEST
> >  	select STMP_DEVICE
> >  	help
> >  	  Generic PWM framework driver for Freescale MXS.
> > @@ -328,7 +329,8 @@ config PWM_MXS
> >  
> >  config PWM_OMAP_DMTIMER
> >  	tristate "OMAP Dual-Mode Timer PWM support"
> > -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> > +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> > +	depends on OF
> 
> I'm surprised that OF isn't required for PWM_MXS but is is for
> PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
> pwm-omap-dmtimer.

Since some time !OF has all necessary stubs so OF is actually needed
only for binding, not compiling.

Best regards,
Krzysztof
