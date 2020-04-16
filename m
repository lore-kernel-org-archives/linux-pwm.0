From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 0/6] PWM fan support on Clearfog gt8k
Date: Thu, 16 Apr 2020 09:51:37 +0200
Message-ID: <CACRpkdaL4-Z36aKOVW4o2MtCG9fbqm4gxZN3QjejVRPBZrzxxA@mail.gmail.com>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Sun, Mar 29, 2020 at 12:46 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> This series adds support for the fan PWM output on the Clearfog GT8K
> platform, and can potentially be extended to the Macchiatobin.

The gpio changes all look fine to me +/- fixes for review comments.

Could the MVEBU maintainers provide some feedback?
Curiously the file is only listed as a PWM driver in MAINTAINERS
so formally Thierry & Uwe review it (and Uwe did), but surely
the MVEBU platform maintainers should take a look too.

Yours,
Linus Walleij
