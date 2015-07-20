From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
Date: Mon, 20 Jul 2015 10:14:43 +0200
Message-ID: <20150720101443.180ebddb@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
	<20150702064445.GC11824@pengutronix.de>
	<20150702094955.4b1c9254@bbrezillon>
	<20150720080313.GF29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42222 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932208AbbGTIOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 04:14:47 -0400
In-Reply-To: <20150720080313.GF29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

Hi Thierry,

On Mon, 20 Jul 2015 10:03:14 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Thu, Jul 02, 2015 at 09:49:55AM +0200, Boris Brezillon wrote:
> > On Thu, 2 Jul 2015 08:44:45 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >=20
> > > On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> > > > When requested by a user, the PWM is assigned a default period =
and polarity
> > > > extracted from the DT, the platform data or statically set by t=
he driver.
> > > > Those default values are currently stored in the period and pol=
arity
> > > > fields of the pwm_device struct, but they will be stored somewh=
ere else
> > > > once we have introduced the architecture allowing for hardware =
state
> > > > retrieval.
> > > >=20
> > > > The pwm_set_default_polarity and pwm_set_default_period should =
only be
> > > > used by PWM drivers or the PWM core infrastructure to specify t=
he
> > > > default period and polarity values.
> > > Would it make sense to put the prototypes of
> > > pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-priva=
te.h
> > > then?
> > >=20
> >=20
> > Yes, definitely. I was thinking about moving those functions/protot=
ypes
> > into include/linux/pwm-provider.h, but I'm fine with
> > drivers/pwm/pwm-private.h too.
> >=20
> > Thierry, any opinion ?
>=20
> I'm not sure I see the need for this. If they are the default values =
and
> drivers have no need to change them, then storing them in the regular
> period and polarity fields seems just fine (they'll be propagated int=
o
> new state objects as they get created).
>=20
> And if the driver has a need to change them, then why would it ever c=
are
> about the default values?

Because the period is often directly extracted from the DT, and this
extracted period may not match the one configured by the bootloader.

If the driver wants to display the current status without changing the
PWM state, then the driver will use the current state. ITOH, if it
has to apply a new config, the driver will use the default period
value (extracted from the DT) and change the duty-cycle depending on it=
s
needs.
This is the case we have with the pwm-regulator driver: we want to
display the initial voltage value without changing the PWM config, and
when someone decides to change the voltage, we want to use the default
period instead of keeping the one configured by the bootloader.

Best Regards,

Boris


--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
