Return-Path: <abrestic@google.com>
MIME-Version: 1.0
Sender: abrestic@google.com
In-Reply-To: <1374623475.SoL01ZHzWk@flatron>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
	<1374278673-25615-15-git-send-email-tomasz.figa@gmail.com>
	<1478465.17AL5GbAI8@flatron>
	<1374623475.SoL01ZHzWk@flatron>
Date: Wed, 7 Aug 2013 12:35:42 -0700
Message-ID: <CAL1qeaF1Mxs_Q6QnLznW3SoXBoNhBb+gCYMESMgx6g+bUFVCmQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/20] pwm: Add new pwm-samsung driver
From: Andrew Bresticker <abrestic@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

Hi Tomasz,

> +#ifndef CONFIG_CLKSRC_SAMSUNG_PWM
> +/*
> + * PWM block is shared between pwm-samsung and samsung_pwm_timer drivers
> + * and some registers need access synchronization. If both drivers are
> + * compiled in, the spinlock is defined in the clocksource driver,
> + * otherwise following definition is used.
> + *
> + * Currently we do not need any more complex synchronization method
> + * because all the supported SoCs contain only one instance of the PWM
> + * IP. Should this change, both drivers will need to be modified to
> + * properly synchronize accesses to particular instances.
> + */
> +static DEFINE_SPINLOCK(samsung_pwm_lock);

Shouldn't this not be static?  It's declared in
clocksource/samsung_pwm.h whether or not the samsung_pwm_timer is
compiled in or not.

Thanks,
Andrew
