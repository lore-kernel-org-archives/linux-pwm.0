From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi
 files
Date: Fri, 5 May 2017 09:41:39 +0200
Message-ID: <20170505094139.484db2e7@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
        <20170414154056.32055-3-ralph.sennhauser@gmail.com>
        <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, 24 Apr 2017 11:19:32 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
> <ralph.sennhauser@gmail.com> wrote:
> 
> > From: Andrew Lunn <andrew@lunn.ch>
> >
> > Add properties to the GPIO nodes to allow them to be also used as
> > PWM lines.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > URL: https://patchwork.ozlabs.org/patch/427294/
> > [Ralph Sennhauser: Add new compatible string
> > marvell,armada-370-xp-gpio] Signed-off-by: Ralph Sennhauser
> > <ralph.sennhauser@gmail.com> Tested-by: Andrew Lunn
> > <andrew@lunn.ch>  
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please funnel this through ARM SoC.

Hi Gregory,

A reminder on the off chance you have missed this and it's not to late
already, Linus Walleij took the driver and submitted it for inclusion in
4.12 [1]. So for completeness it be nice to have the dts(i) and
defconfig changes in as well.

Thanks
Ralph

[1] https://lkml.org/lkml/2017/5/4/82

> 
> Yours,
> Linus Walleij

