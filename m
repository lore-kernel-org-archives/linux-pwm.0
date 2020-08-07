Return-path: <k.kozlowski.k@gmail.com>
Date: Fri, 7 Aug 2020 13:44:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20200807114411.GA9589@pi3>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200807113330.GC5435@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807113330.GC5435@sirena.org.uk>
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon /
 ARM: Prepare for multiplatform S3C
To: Mark Brown <broonie@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simtec Linux Team <linux@simtec.co.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Andi Shyti <andi@etezian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Felipe Balbi <balbi@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
List-ID: <linux-pwm.vger.kernel.org>

On Fri, Aug 07, 2020 at 12:33:30PM +0100, Mark Brown wrote:
> On Thu, Aug 06, 2020 at 08:19:32PM +0200, Krzysztof Kozlowski wrote:
> 
> > I intend to take it through Samsung SoC tree so all Acks are welcomed.
> 
> Any issue with me applying the ASoC bits and sending you a branch?  This
> seems like it might run into some of the subsystem wide cleanups we've
> got going on.

Five ASoC patches:
 - ARM: s3c24xx: move iis pinctrl config into boards
 - ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS
 - ASoC: samsung: rx1950: turn into platform driver
 - ASoC: samsung: neo1973: turn into platform driver
 - ASoC: samsung: h1940: turn into platform driver
apply cleanly on current next so I guess they could go through your tree
without problems.  Providing me a branch would be great in such case, so
please go ahead.

Thanks!

Best regards,
Krzysztof
