Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 18 Oct 2018 22:43:11 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
Message-ID: <20181018204311.nigxaap763k44dj3@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
 <20181009073407.GA5565@ulmo>
 <20181009090401.3mlceegalzo53bd7@pengutronix.de>
 <20181016094417.64114816@bbrezillon>
 <20181018084405.so5zabawknwkwacs@pengutronix.de>
 <20181018144414.GA6226@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181018144414.GA6226@ulmo>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de, linux-pwm@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

On Thu, Oct 18, 2018 at 04:44:14PM +0200, Thierry Reding wrote:
> On Thu, Oct 18, 2018 at 10:44:05AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 16, 2018 at 09:44:17AM +0200, Boris Brezillon wrote:
> > > I kinda agree with Uwe on this point. The "disable PWM on duty=3D0% or
> > > duty=3D100%" logic should, IMHO, be a HW-specific optimization.
> >=20
> > Note that according to Thierry the behaviour of
> >=20
> > 	pwm_config(pwm, 100, 100);
> > 	pwm_disable(pwm);
> >=20
> > (and similarily of
> >=20
> > 	pwm_apply_state({.period =3D 100, .duty_cycle =3D 100, .enabled =3D fa=
lse});
> >=20
> > ) should (assuming an uninverted pwm) result in the output stopping at 0
> > (i.e. it's inactive level which is the same as after pwm_config(pwm, 0,=
 100)).
> >=20
> > So there isn't anything special about "disable PWM on duty=3D0% or
> > duty=3D100%". "disable PWM" in Thierry's eyes is always "stop at inacti=
ve
> > level" independant of the previously configured duty cycle.
> >=20
> > You talking about the specific cases 0% and 100% makes me believe that
> > you are an example (BTW, I'm another) that makes Thierry's claim
> >=20
> > 	The current assumption by all users is more that [after
> > 	pwm_disable()] the pin would stop at the no power state, which
> > 	would be 0 for normal PWM and 1 for inverted.
> >=20
> > wrong. (See mail with Message-ID: 20181012095349.GA9162@ulmo in this
> > thread.)
>=20
> Let's be specific here: the vast majority of PWM consumers currently
> are pwm-backlight, leds-pwm and pwm-fan. All of them call pwm_disable()
> when the devices are turned off (backlight and LED turn off, fan stops)
> which is equivalent to duty-cycle =3D 0.

Ah, you're talking about drivers making use of the PWM API, I thought
we're talking about the people working with PWMs.

The pwm-backlight driver only calls pwm_disable() after
pwm_config(pb->pwm, 0, pb->period). Same for leds-pwm. So I'd claim
their expectation is that pwm_disable() freezes the pwm, not that it
stops at idle. pwm-fan is strange, mixing the old API with
pwm_apply_state, assuming the maximal allowed duty cycle is period - 1,
so I'm not taking that one into account to argue.

> > To get forward here: Thierry, can you please confirm that there is no
> > semantical difference between "pwm_disable()" and "pwm_config(pwm, 0,
> > period)". (Or alternatively come up with a use case where a difference
> > really matters. I'm sure this is impossible though.)
>=20
> And here I was hoping that we were making progress on this. Now you're
> taking us back to square one...

You wrote above that pwm_disable is equivalent to duty-cycle =3D 0. So we
are at an agreement finally it seems.

And yes, I asked you again for an example because "there is a difference
and some might care and use that difference" isn't an argument that is
getting us further. If the statement is true it would be more
cooperative to explain the difference and why it matters. As is it only
thwarts my efforts without a possibility to effectively accept or refute
it.

> > Then I can start simplifying API users and adapt the pwm
> > hardware drivers. When this is done there will be no user left of
> > pwm_disable and struct pwm_state::enabled because nobody needs it with
> > the current semantic. After that we can either rip the concept of
> > pwm_disable or shift it's semantic to my initial suggestion of "no
> > guarantees about the output level" and use that in the few drivers that
> > really don't care about the output level[1] and so give the hardware the
> > possibility to disable the clock even if that results in something
> > different than "inactive".
>=20
> I have repeatedly told you that not making any guarantees is completely
> useless. I can't think of a reason why any PWM consumer would ever want
> to have the pin go into an undefined state.

No driver *wants* the pin go to an undefined state. But it might
indicate that doing so is acceptable without interfering with its
intentions. The example I had was a display that has both an enable GPIO
and a PWM for backlight. When the driver disables the display using the
GPIO the state of the PWM doesn't matter and it could call pwm_disable()
with the semantic I want pwm_disable to have.

> > As a first step I'd suggest to explicitly state the expectations on
> > hardware driver implementations and pwm-API users to get all affected
> > parties in line. These are in my eyes:
> >=20
> >  - configuring the duty cycle should (if possible) not result in
> >    glitches, so the currently running period should be completed and
> >    after that a new period with the new configuration should start.
> >    (Is this reasonable to expect this from all implementations? If not
> >    we should maybe introduce a way to let the users know?)
> >=20
> >  - The function to configure the duty cycle should only return when the
> >    period with the new configuration actually started.
>=20
> Yes, those two are reasonable expectations in my opinion.
>=20
> > If the concept of pwm_disable() stays, we should document the expected
> > behaviour of the pin. Something like:
> >=20
> >  - After disabling the pwm you must not make any assumptions about the
> >    pin level. It might be low, or inactive, or even high-z. So don't
> >    disable the pwm if you for example care about a display backlight to
> >    stay off.
>=20
> Like I said multiple times, that's completely useless. Can you please
> provide an example where a consumer would possible want that behavior?

see above.

Do you think it's sensible to keep pwm_disable() with the current semantic
(i.e. same result as pwm_config(pwm, 0, period))? If not, what is in
your eyes the best that should be done with the findings of this thread?

> > If desired we might even keep the behaviour for the sysfs implementation
> > that disable there for historic reasons keeps the semantic of
> > duty-cycle=3D0.
> >=20
> > Further things that could be done (eventually after discussing they are
> > really sensible) are:
> >=20
> >  - for pwms that can be programmed now for the next period implement the
> >    necessary sleep in the PWM-Framework (mxs, atmel, sun4i at least);
>=20
> I fail to see the point in this. It's incredibly trivial to do this in
> the drivers.

It's better to have code that handles identical situations for several
drivers in a single place. Even if the code in question is simple.
Having only the stuff in a hardware driver that cannot be shared
simplifies understanding what it does, increases code coverage,
simplifies identifying further stuff that can be factored into the core.
And if you later notice that the simple stuff needs an adaption because
it isn't that simple after all or should cover another use case, you
only touch a single place. Then testing this change on a single
implementation gives more confidence that the change is also right for
the other affected drivers than when you fix each individual instance
individually.

> And a sleep is perhaps the simplest way to implement this
> and could technically be made generic and handled in the core, but the
> hardware could just as well have a mechanism to signal the beginning of
> the next period in some bit in a register.

I agree, if the hardware has a means to detect when the new period
started, that should be used instead of the generic sleep. That's why
the sleep in the core should only be used by the others.

> So why would you want to add code to the core that's highly device
> dependent?

I want to add code to the core that is generic enough to be used by
several drivers. For that to be useful it's not necessary that all
drivers benefit from that.

> What do you gain from it? If we already have the expectations
> documented that ->config() must only return after the settings have
> been applied, then why move some of the responsibility back into the
> core?

To simplify the hardware drivers and not solve the same problem (even if
it's easy) in a single place. And note, I want pwm_config to return only
after the settings are active, I didn't talk about the callback that hw
drivers have to implement. That's because ideally the PWM framework
isn't only a shim layer between the hardware and PWM users but it
implements things that are useful for both sides. So the things that a
caller of pwm_config should be able to rely on doesn't necessarily need
to be inherited to the implementers of the .config callback.

> >  - abstract inversed pwms in the framework instead of each hw driver;
>=20
> What exactly are you propsing here? We've had this discussion just a
> couple of days ago and I already mentioned why the duty cycle inversion
> is not the same thing as the signal inversion.

Right, you claimed there is a difference. I argued that nobody can make
use of that difference because it's only a shift and as the period
borders are not communicated back to the PWM user there is nothing that
can be synced to it. Can you contradict that?

Also, when changing the polarity glitches can happen, even more so when
the PWM is disabled. Take for example an uninverted PWM running at 50%
that is then inverted and disabled at A and then enabled again at B:
     ____      ____            ____
    /    \____/    \____/\____/
    ^         ^         ^^
                      A  B

It might result in a peek which depending on the use case might be bad.

> >  - let hw drivers correct *state on apply
> >    (if the user requests period=3D1ms and the driver can only provide
> >    multiples of 0.6667 ms because the input clock is fixed at 1500 Hz)
>=20
> That's not a very good idea. If the user requests a configuration that
> can't be met we should return an error, not silently apply something
> that we think is good enough and hope that the user noticed that and
> tries a different configuration instead.

I don't care much how this is done. The clk API explicitly states that
clk_set_rate might not exactly set the desired rate and provides a
function (clk_round_rate) to prophesy the result. That's what I had in
mind and what might make sense for PWM, too. After all most drivers have
to implement rounding already now if the granularity of period and duty
isn't a divisor of 1 ns.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
