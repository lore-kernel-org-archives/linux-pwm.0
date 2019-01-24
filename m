From: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v8 00/26] Ingenic TCU patchset v8
Date: Thu, 24 Jan 2019 22:26:11 +0100
Message-ID: <CA+7wUszMOvGoPSVOKP7F_KHxgJvjBGT7oJmn5EO62hGGTQK4KA@mail.gmail.com>
References: <20181212220922.18759-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me
List-Id: linux-pwm@vger.kernel.org

Paul,

On Wed, Dec 12, 2018 at 11:09 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi,
>
> Here's the version 8 and hopefully final version of my patchset, which
> adds support for the Timer/Counter Unit found in JZ47xx SoCs from
> Ingenic.

I can no longer boot my MIPS Creator CI20 with this series (merged
opendingux/for-upstream-timer-v8).

Using screen+ttyUSB, I can see messages stopping at:

...
[  OK  ] Started Cgroup management daemon.
         Starting Regular background program processing daemon...
[  OK  ] Started Regular background program processing daemon.
         Starting System Logging Service...
         Starting Provide limited super user privileges to specific users...
         Starting Restore /etc/resolv.conf if the system cras...s shut down....
         Starting WPA supplicant...
         Starting D-Bus System Message Bus...
[  OK  ] Started D-Bus System Message Bus.

Nothing really stands out in the error messages. Could you suggest
things to try out to get into a bootable state ?


> The big change is that the timer driver has been simplified. The code to
> dynamically update the system timer or clocksource to a new channel has
> been removed. Now, the system timer and clocksource are provided as
> children nodes in the devicetree, and the TCU channel to use for these
> is deduced from their respective memory resource. The PWM driver will
> also deduce from its memory resources whether a given PWM channel can be
> used, or is reserved for the system timers.
>
> Kind regards,
> - Paul Cercueil
>
