From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Date: Thu, 2 Jul 2015 09:55:20 +0200
Message-ID: <20150702095520.3088852f@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<3250976.mr9RMtjrdC@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3250976.mr9RMtjrdC@diego>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, 01 Jul 2015 23:57:57 +0200
Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:

> Hi Boris,
>=20
> Am Mittwoch, 1. Juli 2015, 10:21:46 schrieb Boris Brezillon:
> > Hello Thierry,
> >=20
> > This series adds support for atomic PWM update, or ITO, the capabil=
ity
> > to update all the parameters of a PWM device (enabled/disabled, per=
iod,
> > duty and polarity) in one go.
> >=20
> > This implementation is still experimental, and I may have missed so=
me key
> > aspect, so any feedback are welcome.
> >=20
> > Also note that I haven't protected the state update with any lockin=
g.
> > That's because the existing config does not protect against concurr=
ent
> > access to a requested PWM device (see the pwm_config implementation=
).
> > I guess the PWM framework assume the user will implement the proper=
 locking
> > scheme if it has to concurrently access the device.
> >=20
> > The 5 first patches prepare the addition of the pwm_state concept, =
which
> > will be used to allow atomic updates.
> > The following patches introduce the pwm_state struct, initial state
> > retrieval and atomic update concepts.
> >=20
> > Patches 12 and 13 are showing how one can implement the initial sta=
te
> > retrieval and atomic update features in a PWM driver (in this speci=
fic
> > case I implemented it in the rockchip driver).
> >=20
> > The last 2 patches are making use of those changes to improve the
> > pwm-regulator driver (initializing the regulator state based on the
> > initial PWM state).
>=20
> at first I got very strange readings (very wrong values and wrong pol=
arity),=20
> which resulted from the issues I pointed out in the replies to indivi=
dual=20
> patches. After fixing these, the pwm read-back now returns exactly th=
e expected=20
> values :-) .

Sorry about that, as I said I only compile tested the series :-/.
Anyway, thanks for providing fixes for these bugs, they'll be applied
in the next version.

>=20
> And with the original voltage table from the Chromeos-devicetrees, th=
e pwm-
> regulator also returns the expected 1.2V that coreboot initially set.

Great! And thanks for testing the patches.

Best Regards,

Boris

--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
