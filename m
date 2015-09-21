From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3 00/12] pwm: add support for atomic update
Date: Tue, 22 Sep 2015 00:30:37 +0200
Message-ID: <5055506.IbQp3pDAJn__19110.6335180395$1442874737$gmane$org@diego>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Thierry Reding <thierry.reding@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-rockchip@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

Am Montag, 21. September 2015, 11:33:17 schrieb Boris Brezillon:
> This series adds support for atomic PWM update, or IOW, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.

I gave this v3 a spin on a rk3288-veyron device with the pwm-regulator 
supplying vdd_logic. Looks really nice and runs fine, so the series

Tested-by: Heiko Stuebner <heiko@sntech.de>
