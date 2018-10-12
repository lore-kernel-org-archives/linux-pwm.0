Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 11:53:49 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181012095349.GA9162@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <20181011203450.muo4eoj4mnqo634a@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20181011203450.muo4eoj4mnqo634a@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2018 at 10:34:50PM +0200, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > We can speculate about that as much as we want. i.MX is the only one
> > that this issue has been reported against, so I'm going to have to
> > assume that it's working fine for all of the others. If it isn't then
> > people should come forward and report it.
>=20
> You really assume that all the drivers that don't make use of
> PWM_POLARITY_INVERSED (33 of 50 + imx at least, probably more) behave as
> you expect when the PWM user does:
>=20
> 	pwm_apply_state(pwm, { .period =3D 100; .duty_cycle=3D0; polarity=3DPWM_=
POLARITY_INVERSED; enabled=3Dfalse; })
>=20
> ? I'd say your assumption that all are working fine is treading on thin
> ice. The effect maybe is only that the i.MX users use more corners of
> the PWM API and/or are more open to report actual problems.

Look, it's unrealistic to expect me to actually test or verify all of
the different PWM controllers out there. The only thing I can go by is
by what the maintainers of the individual drivers tell me, or what has
been reported by users. So I'm going to assume that a driver works until
somebody reports that it is broken.

So again, if somebody notices that any of the other drivers are broken,
please do report it so that it can be fixed. Otherwise I don't have a
choice but assume that they still work.

> Also if there are two ways to implement something, one works for 49
> different hardware implementations and one for 50 this is already a good
> reason to stick to the latter.

This discussion isn't going anywhere, we're going in circles. I was not
suggesting that we don't find a solution for i.MX, I'm just saying that
changing the API is papering over some more fundamental issue on i.MX.
You can't magically fix it by changing the API, you have to get pinctrl
involved to properly solve this problem.

> > > > Given that stricter definition,
> > > > the i.MX PWM driver becomes buggy because it doesn't guarantee that=
 pin
> > > > state. I think the fix for that is for the i.MX PWM driver to make =
sure
> > > > the pin state doesn't actually change on ->disable(). If that means=
 the
> > > > clock needs to remain on, then that's exactly what the driver shoul=
d be
> > > > implementing.
> > >=20
> > > Yes, if we keep the API "stricter" this is what should be done. This
> > > doesn't justify to keep the API strict though.
> >=20
> > But an API that isn't strict is useless. If the behaviour of a PWM isn't
> > predictable, how can you use it to drive a backlight. If at any point it
> > could just go 100% and turn on the backlight to full brightness, how can
> > anyone use it for anything sensible?
>=20
> As long as I don't call pwm_disable() (or pwm_config(pwm, period,
> period)) it must not go to 100%.

I've been arguing that even if you call pwm_disable() it shouldn't go to
100%. So to summarize the problem for i.MX here: at reset time, the pin
driving the PWM is configured as GPIO and is configured as input with a
high impedance, so that it will be high on boot, prior to any software
running. This is reasonable in order to make sure that the backlight
stays off until it is properly initialized. What I've been trying to
convey is that when you do pwm_disable() the pin should go into exactly
that initial configuration to make sure the backlight doesn't behave in
an undefined way.

> > > > Are you aware of this:
> > > >=20
> > > > 	http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D69987
> > > >=20
> > > > This seems to address exactly the problem that you're describing. T=
he
> > > > solution matches what I had expected a fix for this problem to look
> > > > like. Can you try it and see if that fixes the issue?
> > >=20
> > > Right. Apart from bugs in it (for example
> > > http://patchwork.ozlabs.org/patch/981774/ does never configure the gp=
io
> > > as output) this would solve the issue for sure. This doesn't void my
> > > arguments to relax the PWM API though. Also look at the costs: The pa=
tch
> > > adds 86 lines to the imx driver complicating it considerably.
> >=20
> > Now you're just being dramatic. 86 lines of code is not a lot. And I
> > don't think it's complicated. I'm willing to carry the burden of those
> > 86 lines of code if it fixes the issue for good.
>=20
> Right, the complexity doesn't come with the 86 lines of code. With my
> approach the pwm-imx driver only has to care about its 6 registers. With
> Michal's patch it suddenly has to care about gpio and pinmuxing.

Why is that a bad thing? They are fundamentally entangled here, so why
do you think that's inappropriate?

> > >                                                               Each
> > > machine that wants to profit of this change has to adapt it's device
> > > tree to make the additional pinmuxing and gpio known.
> > > To be fair, my change doesn't fix the gap between pinctrl being active
> > > and the actual enablement of the pwm. But this could be better solved=
 in
> > > the pwm framework without touching any hardware driver with pinctrl
> > > mechanism that are already in place. (Make use of the "init" pinctrl
> > > state and only switch to "default" when the pwm is configured.)
> > > There is nothing imx-pwm specific in hooking a gpio and adapting the
> > > pinmuxing in it. So if you want to go this path, please implement it =
in
> > > a generic way such that all pwm devices could benefit.
> >=20
> > You're wrong. Judging by all the evidence that we have at this point,
> > this is exactly an imx-pwm specific issue, therefore the burden is on
> > the imx-pwm driver to implement a solution for it.
>=20
> You're the first maintainer I met with this attitude. Whenever I
> implemented something in a driver specific way fixing an issue that
> other drivers might have to, I was requested to find a generic solution
> without the need to analyse if other drivers are affected or not.

Well, you should be happy. Dealing with this at a driver level is really
much easier than trying to come up with a generic solution. And maybe
you have met maintainers with a different attitude, so what? People have
different opinions and experiences. This shouldn't be a surprise.

In my opinion it's better to not try and generalize upfront. If you try
to create a generic solution if all you have is a single use-case, you
are bound to get it wrong. You're "generic" solution is likely to tailor
to the particular use-case and make it unusable for any others. So I try
not to attempt genericity until there are at least two or more use-cases
that can be the basis for a generic solution.

> There are some subsystems (e.g. tty/serial) where there is much stuff
> implemented in each driver even though some things could well be
> implemented in a generic way (e.g. rs485 handling). This is really a big
> mess.

One person's mess is merely another person's filing system.

> I reread your explanation several times and fail to understand it. It
> would be very helpful if you could come up with a scenario where it's
> obvious that the distinction is needed. You're writing about "typical
> use-cases" and "value in having the additional flexibility" without
> providing a use-case that is atypical or actually need the flexibility.
>=20
> Maybe I don't understand the semantic you're giving to the calls or
> we're using the same words to describe different things. I try
> to describe the semantic of pwm_disable of the strict API in my words,
> can you please confirm or correct that?:
>=20
> 	pwm_disable stops toggling the PWM pin at whatever state the pin
> 	currently is. Given a duty cycle between 0% and 100% (exclusive)
> 	that means the pin stops at an undefined level. If the duty
> 	cycle is 0% or 100% it stops (for an uninverted PWM) at 0 or 1
> 	respectively (and vice versa for an inverted one).

No, I don't think that's entirely correct. The current assumption by all
users is more that the pin would stop at the no power state, which would
be 0 for normal PWM and 1 for inverted.

This is what's reasonable for most or all cases. It's pretty much the
same as for a clock, or a regulator or any other number of devices.

> The semantic of pwm_enable in my understanding is:
>=20
> 	pwm_enable for an uninverted PWM starts with $duty_cycle
> 	nanoseconds at 0 and then is 1 for $period - $duty_cycle
> 	nanoseconds. Then repeat.
> 	For an inverted it is first 1 for $duty_cycle nanoseconds and
> 	then 0 for the rest of the period.
>=20
> I think pwm_config is to be defined like this:
>=20
> 	pwm_config changes period and duty cycle without any
> 	specification about how the transition should be done.
>=20
> All calls should be synchronous, that is should only return when the
> change is actually "on the pin".

Correct.

> > > > >  - most API users can be simplified because they can drop
> > > > >      if (duty =3D=3D 0) pwm_disable()
> > > > >  - on i.MX the clock can be disabled when not needed saving some =
energy;
> > > >=20
> > > > That's one reason why we have pwm_disable(). It's what you use to s=
ave
> > > > some energy if you don't need the PWM. Also, you claim that if the =
clock
> > > > is disabled the attached backlight will turn on at full brightness,=
 so I
> > > > fail to see how this would work.
> > >=20
> > > As long as you care about the backlight to be off, don't disable the
> > > pwm. And if in this state the clk can be disabled, then this should be
> > > done without an additional poke by the hardware driver which is the o=
nly
> > > place that can know for sure that it is safe to do so. There is no go=
od
> > > reason to let the pwm user have to know that the currently configured
> > > state might make some energy saving possible and impose the burden on
> > > him to then call pwm_disable().
> >=20
> > This doesn't have anything to do with consumers knowing about potential
> > energy savings. All we do is give the consumers an opportunity to say: I
> > need the PWM to be enabled because I want to use the PWM signal now or I
> > don't really need the PWM signal any more, just stop sending a signal.
>=20
> There are two different degrees of "I don't need the PWM signal any
> more". In the first case you still care about the output level and in
> the other you don't. Currently the API doesn't give the PWM user the
> possibility to specify which of the two are intended.

I've said before that "don't care about the output level" is completely
useless. In most cases what you really want is the "no power" state and
that's what pwm_disable() should ensure. You're PWM could be controlling
a fan, and when you disable the PWM you want the fan to stop spinning,
right? You wouldn't want the fan to keep spinning after you've disabled
it.

This is something that most hardware engineers will also understand.
They tend to design their systems in such a way that the reset defaults
will have sensible effects. I think it's good in general to attempt, if
possible, to restore those reset defaults when you disable the device
that you're driving.

> > > happy when I fix the problem during active operation because on the
> > > machine I currently care about the shutdown problem isn't relevant.
> >=20
> > Why is it not relevant? Surely at some point you will want to shut down
> > that machine.
>=20
> Does a shutdown do anything with a running pwm software wise? The
> leds-pwm driver doesn't have a shutdown hook. The pwm_bl driver calls
> pwm_free in some legacy configuration but otherwise does nothing that
> would undo it's pwm_backlight_power_off() in the shutdown hook. So I'm
> convinced shutdown is fine here.

But pwm_backlight_power_off() will also end up calling pwm_disable(),
which by your description of the problem would fully light up the
backlight. That is, unless your driver implement ->apply(), but in that
case you wouldn't have a problem anyway.

> > And even if not, imx-pwm is used by others and they do
> > seem to care about shutdown, so they should have a say in the matter as
> > well.
>=20
> Note that my suggestion doesn't make things worse for those users who
> care. I'm used to that it's good enough if a patch improves the
> situation for some users and doesn't make it worse for the others.
>=20
> > > (Also as noted above, even Michal's patch doesn't solve the problem
> > > formally.)
> >=20
> > Now I'm confused, you said above that "Apart from bugs in it ... this
> > would solve the issue for sure". So which one is it?
>=20
> I'm sure that you must not assume that after
>=20
> 	gpio_direction_output(gpio, 0);
> 	gpio_free(gpio);
>=20
> the line still drives the 0. In most cases this will be the case, but if
> this makes the GPIO switch to being an input that should be correct
> behaviour, too. That's why I wrote "formally" above.
>=20
> Michal's patch solves the gap at startup and when the PWM user calls
> disable() formally. At unbind when the gpio is freed it's "only" in
> practise.

That's why pinctrl is also involved. That should ensure that the correct
level is driven to the pin even if it isn't actively driven by either
GPIO or PWM.

> I listed several reasons to change the API, for some you confirmed them
> to be valid. You listed some for keeping the API as is. As I'm
> convinced my suggestion is good and your reasons are smaller (or even
> bad), I try to argue against them.
>=20
> The above question was my try to summarize your reasons and to make sure
> the list is complete. I didn't try to turn anything around and if that
> was your impression that's a misunderstanding.
>=20
> With my current understanding the list of reasons to stick to the status
> quo is:
>=20
>  - it has been like that for ages
>    (which is a poor reason to oppose to change);
>  - it works for everyone but i.MX
>    (which I doubt and with my replacement it works for all drivers and
>    users as now including i.MX and maybe others that have the same issue
>    without us knowing it currently);
>  - it could be made working for i.MX by involving pinctrl and gpio in
>    the hardware specific pwm driver (which is ridiculous because my
>    solution is simpler); and
>  - we're changing API
>    (which I'd say is ok given that the specification isn't very specific
>    and breaking the API for good reasons is not nice but acceptable IMHO)
>=20
> In my eyes in the above list there is one valid reason to not change
> (the last one). If you don't agree to change the userspace API we could
> keep that constant and only change the kernel-internal API (which is a
> bit ugly though).
>=20
> The list of reasons in favour of a change are:
>=20
>  - the pwm-imx driver can stay/become easier as with the stricter API;
>  - ambiguity removed
>    (hw drivers know in .disable if they can put the pin at a previously
>    "forbidden" value)
>  - users can be simplified by dropping some pwm_disable()
>=20
> So now how can we come to a conclusion? Here are my suggestions for a
> compromise:
>=20
> What about adding a new callback that we could for example call
> "disable_lax" that implements disabling the PWM without the guarantee to
> put the pin in the "off" state?
>=20
> We could also introduce a callback "freeze" (or disable_strict) that is
> supposed to implement the "strict" disable. Then there is an objective
> way to determine when all drivers are adapted to the updated model.
>=20
> Do you agree to my suggestion that pwm_config(pwm, 0, period) or similar
> should already imply disabling clocks if possible without the need to
> explicitly call pwm_disable() afterwards?

I don't think it has to be that explicit. Drivers should certainly feel
free to do so if it works and is reasonable.

To be honest, the whole discussion here is somewhat unproductive. You're
arguing about changing an API that's deprecated anyway, even if not
officially. We already introduced the atomic API a few years ago that is
meant to address most of these issues.

So instead of trying to "fix" a legacy API, have you considered moving
the i.MX driver to the atomic API? That should give you much better
control over when and how to program the registers.

Thierry

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAbykACgkQ3SOs138+
s6EjHxAArnErFb71/eYhSkoIzxinpbpsATcG262HC6rQfRt1FY9IEVGaAu+6K1xD
DhElyhUaf0HW296QZMPs0PAxkeSrH6b3NOLrEycmhOFmp+qtgd04t8ooZK5A+jG/
HYNk6RdMD6k+RPaBc/bmfuSH/pOsbp8S37MZyCrwU8+Bx/4cv/EXNmcpSlMfJ5KV
eO0tC80O7CBjsbv00t4Z4DrIQoo/sixPZaBeE/F3Krfb3ChMpyDZRVFx+V6HV1rX
iwmN2df7zFS3kKmf0qTH1FhZWDq4XMzof55Jjg+JtNx8Q9ex71p/Wtj8AxaEe4BT
XsUTNCZ7SN/8Pi00gX82OBnqm2gUQuYXwe4QsJox/t4NJdCpxEOcv/jOwerqTZlb
P7pZLIeu8NJ7KdB5+x6w9mQuChobt4f1E9v6u4UsXYAv3mE88V2LYz9Qc/u5pAtP
ZcktXn0e6NWjg66fu7T6KRgn5eOYnXMG/Tvr5m4TNCovJVQiXkllws4WeJoeoRe+
Kse96kdhodC3/mLD32r3o9JWRwP+U5G4pKLUgCKxjra9DdbNpDTWIcDaEIQKxsWB
ng7QjiSM9ogpqV/Zc0zp8JtudVxojEKXoiQPYFnpqQWfhmvdEyJxlhJirnztgzZc
BG7sbNBV//VtKIZPqFP6CXon39bpPM/7i5jEfeSrHue6CewVEB8=
=rN01
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
