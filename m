From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] gpio: mvebu: change compatible string for PWM support
Date: Wed, 7 Jun 2017 17:13:32 -0500
Message-ID: <20170607221332.vu2xnzyhtr7x6yoe@rob-hp-laptop>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Jun 01, 2017 at 10:08:20PM +0200, Ralph Sennhauser wrote:
> As it turns out more than just Armada 370 and XP support using GPIO
> lines as PWM lines. For example the Armada 38x family has the same
> hardware support. As such "marvell,armada-370-xp-gpio" for the
> compatible string is a misnomer.
> 
> Change the compatible string to "marvell,armada-370-gpio" before the
> driver makes it out of the -rc stage. This also follows the practice of
> using only the first device family supported as part of the name.
> 
> Also update the documentation and comments in the code accordingly.
> 
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> 
> ---
> 
> Hi everyone,
> 
> The suggestion to change the compatible string last minute comes from
> Gregory CLEMENT after we realized the bad choice of name due to Richard
> Genoud reporting an issue when he used the driver with an Armada-388.
> 
> Rob Herring just requested to use a separate compatible string but not
> what it should look like. So I assume he is fine with the new one as
> well. The rest of this patch is rather minor.
> 
> Nothing in tree is using this driver so far, first consumers will be
> added with 4.13.
> 
> Ralph
> 
> ---
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.txt | 6 +++---
>  drivers/gpio/gpio-mvebu.c                             | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
