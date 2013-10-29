Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 09:28:48 -0700
Message-ID: <CACRpkdbKk=n=6tU=9fD05Gu9utpQSZ1qrK7EqLf5qwaV7eHBWA@mail.gmail.com>
Subject: Re: [PATCH 00/19] Enable various Renesas drivers on all ARM platforms
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, "David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, dmaengine@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, Ian Molton <ian@mnementh.co.uk>, iommu@lists.linux-foundation.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Joerg Roedel <joro@8bytes.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-spi@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <m.chehab@samsung.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Samuel Ortiz <samuel@sortiz.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Vinod Koul <vinod.koul@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>

On Mon, Oct 28, 2013 at 4:46 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> If you believe the issue should be solved in a different way (for instance by
> removing the architecture dependency completely) please reply to the cover
> letter to let other maintainers chime in.

I have no real opinions on whether this is a good itermediate step towards
complete arch-independence or not, but I just noticed that you still
have the <mach/*> hierarchy in mach-shmobile/include/mach/*, and
grep:ing around this seems totally unnecessary, I think it would be
easy to produce a patch set eliminating <mach/*> from shmobile.

(Usually we will just move all the headers down into the
mach-shmobile folder.)

Yours,
Linus Walleij
