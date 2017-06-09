From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 1/2] gpio: mvebu: fix blink counter register selection
Date: Fri, 9 Jun 2017 09:37:55 +0200
Message-ID: <CACRpkdbRN3pgNqUJXHimpMjSOMeZepjxACveTSVzYJWneM9hOQ@mail.gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com> <20170601121826.14685-2-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170601121826.14685-2-richard.genoud@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, Jun 1, 2017 at 2:18 PM, Richard Genoud <richard.genoud@gmail.com> wrote:

> The blink counter A was always selected because 0 was forced in the
> blink select counter register.
> The variable 'set' was obviously there to be used as the register value,
> selecting the B counter when id==1 and A counter when id==0.
>
> Tested on clearfog-pro (Marvell 88F6828)
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Patch applied for fixes.

It appears this will clash with patches on the development branch :(

I might screw up the merges so help me check the end result
later.

Yours,
Linus Walleij
