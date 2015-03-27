From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
Date: Fri, 27 Mar 2015 12:26:08 +0100
Message-ID: <20150327112607.GD5440@ulmo.nvidia.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
 <20150325120039.GA16310@ulmo.nvidia.com>
 <20150327085942.GA10906@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150327085942.GA10906@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 09:59:43AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Mar 25, 2015 at 01:00:40PM +0100, Thierry Reding wrote:
> > On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > on arm/i.MX28 the leds connected to a pwm are still broken and it's=
 more
> > > > than three years ago that I came up with these patches. I still con=
sider
> > > > them to do the right thing and they fix a real bug.
> > > I'm really frustrated here. I want to fix a real bug, made several
> > > suggestions (with patches) how to fix it and still have to include my
> > > local patches in each project that uses leds on i.MX28's pwm output.
> > >=20
> > > Thierry, how can we get this resolved?
> >=20
> > We have a couple of other drivers already solving similar issues. Look
> > for example at the pwm-bcm-kona driver. It explicitly sets the duty
> > cycle to 0 on ->disable() and then waits for some time before actually
> > disabling the clock (specifically to avoid a similar than you seem to
> > have on i.MX). See also the notes near the top of the driver source
> > file.
> >=20
> > Another example is pwm-samsung. It also has code specifically aimed at
> > making sure the signal doesn't unexpectedly stay high after calling
> > pwm_disable(). See also the commit message of:
> >=20
> > 	6da89312a39b pwm: samsung: Fix output race on disabling
> >=20
> > Both of these examples sound very similar to what you're describing, so
> > I think it'd be best to follow these examples and fix the i.MX driver to
> > behave as expected.
> Seeing that more hardware behaves like the mxs pwm makes me still more
> convinced that the pwm core should be aware of things like double
> buffering and different behaviour for disabling. Adding code to fulfil
> the API/user expectation to all three (and maybe more?) drivers seems
> wrong, don't you think?

Erm... no. The whole point of a generic API is to abstract these kinds
of differences between various drivers. The goal is that users of the
API don't have to worry about the differences anymore and can expect a
certain behaviour.

> There are IMHO two possibilities to define the outcome of
> pwm_config(duty=3D0) + pwm_disable():
>=20
>  a) the output must be 0
>  b) the output is undefined
>=20
> For a) there are two further cases:
>=20
>  a1) each driver has to assert a) on its own
>  a2) the pwm framework knows about a few common behaviours and can
>      handle them.
>=20
> Currently we are at a1) (which is undocumented in Documentation/pwm.txt
> btw). IMHO a1) is the worst of the three alternatives!

Why do you think it is the worst? If we define the behaviour as b) what
does that gain us? Why would users want to call these functions if their
behaviour is undefined? What that will result in is that code happens to
work with some PWM drivers but not with others. Then drivers will go and
implement workarounds that work only for specific drivers and so on.

a2) isn't much better. It hides the specifics from the users, but at the
same time it complicates the core because you're trying to generically
describe something that's inherently not generic. Device-specific code
belongs in drivers, not in the framework.

> BTW, what is the (expected but also undocumented) outcome of
>=20
> 	pwm_set_polarity(polarity=3DPWM_POLARITY_INVERSED);
> 	pwm_config(duty=3D0)
> 	pwm_disable()

I would expect the PWM signal to be constant high after that. With
normal polarity duty-cycle of 0 and disable means constant low, so
inversing that gives constant 1, doesn't it?

> > Irrespective of the behaviour of current drivers, the assumptions are
> > already codified in the user drivers and they all assume that calling
> > pwm_disable() means the PWM is off.
> Well, if you call pwm_disable for the mxs pwm, it is disabled
> instantly. Disabling just doesn't imply that the output goes to 0.

Right, and that's precisely what other drivers have extra code for to
handle. If you look at the pwm-bcm-kona driver it has an extra delay of
400 ns to make sure that the waveform is really updated.

> The problem at hand is updating the configuration doesn't end the
> current period. And then stopping the clock lets the output keep the
> last driven value.

So why can't you just block in ->disable() until you know the output is
actually what's been requested? If you can't read that out from the
hardware, then simply wait for a whole period before stopping the clock.

> Considering
>=20
> 	$ git grep \\\<pwm_disable | wc -l
> 	34
>=20
> going through all callers and fixing them up for changed semantics
> doesn't seem too hard. Still more as there are several false hits
> (approx 50%).

Keep in mind that you'd need to retest all combinations of these users
with all PWM drivers to make sure you're not inadvertently breaking
existing setups.

Thierry

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFT5MAAoJEN0jrNd/PrOh4cMQALehWdOqXa2rtlr+xNUdT3BT
I1BC3gn04fsb9JU1RwqbfgnV6XJm29IlJc0fuqmAl5NpXxO+gg55PyO0gkFlEtI0
WbOhYWPRE7qQwTJxg3svK+2/tQX+ryklKpPBcRC4VtbRzcBMDBO0d4bX8DJmurPy
NGdVozPDJlUPvza9vXFF6LIW1i/wtdy/yq8VueiXq9nl+juTDi4Cohpvcb30xsWR
IsFeeUdTI2YZArqA3TcXowyyptFRs8rqRUgpeR0J8f4mG1jWtxCsue4X2jrd3pYD
4s8WW1/0d0DAr5Frkde6cfmAEMu5+9G7AEWlGhiwWuHayHtPl4Iw5M6A5syKHm7W
yrXvWmXqJU8sw1VksfaRcQGj0wmyDKILV8IBz5JqpLMnzmp6RnTpAczQHgvomsUi
xp04HKBUKC7+ygQiIsoNLMtZbxIMqhuJPmv2NGVhXKQZczxWDRmsYx23tv5MvlVS
SJuAQ0b7C/OuXxe5scdhLnax60narulA4ron/m2ByAXbBNgCIyHuXT9+W6kSTkvy
Qf/y/XrUa3yBCkEv7HllEqwySmrbdUhgTJAdKNn6R+n6GbkJO/bKZeX5aVgVoaII
bmEmXWSaKPsBh5ECW0eYzM/fK/xx5oVF1kBRTty5lTmhgH72kXdl7vFiy4DnFQwX
C2qHzw+Gym7iliv3v3e8
=z3iJ
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
