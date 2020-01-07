From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Date: Tue, 7 Jan 2020 13:15:12 +0100
Message-ID: <20200107121512.GA319@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
 <20200107110359.GA32423@pi3>
 <20200107113354.ggq6zarewq5ip354@pengutronix.de>
 <20200107115429.GA32632@pi3>
 <20200107120926.cgrxk6b4rchf6i42@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107120926.cgrxk6b4rchf6i42@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Richard Weinberger <richard@nod.at>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de, linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 01:09:26PM +0100, Uwe Kleine-König wrote:
> > > (Oh, HAS_DMA is defined using "depends on !NO_DMA" + "default y".
> > > NO_DMA has three different definitions. Two of them (in
> > > drivers/crypto/ccree/cc_hw_queue_defs.h and arch/arm/include/asm/dma.h)
> > > unrelated.)
> > 
> > Yes, HAS_DMA is the second missing piece for UM.
> 
> So something like:
> 
> 	# Usermode linux doesn't provide HAS_DMA and HAS_IOMEM.  To not have to
> 	# clutter most dependencies with these just exclude UML from compile
> 	# testing.
> 
> as comment for COMPILE_TEST's depend line should be fine, right?
> 

I think yes.

Best regards,
Krzysztof
