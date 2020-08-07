Return-path: <broonie@kernel.org>
Date: Fri, 7 Aug 2020 12:33:30 +0100
From: Mark Brown <broonie@kernel.org>
Message-ID: <20200807113330.GC5435@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
Subject: Re: [PATCH v2 00/41] spi / fbdev / cpufreq / usb / mmc / hwmon /
 ARM: Prepare for multiplatform S3C
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simtec Linux Team <linux@simtec.co.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Sebastian Reichel <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Andi Shyti <andi@etezian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Felipe Balbi <balbi@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, patches@opensource.cirrus.com, linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
List-ID: <linux-pwm.vger.kernel.org>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 08:19:32PM +0200, Krzysztof Kozlowski wrote:

> I intend to take it through Samsung SoC tree so all Acks are welcomed.

Any issue with me applying the ASoC bits and sending you a branch?  This
seems like it might run into some of the subsystem wide cleanups we've
got going on.

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tPAoACgkQJNaLcl1U
h9ALrwf+KZAjsQtFvrjZaItEWb3sRhI1J89Qn9P11Ip3UWCcQGbI2gxICttpG+8L
CTgI0cvmg6Gi1qmTb9hBL0NoaHXegLZCYlU8Ihb7C5L5NW1YmPt27OlXPVseR4vY
JzUmPWLTz/WZjKu/cPr3D+57sgeb7UxIyo5WOkAiay6qnqCb5y3zfFVkVx//gJAw
6joeeiegM3L0a4MQwV84WQtD/ygF8cInCx5dALetxU2e5Bh1Gow3dZUKty+5k+o5
cfT3ahiZTNOVmoWOkVkN7K0KSfSv9hcJM7klhFzerGOwX29Zblgo4ruMHHwEx1RU
gsZEtshX07ihXINpTYruaObjgrgpQw==
=wTm8
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
