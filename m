From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v11 04/27] clocksource: Add a new timer-ingenic driver
Date: Fri, 5 Apr 2019 22:44:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904052241240.1802@nanos.tec.linutronix.de>
References: <20190327231631.15708-1-paul@crapouillou.net> <20190327231631.15708-5-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327231631.15708-5-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Mathieu Malaterre <malat@debian.org>, od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 28 Mar 2019, Paul Cercueil wrote:

> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.

Why on earth has a timer driver clock and interrupt chip drivers in it?

We have different subsystems for good reasons. Please split this apart and
add the support to the appropriate subsystems, clocksource, irqchip, clk

Thanks,

	tglx


 
