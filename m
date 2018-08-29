From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM lines per GPIO chip
Date: Wed, 29 Aug 2018 10:13:05 +0200
Message-ID: <87in3tk2um.fsf@bootlin.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
        <1533522556-55055-2-git-send-email-aditya@kobol.io>
        <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
        (Linus Walleij's message of "Wed, 29 Aug 2018 09:54:04 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: aditya@kobol.io, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Richard Genoud <richard.genoud@gmail.com>, gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dennis@ausil.us, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pwm@vger.kernel.org

Hi Linus,
 
 On mer., août 29 2018, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Aug 6, 2018 at 4:31 AM Aditya Prayoga <aditya@kobol.io> wrote:
>
>> Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.
>>
>> based on initial work on LK4.4 by Alban Browaeys.
>> URL: https://github.com/helios-4/linux-marvell/commit/743ae97
>> [Aditya Prayoga: forward port, cleanup]
>> Signed-off-by: Aditya Prayoga <aditya@kobol.io>
>
> It would be awesome to get some feedback from the MVEBU maintainers
> on this patch set.

There already has been reviewed from Andrew and also from Richard who
worked on the PWM part too. There were many questions raised, but no
feedback yet, so for now this patch set is clearly not ready to be
merged. We are waiting for answers and a new version.

Gregory

>
> Who are most active on Marvell stuff these days? Thomas?
>
> Likewise I'd be very grateful for a nod from the PWM maintainer that
> this is OK with him.
>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
