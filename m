Return-path: <linux-arm-kernel-bounces+u.kleine-koenig=pengutronix.de@lists.infradead.org>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Date: Mon, 16 Nov 2015 15:45:17 +0100
Message-ID: <3500453.9dNCEh5KzI@diego>
In-Reply-To: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+u.kleine-koenig=pengutronix.de@lists.infradead.org
Subject: Re: [PATCH v4 00/24] pwm: add support for atomic update
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Kamil Debski <k.debski@samsung.com>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Joachim Eastwood <manabian@gmail.com>, Bryan Wu <cooloney@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-ID: <linux-pwm.vger.kernel.org>

Hi Boris,

Am Montag, 16. November 2015, 09:56:23 schrieb Boris Brezillon:
> Hello,
> 
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

you already include my tested-by tags, but anyway, the series still works 
nicely on 4.4-rc1 on my veyron chromebook.


Heiko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
