Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 00/18] Final Samsung PWM support cleanup
Date: Sat, 22 Jun 2013 15:10:47 +0200
Message-ID: <3161519.pXjTM5UxUs@flatron>
In-Reply-To: <201306211604.38443.arnd@arndb.de>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com> <201306211604.38443.arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thomas Abraham <thomas.abraham@linaro.org>, Thierry Reding <thierry.reding@gmail.com>

On Friday 21 of June 2013 16:04:38 Arnd Bergmann wrote:
> On Friday 21 June 2013, Tomasz Figa wrote:
> > Since we now have a proper Samsung PWM clocksource driver in place,
> > we can proceed with further cleanup of PWM timers support on Samsung
> > SoCs.> 
> > This series attempts to achieve this goal by:
> >  1) moving remaining Samsung platforms to the new clocksource driver
> >  2) removing old clocksource driver
> >  3) adding new multiplatform- and DT-aware PWM driver
> >  4) moving all Samsung platforms to use the new PWM driver
> >  5) removing old PWM driver
> >  6) removing all PWM-related code that is not used anymore
> > 
> > Cleaning up the PWM driver is a bit tricky, because the design of
> > current driver makes it completely unsuitable for DT and
> > multiplatform and would require a heavy rework to make it usable,
> > breaking any existing Samsung PWM users by the way. To avoid any
> > breakage I decided to keep the old driver, add new one, move all
> > platforms to it and then remove the old one.
> > 
> > See particular patches for more detailed descriptions.
> > 
> > On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling
> > pwm-beeper and Exynos4210-based Origen board (with PWM0 attached to a
> > scope):
> > 
> > Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks.

> Two small comments:
> 
> * always use 'git format-patch -M' to detect renames (patch 10)
> 
> * for new code, don't use __raw_readl and similar functions but
>   use readl_relaxed or plain readl.

Just posted v3 of patches 10 and 11 addressing these issues.

Best regards,
Tomasz
