From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 2/2] gpio: mvebu: fix gpio bank registration when pwm is used
Date: Fri, 9 Jun 2017 09:39:23 +0200
Message-ID: <CACRpkdbQXyz+ZLgjGSg-0wELfxdNbNUy8F=eEcWii4WOSc3BPg@mail.gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com> <20170601121826.14685-3-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170601121826.14685-3-richard.genoud@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jun 1, 2017 at 2:18 PM, Richard Genoud <richard.genoud@gmail.com> wrote:

> If more than one gpio bank has the "pwm" property, only one will be
> registered successfully, all the others will fail with:
> mvebu-gpio: probe of f1018140.gpio failed with error -17
>
> That's because in alloc_pwms(), the chip->base (aka "int pwm"), was not
> set (thus, ==0) ; and 0 is a meaningful start value in alloc_pwm().
> What was intended is mvpwm->chip->base = -1.
> Like that, the numbering will be done auto-magically
>
> Moreover, as the region might be already occupied by another pwm, we
> shouldn't force:
> mvpwm->chip->base = 0
> nor
> mvpwm->chip->base = id * MVEBU_MAX_GPIO_PER_BANK;
>
> Tested on clearfog-pro (Marvell 88F6828)
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Patch applied for fixes with Gregory's review tag.

Yours,
Linus Walleij
