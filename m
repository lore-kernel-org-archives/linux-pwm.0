Return-Path: <laurent.pinchart@ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 00/19] Enable various Renesas drivers on all ARM platforms
Date: Wed, 13 Nov 2013 00:32:06 +0100
Message-ID: <55374441.jb1As8srky@avalon>
In-Reply-To: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Samuel Ortiz <samuel@sortiz.org>, linux-pm@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Mark Brown <broonie@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Greg Kroah-Hartman <gregkh@linuxfoundat>, ion.org, , Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, dmaengine@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <m.chehab@samsung.com>

Hello,

On Tuesday 29 October 2013 23:37:35 Laurent Pinchart wrote:
> Hello,
> 
> This patch series, based on v3.12-rc7, prepares various Renesas drivers
> for migration to multiplatform kernels by enabling their compilation or
> otherwise fixing them on all ARM platforms. The patches are pretty
> straightforward and are described in their commit message.
> 
> Changes since v1:
> 
> - The drivers can also be selected when COMPILE_TEST is enabled, regardless
> of the architecture. This should provide a good compromise between wide
> build test coverage and not clobbering configuration with drivers useless
> on non-SuperH, non-ARM platforms.
> 
> - DMA configuration is now unconditional in patch 08/19
> 
> I'd like to get all these patches merged in v3.14. As they will need to go
> through their respective subsystems' trees, I would appreciate if all
> maintainers involved could notify me when they merge patches from this
> series in their tree to help me tracking the merge status. I don't plan to
> send pull requests individually for these patches, and I will repost
> patches individually if changes are requested during review.
> 
> If you believe the issue should be solved in a different way please reply to
> the cover letter to let other maintainers chime in.

This patch series was a prerequisite for a larger rework of Renesas platforms. 
However, we've decided to go with an alternative approach that renames Kconfig 
symbols to avoid touching all the drivers. There is thus no urgency to apply 
this series anymore.

I still plan to enable COMPILE_TEST on Renesas drivers. I will send a v3 of 
these patches based on the feedback received on v2. Patches from v2 that have 
already been applied can be dropped, but there's no need to revert them rebase 
trees as they're not invalid per-se. I will make sure to address the situation 
in v3. I'm sorry for the inconvenience.

-- 
Regards,

Laurent Pinchart
