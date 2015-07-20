From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
Date: Mon, 20 Jul 2015 10:32:46 +0200
Message-ID: <20150720103246.316c159d@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
	<20150702064445.GC11824@pengutronix.de>
	<20150702094955.4b1c9254@bbrezillon>
	<20150720080313.GF29614@ulmo>
	<20150720101443.180ebddb@bbrezillon>
	<20150720082241.GJ29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43372 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932146AbbGTIcu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 04:32:50 -0400
In-Reply-To: <20150720082241.GJ29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

On Mon, 20 Jul 2015 10:22:42 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Mon, Jul 20, 2015 at 10:14:43AM +0200, Boris Brezillon wrote:
> > Hi Thierry,
> >=20
> > On Mon, 20 Jul 2015 10:03:14 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> >=20
> > > On Thu, Jul 02, 2015 at 09:49:55AM +0200, Boris Brezillon wrote:
> > > > On Thu, 2 Jul 2015 08:44:45 +0200
> > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > > >=20
> > > > > On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wro=
te:
> > > > > > When requested by a user, the PWM is assigned a default per=
iod and polarity
> > > > > > extracted from the DT, the platform data or statically set =
by the driver.
> > > > > > Those default values are currently stored in the period and=
 polarity
> > > > > > fields of the pwm_device struct, but they will be stored so=
mewhere else
> > > > > > once we have introduced the architecture allowing for hardw=
are state
> > > > > > retrieval.
> > > > > >=20
> > > > > > The pwm_set_default_polarity and pwm_set_default_period sho=
uld only be
> > > > > > used by PWM drivers or the PWM core infrastructure to speci=
fy the
> > > > > > default period and polarity values.
> > > > > Would it make sense to put the prototypes of
> > > > > pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-p=
rivate.h
> > > > > then?
> > > > >=20
> > > >=20
> > > > Yes, definitely. I was thinking about moving those functions/pr=
ototypes
> > > > into include/linux/pwm-provider.h, but I'm fine with
> > > > drivers/pwm/pwm-private.h too.
> > > >=20
> > > > Thierry, any opinion ?
> > >=20
> > > I'm not sure I see the need for this. If they are the default val=
ues and
> > > drivers have no need to change them, then storing them in the reg=
ular
> > > period and polarity fields seems just fine (they'll be propagated=
 into
> > > new state objects as they get created).
> > >=20
> > > And if the driver has a need to change them, then why would it ev=
er care
> > > about the default values?
> >=20
> > Because the period is often directly extracted from the DT, and thi=
s
> > extracted period may not match the one configured by the bootloader=
=2E
> >=20
> > If the driver wants to display the current status without changing =
the
> > PWM state, then the driver will use the current state. ITOH, if it
> > has to apply a new config, the driver will use the default period
> > value (extracted from the DT) and change the duty-cycle depending o=
n its
> > needs.
> > This is the case we have with the pwm-regulator driver: we want to
> > display the initial voltage value without changing the PWM config, =
and
> > when someone decides to change the voltage, we want to use the defa=
ult
> > period instead of keeping the one configured by the bootloader.
>=20
> Wouldn't it make more sense to postpone this until the introduction o=
f
> the default state, then? That way we'd be getting a more consistent w=
ay
> of dealing with default vs. initial by looking only at state objects.

Hm, I was trying to keep the series bisectable. If we do that
after introducing the default state concept, then some drivers will
retrieve invalid values until the patches introducing the default
helpers and changing the different drivers to call the default helpers
where appropriate are introduced.

>=20
> Ideally initial state should be the same as the default state. Except
> maybe for the duty-cycle, which won't be encoded in the default state
> anyway.

Yes, but we don't live in an ideal world ;-), and the value set in an
old bootloaders might be considered wrong at some point, and new dts
versions might decide to change a bit the period value.


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
