Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 18 Oct 2018 10:44:05 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
Message-ID: <20181018084405.so5zabawknwkwacs@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
 <20181009073407.GA5565@ulmo>
 <20181009090401.3mlceegalzo53bd7@pengutronix.de>
 <20181016094417.64114816@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181016094417.64114816@bbrezillon>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Boris,

On Tue, Oct 16, 2018 at 09:44:17AM +0200, Boris Brezillon wrote:
> On Tue, 9 Oct 2018 11:04:01 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello Thierry,
> >=20
> > thanks for taking time to reply in this thread.
> >=20
> > On Tue, Oct 09, 2018 at 09:34:07AM +0200, Thierry Reding wrote:
> > > On Mon, Aug 20, 2018 at 04:43:56PM +0200, Uwe Kleine-K=F6nig wrote:  =

> > > > Contrarily to the common assumption that pwm_disable() stops the
> > > > output at the state where it just happens to be, this isn't what the
> > > > hardware does on some machines. For example on i.MX6 the pin goes to
> > > > 0 level instead.
> > > >=20
> > > > Note this doesn't reduce the expressiveness of the pwm-API because =
if
> > > > you want the PWM-Pin to stay at a given state, you are supposed to
> > > > configure it to 0% or 100% duty cycle without calling pwm_disable().
> > > > The backend driver is free to implement potential power savings
> > > > already when the duty cycle changes to one of these two cases so th=
is
> > > > doesn't come at an increased runtime power cost (once the respective
> > > > drivers are fixed).
> > > >=20
> > > > In return this allows to adhere to the API more easily for drivers =
that
> > > > currently cannot know if it's ok to disable the hardware on
> > > > pwm_disable() because the caller might or might not rely on the pin
> > > > stopping at a certain level.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  Documentation/pwm.txt | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-) =20
> > >=20
> > > I don't think this is correct. An API whose result is an undefined st=
ate
> > > is useless in my opinion. So either we properly define what the state
> > > should be after a disable operation, or we might as well just remove =
the
> > > disable operation altogether. =20
> >=20
> > Explicitly not defining some details makes it easier for hardware
> > drivers to comply with the API. Sure it would be great if all hardware
> > would allow to implement a "stronger" API but this isn't how reality lo=
oks
> > like.
> >=20
> > You say it's bad that .disable() should imply less than it did up to
> > now. I say .disable() should only imply that the PWM stops toggling, so
> > .disable has a single purpose that each hardware design should be able
> > to implement.
> > And this weaker requirement/result is still good enough to implement all
> > use cases. (You had doubts here in the past, but without an example. I
> > cannot imagine there is one.) In my eyes this makes the API better not
> > worse.
> >=20
> > What we have now in the API is redundancy, which IMHO is worse. If I
> > want the pwm pin to stay low I can say:
> >=20
> > 	pwm_config(pwm, 0, 100);
> >=20
> > or I can say:
> >=20
> > 	pwm_config(pwm, 0, 100);
> > 	pwm_disable(pwm);
> >=20
> > The expected result is the same. Now you could argue that not disabling
> > the pwm is a bug because it doesn't save some energy. But really this is
> > a weakness of the API. There are two ways to express "Set the pin to
> > constant 0" and if there is an opportunity to save some energy on a
> > certain hardware implementation, just calling pwm_config() with duty=3D0
> > should be enough to benefit from it. This makes the API easier to use
> > because there is a single command to get to the state the pwm user wants
> > the pwm to be in. (This is two advantages: A single way to reach the
> > desired state and only one function to call.)
>=20
> I kinda agree with Uwe on this point. The "disable PWM on duty=3D0% or
> duty=3D100%" logic should, IMHO, be a HW-specific optimization.

Note that according to Thierry the behaviour of

	pwm_config(pwm, 100, 100);
	pwm_disable(pwm);

(and similarily of

	pwm_apply_state({.period =3D 100, .duty_cycle =3D 100, .enabled =3D false}=
);

) should (assuming an uninverted pwm) result in the output stopping at 0
(i.e. it's inactive level which is the same as after pwm_config(pwm, 0, 100=
)).

So there isn't anything special about "disable PWM on duty=3D0% or
duty=3D100%". "disable PWM" in Thierry's eyes is always "stop at inactive
level" independant of the previously configured duty cycle.

You talking about the specific cases 0% and 100% makes me believe that
you are an example (BTW, I'm another) that makes Thierry's claim

	The current assumption by all users is more that [after
	pwm_disable()] the pin would stop at the no power state, which
	would be 0 for normal PWM and 1 for inverted.

wrong. (See mail with Message-ID: 20181012095349.GA9162@ulmo in this
thread.)
=20
To get forward here: Thierry, can you please confirm that there is no
semantical difference between "pwm_disable()" and "pwm_config(pwm, 0,
period)". (Or alternatively come up with a use case where a difference
really matters. I'm sure this is impossible though.)

Then I can start simplifying API users and adapt the pwm
hardware drivers. When this is done there will be no user left of
pwm_disable and struct pwm_state::enabled because nobody needs it with
the current semantic. After that we can either rip the concept of
pwm_disable or shift it's semantic to my initial suggestion of "no
guarantees about the output level" and use that in the few drivers that
really don't care about the output level[1] and so give the hardware the
possibility to disable the clock even if that results in something
different than "inactive".

As a first step I'd suggest to explicitly state the expectations on
hardware driver implementations and pwm-API users to get all affected
parties in line. These are in my eyes:

 - configuring the duty cycle should (if possible) not result in
   glitches, so the currently running period should be completed and
   after that a new period with the new configuration should start.
   (Is this reasonable to expect this from all implementations? If not
   we should maybe introduce a way to let the users know?)

 - The function to configure the duty cycle should only return when the
   period with the new configuration actually started.

If the concept of pwm_disable() stays, we should document the expected
behaviour of the pin. Something like:

 - After disabling the pwm you must not make any assumptions about the
   pin level. It might be low, or inactive, or even high-z. So don't
   disable the pwm if you for example care about a display backlight to
   stay off.

If desired we might even keep the behaviour for the sysfs implementation
that disable there for historic reasons keeps the semantic of
duty-cycle=3D0.

Further things that could be done (eventually after discussing they are
really sensible) are:

 - for pwms that can be programmed now for the next period implement the
   necessary sleep in the PWM-Framework (mxs, atmel, sun4i at least);
 - abstract inversed pwms in the framework instead of each hw driver;
 - let hw drivers correct *state on apply
   (if the user requests period=3D1ms and the driver can only provide
   multiples of 0.6667 ms because the input clock is fixed at 1500 Hz)

Best regards
Uwe

[1] the only example I know is the pwm-backlight driver that could
    disable the pwm without the inactive level guarantee when the
    enable-gpio is inactive.
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
