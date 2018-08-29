From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Date: Wed, 29 Aug 2018 14:09:37 +0200
Message-ID: <CACRpkdZU36s=-G7ncW3JMb+vXDmpdLO+3zupQD_fwUyfZxx4vA@mail.gmail.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-2-git-send-email-aditya@kobol.io> <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
 <20180829100229.7566e0db@windsurf>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829100229.7566e0db@windsurf>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: aditya@kobol.io, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Richard Genoud <richard.genoud@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dennis Gilmore <dennis@ausil.us>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 29, 2018 at 10:02 AM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Andrew Lunn did the initial support for PWM in this driver, and he
> outlined in the commit log the limitation of his first implementation:
>
>     However, there are only two sets of PWM configuration registers for
>     all the GPIO lines. This driver simply allows a single GPIO line per
>     GPIO chip of 32 lines to be used as a PWM. Attempts to use more
>     return EBUSY.
>
> Andrew, perhaps you could review the patch posted by Aditya, since you
> already looked at PWM support on mvebu platforms ?

Thanks yes Andrew is involved, I will wait for Andrew's definitive ACK
before merging any of this.

Yours,
Linus Walleij
