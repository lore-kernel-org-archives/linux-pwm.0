From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/2] gpio: mvebu: Add support for multiple PWM lines
Date: Sun, 29 Jul 2018 22:58:16 +0200
Message-ID: <CACRpkdbiAkt6hT+LeRXCjWDZwjeYDF-e3sckMOWqnL2rdqLDug@mail.gmail.com>
References: <1532114623-81911-1-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532114623-81911-1-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: aditya@kobol.io, Gregory CLEMENT <gregory.clement@free-electrons.com>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Richard Genoud <richard.genoud@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, gauthier@kobol.io, alban.browaeys@gmail.com, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hoping for some review from Gergory, Ralph or Richard who all seem
to use this driver!

Yours,
Linus Walleij

On Fri, Jul 20, 2018 at 9:24 PM Aditya Prayoga <aditya@kobol.io> wrote:
>
> Hi everyone,
>
> Helios4, an Armada 388 based NAS SBC, provides 2 (4-pins) fan connectors.
> The PWM pins on both connector are connected to GPIO on bank 1. Current gpio-
> mvebu does not allow more than one PWM on the same bank.
>
> Aditya
>
> ---
>
> Aditya Prayoga (2):
>   gpio: mvebu: Add support for multiple PWM lines per GPIO chip
>   gpio: mvebu: Allow to use non-default PWM counter
>
>  drivers/gpio/gpio-mvebu.c | 111 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>
