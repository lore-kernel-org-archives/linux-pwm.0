From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
Date: Fri, 27 Mar 2015 16:43:03 +0100
Message-ID: <20150327154301.GA27626@ulmo.nvidia.com>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
 <20150325120039.GA16310@ulmo.nvidia.com>
 <20150327085942.GA10906@pengutronix.de>
 <20150327112607.GD5440@ulmo.nvidia.com>
 <20150327143559.GZ32677@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33443 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbC0PnJ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Mar 2015 11:43:09 -0400
Content-Disposition: inline
In-Reply-To: <20150327143559.GZ32677@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>, linux-leds@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Tim Kryger <tim.kryger@linaro.org>, Alex Elder <elder@linaro.org>, Markus Mayer <markus.mayer@linaro.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 03:35:59PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> [added the people being involved with the other two drivers in question,
> maybe you want to comment?]
>=20
> Hello Thierry,
>=20
> On Fri, Mar 27, 2015 at 12:26:08PM +0100, Thierry Reding wrote:
> > On Fri, Mar 27, 2015 at 09:59:43AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Mar 25, 2015 at 01:00:40PM +0100, Thierry Reding wrote:
> > > > On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > on arm/i.MX28 the leds connected to a pwm are still broken and =
it's more
> > > > > > than three years ago that I came up with these patches. I still=
 consider
> > > > > > them to do the right thing and they fix a real bug.
> > > > > I'm really frustrated here. I want to fix a real bug, made several
> > > > > suggestions (with patches) how to fix it and still have to includ=
e my
> > > > > local patches in each project that uses leds on i.MX28's pwm outp=
ut.
> > > > >=20
> > > > > Thierry, how can we get this resolved?
> > > >=20
> > > > We have a couple of other drivers already solving similar issues. L=
ook
> > > > for example at the pwm-bcm-kona driver. It explicitly sets the duty
> > > > cycle to 0 on ->disable() and then waits for some time before actua=
lly
> > > > disabling the clock (specifically to avoid a similar than you seem =
to
> > > > have on i.MX). See also the notes near the top of the driver source
> > > > file.
> > > >=20
> > > > Another example is pwm-samsung. It also has code specifically aimed=
 at
> > > > making sure the signal doesn't unexpectedly stay high after calling
> > > > pwm_disable(). See also the commit message of:
> > > >=20
> > > > 	6da89312a39b pwm: samsung: Fix output race on disabling
> > > >=20
> > > > Both of these examples sound very similar to what you're describing=
, so
> > > > I think it'd be best to follow these examples and fix the i.MX driv=
er to
> > > > behave as expected.
> > > Seeing that more hardware behaves like the mxs pwm makes me still more
> > > convinced that the pwm core should be aware of things like double
> > > buffering and different behaviour for disabling. Adding code to fulfil
> > > the API/user expectation to all three (and maybe more?) drivers seems
> > > wrong, don't you think?
> >=20
> > Erm... no. The whole point of a generic API is to abstract these kinds
> > of differences between various drivers. The goal is that users of the
> > API don't have to worry about the differences anymore and can expect a
> > certain behaviour.
> I agree to a certain degree here. Yes, an API is there to abstract
> between different drivers. But if the content of an API that was once
> been considered "generic" turns out to be not so generic after all, the
> right thing to do is to change it. If it's possible to keep the
> behaviour for users that's great, if not this shouldn't stop you.

What can possibly be more generic than:

	pwm_get()
	pwm_config()
	pwm_enable()
	pwm_disable()
	pwm_put()

? And you're not even arguing that the API isn't generic. What you're
complaining about is that the assumptions that it makes aren't what your
hardware does. Those are two orthogonal things.

> > > There are IMHO two possibilities to define the outcome of
> > > pwm_config(duty=3D0) + pwm_disable():
> > >=20
> > >  a) the output must be 0
> > >  b) the output is undefined
> > >=20
> > > For a) there are two further cases:
> > >=20
> > >  a1) each driver has to assert a) on its own
> > >  a2) the pwm framework knows about a few common behaviours and can
> > >      handle them.
> > >=20
> > > Currently we are at a1) (which is undocumented in Documentation/pwm.t=
xt
> > > btw). IMHO a1) is the worst of the three alternatives!
> >=20
> > Why do you think it is the worst? If we define the behaviour as b) what
> > does that gain us? Why would users want to call these functions if their
> The gain is that the three (or more?) pwm drivers don't need to special
> case an artificial requirement of the framework. OK, users have to
> adapt, but it's as simple as substituting all questionable calls to
> pwm_disable by a call to pwm_config(duty=3D0).

There is no gain. If users suddenly have to care about hardware
specifics I call that a loss. Equivalently if the PWM core framework
needs to know about these specifics that's also a loss because it puts
complexity in the core where device-specific properties clearly
shouldn't be handled.

> > behaviour is undefined? What that will result in is that code happens to
> > work with some PWM drivers but not with others. Then drivers will go and
> > implement workarounds that work only for specific drivers and so on.
> In this case the only "workaround" is to drop the pwm_disable. This is a
> correct fix however with my suggested change.

pwm_config(0) and pwm_disable() aren't the same. If you simply drop
these function calls the PWM framework and drivers loose potentially
useful information.

> > a2) isn't much better. It hides the specifics from the users, but at the
> a1) hides the specifics, don't it?

Yes it does. And your point is? I'm saying a2) hides the specifics from
users and that's a good thing. But the disadvantage is that you put the
burden on the core to deal with something that you could deal with much
better in the driver. There's no reason to do that.

> a2) explicitly states that there are specifics and users should be
> aware.

That's not how I read a2). I read it as the PWM core knowing the details
of drivers and internally handling what's necessary to hide them from
the users. There is absolutely no reason why users should have to care
about what happens if you turn off a clock immediately after applying a
new configuration. That's *exactly* what the API is supposed to hide.

> a1) *ignores* specifics at the cost of additional effort for drivers
> where a1) is wrong in hardware!

Oh hey, there's a good definition of what a generic API is. It is doing
exactly what it should do, why are you complaining?

> > same time it complicates the core because you're trying to generically
> > describe something that's inherently not generic. Device-specific code
> You claim that "pwms yield a constant 0 on disable".

No, that's not what I'm claiming. I'm saying that "a PWM outputs a
constant 0" is what the PWM framework defines to happen on disable.

> I say: "It depends on the pwm what happens if you disable it".

Of course it depends on the hardware. But that's exactly what we have
the abstraction for: so that we can treat all PWM devices in the same
way.

> Your claim is wrong for at least three pwms. Mine holds for all. So
> which is more generic?

Of course your claim is generic because it doesn't specify anything. You
want pwm_disable() to have an undefined result and call that generic.
Here's an idea: why don't we define the result of all functions to be
undefined? That way we get a really generic API.

We also get an API that's completely useless.

> Also note that with a) the API has two properties that are bad for an
> API:
>=20
>  - there are two ways to request the output to be constant low:
>     1) pwm_config(duty=3D0)
>     2) pwm_config(duty=3D0) + pwm_disable()

No, they are not the same. pwm_config() sets the duty-cycle but keeps
the PWM on. pwm_disable() disables the PWM. The waveform might be the
same, but the semantics are different. Subtly, but different.

>  - pwm_disable fills two different purposes:
>     1) The user has to (or can) use it as part of requesting a 0

It *can* use it if there's no need to keep the PWM running. For most
purposes there is no difference because the resulting signal is the
same. Think of pwm_disable() as suspending the PWM in addition to
keeping the signal at a constant low.

I'll grant you that for many use-cases the difference is insignificant
and most drivers will probably want to just always call:

	pwm_config(0)
	pwm_disable()

>     2) The user tells to not need the pwm any more

If you don't need the PWM any more you can just pwm_put() it. That's
different.

> Both are fixed by my suggestion.

Your suggestion doesn't fix anything. You keep saying that the API is
broken. But it isn't. By removing the pwm_disable() altogether you also
remove some amount of information that drivers may find useful.

> > belongs in drivers, not in the framework.
> Device-specific code belongs into the framework if it is common enough
> to allow simplification of several drivers. IMHO an API has two sides,
> in the case of the pwm framework it's:
>=20
>  - the drivers that use a pwm (e.g. drivers/leds/leds-pwm.c)
>  - the drivers that know how to operate a pwm (e.g.
>    drivers/pwm/pwm-mxs.c)
>=20
> If the API pleases both sides that's better than only being nice to one
> side.

I completely agree. But I don't see anything common here. There seem to
be two drivers now (pwm-bcm-kona and pwm-mxs) that require a delay after
applying a new configuration. There's over 30 PWM drivers, so 2 hardly
qualifies as "common".

Besides, the only commonality is that they require a certain time
between applying a configuration and disabling the PWM. The time isn't
constant, and while you say there's a correlation between the period and
the time it takes the configuration to apply on pwm-mxs the delay is
actually fixed for pwm-bcm-kona. Really, I don't see a way to add
support for this in the core in any beneficial way.

I don't get it. From what you're saying all that is required to fix your
driver is to add a single call to usleep_range() or msleep() with a
value that depends on the currently configured period. Why do you want
to make changes to the core for that?

> > > > Irrespective of the behaviour of current drivers, the assumptions a=
re
> > > > already codified in the user drivers and they all assume that calli=
ng
> > > > pwm_disable() means the PWM is off.
> > > Well, if you call pwm_disable for the mxs pwm, it is disabled
> > > instantly. Disabling just doesn't imply that the output goes to 0.
> >=20
> > Right, and that's precisely what other drivers have extra code for to
> > handle. If you look at the pwm-bcm-kona driver it has an extra delay of
> > 400 ns to make sure that the waveform is really updated.
> I claim it was already wrong to add this extra code to pwm-bcm-kona.
> Also note that in some usecases this delay is not needed (i.e. depending
> on where the delay is added, the user might not care if pwm_config is in
> effect when pwm_config returns or pwm_disable doesn't need to result in
> a 0 because it was just called in the error path of another driver).

Oh hey, we could add an asynchronous notification mechanism so that
users get notified when the configuration was actually applied...

> > > The problem at hand is updating the configuration doesn't end the
> > > current period. And then stopping the clock lets the output keep the
> > > last driven value.
> >=20
> > So why can't you just block in ->disable() until you know the output is
> > actually what's been requested? If you can't read that out from the
> > hardware, then simply wait for a whole period before stopping the clock.
> I can, but that's not the point. It complicates the driver while the
> availability of a few helper constructs in the framework could do this
> for three drivers.

Feel free to give this a shot if you feel the need. I'm unlikely to
merge anything that complicates the core to save a couple of lines in
the driver code.

The way to create these helper constructs is by looking for common
patterns and then providing common code to do it. As of now I don't see
any such common patterns, so there's no need to provide helpers that may
end up unused or used by only a single driver.

> > > Considering
> > >=20
> > > 	$ git grep \\\<pwm_disable | wc -l
> > > 	34
> > >=20
> > > going through all callers and fixing them up for changed semantics
> > > doesn't seem too hard. Still more as there are several false hits
> > > (approx 50%).
> >=20
> > Keep in mind that you'd need to retest all combinations of these users
> > with all PWM drivers to make sure you're not inadvertently breaking
> > existing setups.
> That's what we have release candidates for. If you really only want to
> take changes that with a probability of 0 break any existing setups, we
> can substitute you by a procmail rule that naks all patches.
> This is about best effort. Yes, API changes are annoying, but in the
> long run they are good.
> Having said that, I don't consider my suggested change as "dangerous".
> Changing the documented behaviour doesn't affect any setup. Then fixing
> each bug that pops up is good enough.

Since you seem to think that I oppose API changes on principle I should
clarify that I don't. I merely think that in this case it's completely
unnecessary and you've already admitted yourself that it's easy to make
your driver comply with the established assumptions.

Thierry

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFXqBAAoJEN0jrNd/PrOhsxIP/2b84TbL6QVQdiIVbZPDu4Rv
UMZVc7bPwZMrJRqCdJVZy1HrOjCbAtTpkWqHIPoFrEzJwUOFahJ4vYyB80VFriXj
3ObO8UslJSZ9NirfysVIA2RiQRwef/ofbuqyDw6lF0PK3U1B+iC+Lj3BZO2Kkd9Y
8eGQIQUksxsrb3cPfuFs95Np7YGrjTAHEvUR+Y9/SLwsvOE3f/Wo7A2Qa178HqBC
u9voPmpnoF1g2Dd2VcEMfZzWsMyKDYKqoXPCpNHT7V6wi4C67V6NP1uSLw5XAI33
W4CN/snKzu6EyD6QfyQXid/MWq2tWlHYlDaT4w1kdon26RwAxPJe8BRZOgI5v2fr
0XBqZ91zBkKCFIEiNT5U09JpDeunhA5Gbrj268rlDFW/jAhVbQXT251jcOpZ1H4I
n2uhIhTYt5bNkbKb0wohE2yvAj8P0vMiIUVZDAGzfDh7kinsy+IS2OYnPUTx/axJ
P4ZZmnpCMEaufNhp35cnsxR+lHdmxZRjDQ8yxKg7QLbMXMXIq54fkHoKQW9rG1w9
7YWm7AF+5xK2z28Myeu0su/uWmFGjSwMGYalQyLEmwQKVGualhnwsHE1OvrlJghA
eOreKFdpb0R0uHMyJbEC1DpIZvj00FtD+Ta/I0UPiCcE1vnp62cjvgdyke/0K0vR
2rPJh6MK0oMh39MZ2Yck
=ylTD
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
