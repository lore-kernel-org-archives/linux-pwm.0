From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 24 Apr 2017 11:18:30 +0200
Message-ID: <CACRpkdYPp6pBemTT_a4V6a-Qbk2475qOOxWJOhfVaEz=cojOvA@mail.gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com> <20170414154056.32055-2-ralph.sennhauser@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170414154056.32055-2-ralph.sennhauser@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Fri, Apr 14, 2017 at 5:40 PM, Ralph Sennhauser
<ralph.sennhauser@gmail.com> wrote:

> From: Andrew Lunn <andrew@lunn.ch>
>
> Armada 370/XP devices can 'blink' GPIO lines with a configurable on
> and off period. This can be modelled as a PWM.
>
> However, there are only two sets of PWM configuration registers for
> all the GPIO lines. This driver simply allows a single GPIO line per
> GPIO chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the GPIO driver. Thus the GPIO driver has been
> extended with a PWM driver.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427287/
> URL: https://patchwork.ozlabs.org/patch/427295/
> [Ralph Sennhauser:
>   * Port forward
>   * Merge PWM portion into gpio-mvebu.c
>   * Switch to atomic PWM API
>   * Add new compatible string marvell,armada-370-xp-gpio
>   * Update and merge documentation patch
>   * Update MAINTAINERS]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Tested-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
