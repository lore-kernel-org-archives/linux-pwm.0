From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Date: Wed, 29 Aug 2018 10:02:29 +0200
Message-ID: <20180829100229.7566e0db@windsurf>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
        <1533522556-55055-2-git-send-email-aditya@kobol.io>
        <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: aditya@kobol.io, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Richard Genoud <richard.genoud@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dennis@ausil.us, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pwm@vger.kernel.org

Hello Linus,

On Wed, 29 Aug 2018 09:54:04 +0200, Linus Walleij wrote:
> On Mon, Aug 6, 2018 at 4:31 AM Aditya Prayoga <aditya@kobol.io> wrote:
> 
> > Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.
> >
> > based on initial work on LK4.4 by Alban Browaeys.
> > URL: https://github.com/helios-4/linux-marvell/commit/743ae97
> > [Aditya Prayoga: forward port, cleanup]
> > Signed-off-by: Aditya Prayoga <aditya@kobol.io>  
> 
> It would be awesome to get some feedback from the MVEBU maintainers
> on this patch set.
> 
> Who are most active on Marvell stuff these days? Thomas?

Andrew Lunn did the initial support for PWM in this driver, and he
outlined in the commit log the limitation of his first implementation:

    However, there are only two sets of PWM configuration registers for
    all the GPIO lines. This driver simply allows a single GPIO line per
    GPIO chip of 32 lines to be used as a PWM. Attempts to use more
    return EBUSY.

Andrew, perhaps you could review the patch posted by Aditya, since you
already looked at PWM support on mvebu platforms ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
