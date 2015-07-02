From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
Date: Thu, 2 Jul 2015 09:49:55 +0200
Message-ID: <20150702094955.4b1c9254@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
	<20150702064445.GC11824@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <20150702064445.GC11824@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2 Jul 2015 08:44:45 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > When requested by a user, the PWM is assigned a default period and =
polarity
> > extracted from the DT, the platform data or statically set by the d=
river.
> > Those default values are currently stored in the period and polarit=
y
> > fields of the pwm_device struct, but they will be stored somewhere =
else
> > once we have introduced the architecture allowing for hardware stat=
e
> > retrieval.
> >=20
> > The pwm_set_default_polarity and pwm_set_default_period should only=
 be
> > used by PWM drivers or the PWM core infrastructure to specify the
> > default period and polarity values.
> Would it make sense to put the prototypes of
> pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
> then?
>=20

Yes, definitely. I was thinking about moving those functions/prototypes
into include/linux/pwm-provider.h, but I'm fine with
drivers/pwm/pwm-private.h too.

Thierry, any opinion ?


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
