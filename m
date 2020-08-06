Return-path: <arnd@arndb.de>
MIME-Version: 1.0
References: <20200806181932.2253-1-krzk@kernel.org>
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 6 Aug 2020 23:57:48 +0200
Message-ID: <CAK8P3a2=KXyeb=fZNkHBJ0wUT1fr0TSS5wX=wuXz9y3kSkLQQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon / ARM:
 Prepare for multiplatform S3C
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simtec Linux Team <linux@simtec.co.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Andi Shyti <andi@etezian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Felipe Balbi <balbi@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, linux-clk <linux-clk@vger.kernel.org>, linux-hwmon@vger.kernel.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, linux-serial@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Russell King <linux@armlinux.org.uk>
List-ID: <linux-pwm.vger.kernel.org>

On Thu, Aug 6, 2020 at 8:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi All,
>
> Shortly
> =======
> This is a continuation of Arnd's work from 2019 [1].  The goal is to
> cleanup, merge and finally make the Samsung S3C24xx and S3C64xx
> architectures multiplatform.  The multiplatform did not happen yet
> here... just cleaning up and merging into one mach-s3c.
>
> I intend to take it through Samsung SoC tree so all Acks are welcomed.
>
> Changes since v1
> ================
> 1. Rebased,
> 2. Addressed comments (including mine),
> 3. Few new patches.
>
> Please see individual changelogs (per patch).
>
> [1] https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=185855&state=*

Thanks a lot for picking up my old branch!

All your additional changes look fine to me, feel free to add

Acked-by: Arnd Bergmann <arnd@arndb.de>

to the patches you added on top my original series.

     Arnd
