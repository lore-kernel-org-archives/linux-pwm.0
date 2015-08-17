From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2 00/10] pwm: add support for atomic update
Date: Mon, 17 Aug 2015 09:18:27 +0200
Message-ID: <20150817091827.70eae7eb@bbrezillon>
References: <1437406327-6207-1-git-send-email-boris.brezillon@free-electrons.com>
	<20150725083657.6111ff59@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150725083657.6111ff59@bbrezillon>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Doug Anderson <dianders@google.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

On Sat, 25 Jul 2015 08:36:57 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Thierry,
>=20
> Should I resend a new version rebased on Mark's pwm topic branch or
> would you like to review this one first ?

Ping.

>=20
> Best Regards,
>=20
> Boris
>=20
> On Mon, 20 Jul 2015 17:31:57 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>=20
> > Hello Thierry,
> >=20
> > This series adds support for atomic PWM update, or IOW, the capabil=
ity
> > to update all the parameters of a PWM device (enabled/disabled, per=
iod,
> > duty and polarity) in one go.
> >=20
> > Best Regards,
> >=20
> > Boris
> >=20
> > Changes since v1:
> > - dropped applied patches
> > - squashed Heiko's fixes into the rockchip driver changes
> > - made a few cosmetic changes
> > - added kerneldoc comments
> > - added Heiko's patch to display more information in debugfs
> > - dropped pwm-regulator patches (should be submitted separately)
> >=20
> > Boris Brezillon (9):
> >   pwm: introduce default period and polarity concepts
> >   pwm: define a new pwm_state struct
> >   pwm: move the enabled/disabled info to pwm_state struct
> >   backlight: pwm_bl: remove useless call to pwm_set_period
> >   pwm: declare a default PWM state
> >   pwm: add the PWM initial state retrieval infra
> >   pwm: add the core infrastructure to allow atomic update
> >   pwm: rockchip: add initial state retrieval
> >   pwm: rockchip: add support for atomic update
> >=20
> > Heiko St=C3=BCbner (1):
> >   pwm: add information about polarity, duty cycle and period to deb=
ugfs
> >=20
> >  drivers/leds/leds-pwm.c              |   2 +-
> >  drivers/pwm/core.c                   | 169 +++++++++++++++++++++++=
++++++++----
> >  drivers/pwm/pwm-pxa.c                |   2 +-
> >  drivers/pwm/pwm-rockchip.c           | 119 +++++++++++++++++++----=
-
> >  drivers/pwm/pwm-sun4i.c              |   3 +-
> >  drivers/regulator/pwm-regulator.c    |   2 +-
> >  drivers/video/backlight/lm3630a_bl.c |   4 +-
> >  drivers/video/backlight/pwm_bl.c     |  10 ++-
> >  drivers/video/fbdev/ssd1307fb.c      |   2 +-
> >  include/linux/pwm.h                  |  86 +++++++++++++++---
> >  10 files changed, 336 insertions(+), 63 deletions(-)
> >=20
>=20
>=20
>=20



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
