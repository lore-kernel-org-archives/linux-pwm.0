Return-path: <thesven73@gmail.com>
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com> <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet> <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
In-Reply-To: <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Fri, 29 Jan 2021 08:42:13 -0500
Message-ID: <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Thierry Reding <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

On Mon, Jan 11, 2021 at 3:35 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> My position here is: A consumer should disable a PWM before calling
> pwm_put. The driver should however not enforce this and so should not
> modify the hardware state in .free().
>
> Also .probe should not change the PWM configuration.

I agree that this is the most user-friendly behaviour.

The problem however with the pca9685 is that it has many degrees of
freedom: there are many possible register values which produce the same
physical chip outputs.

This could lead to a situation where, if .probe() does not reset the regist=
er
values, subsequent writes may lead to different outputs than expected.

One possible solution is to write .get_state() so that it always reads the
correct state, even if "unconventional" register settings are present, i.e.
those written by an outside entity, e.g. a bootloader. Then write that
state back using driver conventions.

This may be trickier than it sounds - after all we've learnt that the pca96=
85
looks simple on the surface, but is actually quite challenging to get right=
.

Clemens, Uwe, what do you think?

Sven
