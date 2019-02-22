From: Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v3 3/3] pwm: hibvt: Add hi3559v100 support
Date: Fri, 22 Feb 2019 13:15:53 +0100
Message-ID: <CANVeeZyQU_NAKYaqKQStWzCOAmidTqLAph0SupfmD7zrH5K_9g@mail.gmail.com>
References: <20190219095808.12059-1-m.othacehe@gmail.com> <20190219095808.12059-3-m.othacehe@gmail.com>
 <20190221195641.hqvjxixhj7fi4gff@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221195641.hqvjxixhj7fi4gff@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

> The patch looks fine now. (If you have to do another round:
> s/again/twice/ in the commit log and s/once more/twice/ in the comment
> below.)

Ok.

>
> I wonder if this behaviour is a bug or a feature of the hardware. Is
> this additional enable needed to apply changes to both period and
> duty_cycle atomically? Is the 2nd enable needed independent of the PWM
> already running? Can you share the relevant part of the documentation
> without violating an NDA?

The same goes for the period, so I'll precise it in v4. This behaviour
is not documented in the SoC manual.
I discovered it by hitting the problem. Hisilicon support confirmed it
was needed without any
further details. It looks like this behaviour is "by design" because
there are 2 registers for duty cycle and period
and 2 state registers for duty cycle and period. When the first two
registers are edited, the state registers are
only updated on sending a new "1" in pwm enable.

I don't know if the two boards already supported by hibvt driver have
the same design but it seems quite likely.
Maybe this enable thing could be done for all boards and not
considered as a quirk.

Thanks,

Mathieu
