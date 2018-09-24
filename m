From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 05/24] clocksource: Add a new timer-ingenic driver
Date: Mon, 24 Sep 2018 05:12:29 +0200
Message-ID: <e0836866-552f-374b-d271-a4ea2d4953ac@linaro.org>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-6-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821171635.22740-6-paul@crapouillou.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Jonathan Corbet <corbet@lwn.net>
Cc: od@zcrc.me, Mathieu Malaterre <malat@debian.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 21/08/2018 19:16, Paul Cercueil wrote:
> This driver handles the TCU (Timer Counter Unit) present on the Ingenic
> JZ47xx SoCs, and provides the kernel with a system timer, and optionally
> with a clocksource and a sched_clock.
> 
> It also provides clocks and interrupt handling to client drivers.

Can you provide a much more complete description of the timer in order
to make my life easier for the review of this patch?

Thanks

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
