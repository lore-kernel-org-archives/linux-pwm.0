Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
Date: Tue, 29 Oct 2013 14:22:28 +0100
Message-ID: <1844190.ApyucSZX8W@avalon>
In-Reply-To: <1383051980.29619.33.camel@sauron.fi.intel.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <Pine.LNX.4.64.1310291009121.8404@axis700.grange> <1383051980.29619.33.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: dedekind1@gmail.com
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Sergei S htylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>

Hi Artem,

On Tuesday 29 October 2013 15:06:20 Artem Bityutskiy wrote:
> On Tue, 2013-10-29 at 10:12 +0100, Guennadi Liakhovetski wrote:
> > On Tue, 29 Oct 2013, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch series, based on v3.12-rc7, prepares various Renesas drivers
> > > for migration to multiplatform kernels by enabling their compilation or
> > > otherwise fixing them on all ARM platforms. The patches are pretty
> > > straightforward and are described in their commit message.
> > > 
> > > I'd like to get all these patches merged in v3.14. As they will need to
> > > go through their respective subsystems' trees, I would appreciate if all
> > > maintainers involved could notify me when they merge patches from this
> > > series in their tree to help me tracking the merge status. I don't plan
> > > to send pull requests individually for these patches, and I will repost
> > > patches individually if changes are requested during review.
> > > 
> > > If you believe the issue should be solved in a different way (for
> > > instance by removing the architecture dependency completely) please
> > > reply to the cover letter to let other maintainers chime in.
> > 
> > Exactly this was my doubt. If we let these drivers build on all ARM
> > platforms... Maybe we should just let them build everywhere? Unless there
> > are real ARM dependencies. Maybe you could try to remove the restriction
> > and try to build them all on x86?
> 
> If they have never been used on anything but ARM, why would you remove
> ARM dependencies? Just for the sake of compile-checking?
> 
> Also, if ARM dependency is ever removed, all these should become 'n' by
> default in the Kconfig, in order to make sure they do not slip into
> defconfigs of different architectures.

The idea is that, if ARM is neither a compile-time nor runtime dependency, it 
should not be specified in Kconfig. However, if the IP core has never been 
used on anything but SuperH and ARM, I don't think clobbering the config 
process with drivers that can't be used on the target architecture would be a 
really good idea, especially now that we have a COMPILE_TEST Kconfig option. 
My preference does goes to SUPERH || ARM || COMPILE_TEST over no dependency at 
all.

-- 
Regards,

Laurent Pinchart
