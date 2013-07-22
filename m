Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v4 04/20] clocksource: samsung_pwm_timer: Do not use clocksource_mmio
Date: Mon, 22 Jul 2013 09:47:04 +0200
Message-ID: <19090469.Cf6sbb33Ke@flatron>
In-Reply-To: <51ECAD60.1000109@linaro.org>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <1374278673-25615-6-git-send-email-tomasz.figa@gmail.com> <51ECAD60.1000109@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

Hi Daniel,

On Monday 22 of July 2013 05:56:16 Daniel Lezcano wrote:
> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
> > In case of Samsung PWM timer, clocksource MMIO can not be used,
> > because
> > custom suspend/resume callbacks are required.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > ---
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for review.

> Please in the future Cc me and Thomas Gleixner (clocksource/clockevent
> maintainers).

Oh, right, sorry. This series originally was not touching the clocksource 
driver and I just kept original recipient list.

Btw. Have you updated MAINTAINERS file? In latest linux-next I can still 
see only John Stultz and Thomas Gleixner as maintainers of 
drivers/clocksource.

Best regards,
Tomasz
