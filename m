Return-Path: <sylvester.nawrocki@gmail.com>
Return-Path: <sylvester.nawrocki@gmail.com>
Message-ID: <51EC5F18.8040007@gmail.com>
Date: Mon, 22 Jul 2013 00:22:16 +0200
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 00/20] Samsung PWM support cleanup
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
In-Reply-To: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> Since we now have a proper Samsung PWM clocksource driver in place,
> we can proceed with further cleanup of PWM timers support on Samsung SoCs.
>
> This series attempts to achieve this goal by:
>   1) fixing up few things in samsung_pwm_timer clocksource driver,
>   2) moving remaining Samsung platforms to the new clocksource driver,
>   3) removing old clocksource driver,
>   4) adding new multiplatform- and DT-aware PWM driver,
>   5) moving all Samsung platforms to use the new PWM driver,
>   6) removing old PWM driver,
>   7) removing all PWM-related code that is not used anymore.
>
> Cleaning up the PWM driver is a bit tricky, because the design of current
> driver makes it completely unsuitable for DT and multiplatform and would
> require a heavy rework to make it usable, breaking any existing Samsung PWM
> users by the way. To avoid any breakage this series first renames the old
> driver, then adds new one using original name, migrates all platforms to
> use it and then finally removes the old driver.
>
> See particular patches for more detailed descriptions.
>
> [On S3C6410-based Tiny6410 (Mini6410-compatible) with pwm-beeper, SMDK6410
> with PWM backlight and Exynos4210-based Origen board (with PWM0 attached
> to a scope)]
> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
>
> [On S3C2440-based Mini2440 board]
> Tested-by: Sylwester Nawrocki<sylvester.nawrocki@gmail.com>

I have retested this series on top of v3.11-rc1 with pwm-backlight (and 
buzzer
as the output :)) on Mini2440. It seems to work well - generated frequencies
are correct. I'll check pulse widths with a scope tomorrow, as it's a 
bit late
now. FWIW you can add to this series my:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> [On a s3c2416 based machine]
> Tested-by: Heiko Stuebner<heiko@sntech.de>
>
> [Also not sure on what boards, but still]
> Tested-by: Mark Brown<broonie@linaro.org>
>
> Acked-by: Arnd Bergmann<arnd@arndb.de>
> Acked-by: Thierry Reding<thierry.reding@gmail.com>
> Acked-by: Heiko Stuebner<heiko@sntech.de>

Thanks,
Sylwester
