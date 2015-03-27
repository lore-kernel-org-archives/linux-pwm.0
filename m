From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] leds/pwm: don't call pwm_disable when setting
 brightness
Date: Fri, 27 Mar 2015 15:35:59 +0100
Message-ID: <20150327143559.GZ32677@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150325101428.GB32677@pengutronix.de>
 <20150325120039.GA16310@ulmo.nvidia.com>
 <20150327085942.GA10906@pengutronix.de>
 <20150327112607.GD5440@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbbC0Og3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Mar 2015 10:36:29 -0400
Content-Disposition: inline
In-Reply-To: <20150327112607.GD5440@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Andrew Morton <akpm@linux-foundation.org>, linux-leds@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Tim Kryger <tim.kryger@linaro.org>, Alex Elder <elder@linaro.org>, Markus Mayer <markus.mayer@linaro.org>

[added the people being involved with the other two drivers in question=
,
maybe you want to comment?]

Hello Thierry,

On Fri, Mar 27, 2015 at 12:26:08PM +0100, Thierry Reding wrote:
> On Fri, Mar 27, 2015 at 09:59:43AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 25, 2015 at 01:00:40PM +0100, Thierry Reding wrote:
> > > On Wed, Mar 25, 2015 at 11:14:28AM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > On Thu, Feb 12, 2015 at 10:44:48AM +0100, Uwe Kleine-K=F6nig wr=
ote:
> > > > > on arm/i.MX28 the leds connected to a pwm are still broken an=
d it's more
> > > > > than three years ago that I came up with these patches. I sti=
ll consider
> > > > > them to do the right thing and they fix a real bug.
> > > > I'm really frustrated here. I want to fix a real bug, made seve=
ral
> > > > suggestions (with patches) how to fix it and still have to incl=
ude my
> > > > local patches in each project that uses leds on i.MX28's pwm ou=
tput.
> > > >=20
> > > > Thierry, how can we get this resolved?
> > >=20
> > > We have a couple of other drivers already solving similar issues.=
 Look
> > > for example at the pwm-bcm-kona driver. It explicitly sets the du=
ty
> > > cycle to 0 on ->disable() and then waits for some time before act=
ually
> > > disabling the clock (specifically to avoid a similar than you see=
m to
> > > have on i.MX). See also the notes near the top of the driver sour=
ce
> > > file.
> > >=20
> > > Another example is pwm-samsung. It also has code specifically aim=
ed at
> > > making sure the signal doesn't unexpectedly stay high after calli=
ng
> > > pwm_disable(). See also the commit message of:
> > >=20
> > > 	6da89312a39b pwm: samsung: Fix output race on disabling
> > >=20
> > > Both of these examples sound very similar to what you're describi=
ng, so
> > > I think it'd be best to follow these examples and fix the i.MX dr=
iver to
> > > behave as expected.
> > Seeing that more hardware behaves like the mxs pwm makes me still m=
ore
> > convinced that the pwm core should be aware of things like double
> > buffering and different behaviour for disabling. Adding code to ful=
fil
> > the API/user expectation to all three (and maybe more?) drivers see=
ms
> > wrong, don't you think?
>=20
> Erm... no. The whole point of a generic API is to abstract these kind=
s
> of differences between various drivers. The goal is that users of the
> API don't have to worry about the differences anymore and can expect =
a
> certain behaviour.
I agree to a certain degree here. Yes, an API is there to abstract
between different drivers. But if the content of an API that was once
been considered "generic" turns out to be not so generic after all, the
right thing to do is to change it. If it's possible to keep the
behaviour for users that's great, if not this shouldn't stop you.

> > There are IMHO two possibilities to define the outcome of
> > pwm_config(duty=3D0) + pwm_disable():
> >=20
> >  a) the output must be 0
> >  b) the output is undefined
> >=20
> > For a) there are two further cases:
> >=20
> >  a1) each driver has to assert a) on its own
> >  a2) the pwm framework knows about a few common behaviours and can
> >      handle them.
> >=20
> > Currently we are at a1) (which is undocumented in Documentation/pwm=
=2Etxt
> > btw). IMHO a1) is the worst of the three alternatives!
>=20
> Why do you think it is the worst? If we define the behaviour as b) wh=
at
> does that gain us? Why would users want to call these functions if th=
eir
The gain is that the three (or more?) pwm drivers don't need to special
case an artificial requirement of the framework. OK, users have to
adapt, but it's as simple as substituting all questionable calls to
pwm_disable by a call to pwm_config(duty=3D0).

> behaviour is undefined? What that will result in is that code happens=
 to
> work with some PWM drivers but not with others. Then drivers will go =
and
> implement workarounds that work only for specific drivers and so on.
In this case the only "workaround" is to drop the pwm_disable. This is =
a
correct fix however with my suggested change.

> a2) isn't much better. It hides the specifics from the users, but at =
the
a1) hides the specifics, don't it? a2) explicitly states that there are
specifics and users should be aware. a1) *ignores* specifics at the cos=
t
of additional effort for drivers where a1) is wrong in hardware!

> same time it complicates the core because you're trying to genericall=
y
> describe something that's inherently not generic. Device-specific cod=
e
You claim that "pwms yield a constant 0 on disable". I say: "It depends
on the pwm what happens if you disable it". Your claim is wrong for at
least three pwms. Mine holds for all. So which is more generic?

Also note that with a) the API has two properties that are bad for an
API:

 - there are two ways to request the output to be constant low:
    1) pwm_config(duty=3D0)
    2) pwm_config(duty=3D0) + pwm_disable()

 - pwm_disable fills two different purposes:
    1) The user has to (or can) use it as part of requesting a 0
    2) The user tells to not need the pwm any more

Both are fixed by my suggestion.

> belongs in drivers, not in the framework.
Device-specific code belongs into the framework if it is common enough
to allow simplification of several drivers. IMHO an API has two sides,
in the case of the pwm framework it's:

 - the drivers that use a pwm (e.g. drivers/leds/leds-pwm.c)
 - the drivers that know how to operate a pwm (e.g.
   drivers/pwm/pwm-mxs.c)

If the API pleases both sides that's better than only being nice to one
side.

> > > Irrespective of the behaviour of current drivers, the assumptions=
 are
> > > already codified in the user drivers and they all assume that cal=
ling
> > > pwm_disable() means the PWM is off.
> > Well, if you call pwm_disable for the mxs pwm, it is disabled
> > instantly. Disabling just doesn't imply that the output goes to 0.
>=20
> Right, and that's precisely what other drivers have extra code for to
> handle. If you look at the pwm-bcm-kona driver it has an extra delay =
of
> 400 ns to make sure that the waveform is really updated.
I claim it was already wrong to add this extra code to pwm-bcm-kona.
Also note that in some usecases this delay is not needed (i.e. dependin=
g
on where the delay is added, the user might not care if pwm_config is i=
n
effect when pwm_config returns or pwm_disable doesn't need to result in
a 0 because it was just called in the error path of another driver).

> > The problem at hand is updating the configuration doesn't end the
> > current period. And then stopping the clock lets the output keep th=
e
> > last driven value.
>=20
> So why can't you just block in ->disable() until you know the output =
is
> actually what's been requested? If you can't read that out from the
> hardware, then simply wait for a whole period before stopping the clo=
ck.
I can, but that's not the point. It complicates the driver while the
availability of a few helper constructs in the framework could do this
for three drivers.

> > Considering
> >=20
> > 	$ git grep \\\<pwm_disable | wc -l
> > 	34
> >=20
> > going through all callers and fixing them up for changed semantics
> > doesn't seem too hard. Still more as there are several false hits
> > (approx 50%).
>=20
> Keep in mind that you'd need to retest all combinations of these user=
s
> with all PWM drivers to make sure you're not inadvertently breaking
> existing setups.
That's what we have release candidates for. If you really only want to
take changes that with a probability of 0 break any existing setups, we
can substitute you by a procmail rule that naks all patches.
This is about best effort. Yes, API changes are annoying, but in the
long run they are good.
Having said that, I don't consider my suggested change as "dangerous".
Changing the documented behaviour doesn't affect any setup. Then fixing
each bug that pops up is good enough.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
