From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH] gpio: mvebu: change compatible string for PWM support
Date: Fri, 9 Jun 2017 22:12:37 +0200
Message-ID: <20170609221237.311cfb5c@gmail.com>
References: <20170601200820.22396-1-ralph.sennhauser@gmail.com>
        <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY7yy=U1DgFHXGd06UXg0hh5eC7mBKHLr7hq01hR__q8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Richard Genoud <richard.genoud@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, 9 Jun 2017 09:42:26 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Jun 1, 2017 at 10:08 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
> 
> > As it turns out more than just Armada 370 and XP support using GPIO
> > lines as PWM lines. For example the Armada 38x family has the same
> > hardware support. As such "marvell,armada-370-xp-gpio" for the
> > compatible string is a misnomer.
> >
> > Change the compatible string to "marvell,armada-370-gpio" before the
> > driver makes it out of the -rc stage. This also follows the
> > practice of using only the first device family supported as part of
> > the name.
> >
> > Also update the documentation and comments in the code accordingly.
> >
> > Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> > Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>  
> 
> Patch applied for next with the tags.

Hi Linus,

As Richard already correctly pointed out this needs to go into 4.12 as
we can't really change the compatible string after 4.12 final was
released. So this commit was pushed to the wrong branch. Sorry for
not having been more explicit in my wording.

Thanks
Ralph
