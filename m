From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 00/26] Ingenic TCU patchset v8
Date: Wed, 12 Dec 2018 23:08:55 +0100
Message-ID: <20181212220922.18759-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, od@zcrc.me
List-Id: linux-pwm@vger.kernel.org

Hi,

Here's the version 8 and hopefully final version of my patchset, which
adds support for the Timer/Counter Unit found in JZ47xx SoCs from
Ingenic.

The big change is that the timer driver has been simplified. The code to
dynamically update the system timer or clocksource to a new channel has
been removed. Now, the system timer and clocksource are provided as
children nodes in the devicetree, and the TCU channel to use for these
is deduced from their respective memory resource. The PWM driver will
also deduce from its memory resources whether a given PWM channel can be
used, or is reserved for the system timers.

Kind regards,
- Paul Cercueil
