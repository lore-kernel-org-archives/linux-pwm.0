From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 01/12] pwm: introduce default period and polarity concepts
Date: Mon, 21 Sep 2015 20:20:29 +0200
Message-ID: <877fnjr5w2.fsf@belgarion.home>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
	<1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1442828009-6241-2-git-send-email-boris.brezillon@free-electrons.com>
	(Boris Brezillon's message of "Mon, 21 Sep 2015 11:33:18 +0200")
Sender: linux-leds-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-sunxi@googlegroups.com, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@google.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> When requested by a user, the PWM is assigned a default period and polarity
> extracted from the DT, the platform data or statically set by the driver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere else
> once we have introduced the architecture allowing for hardware state
> retrieval.
>
> The pwm_set_default_polarity and pwm_set_default_period should only be
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
>
> PWM users might call the pwm_get_default_period to query the default
> period value. There is currently no helper to query the default
> polarity, but it might be added later on if there is a need for it.
>
> This patch also modifies all the places where the default helpers should
> be used in place of the standard ones.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
For pwm-pxa.c :
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
