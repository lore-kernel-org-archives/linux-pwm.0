From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 2/4] ARM: dts: mvebu: Add PWM properties to .dtsi files
Date: Mon, 24 Apr 2017 11:19:32 +0200
Message-ID: <CACRpkdZE0wnotF+OdAmutJcU9JSE_LxNd7Lz7yXqcn_bq5VqgQ@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com> <20170414154056.32055-3-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170414154056.32055-3-ralph.sennhauser@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> Add properties to the GPIO nodes to allow them to be also used as PWM
> lines.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427294/
> [Ralph Sennhauser: Add new compatible string marvell,armada-370-xp-gpio]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
