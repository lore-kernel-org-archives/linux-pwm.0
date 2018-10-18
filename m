Return-path: <kernel-bounces@pengutronix.de>
Date: Thu, 18 Oct 2018 17:06:50 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181018150650.GB6226@ulmo>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
 <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
 <20180820144357.7206-2-u.kleine-koenig@pengutronix.de>
 <20181009073407.GA5565@ulmo>
 <20181009090401.3mlceegalzo53bd7@pengutronix.de>
 <20181016094417.64114816@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20181016094417.64114816@bbrezillon>
Subject: Re: [PATCH 1/2] pwm: document the pin state after pwm_disable() to
 be undefined
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 09:44:17AM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> On Tue, 9 Oct 2018 11:04:01 +0200
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > Hello Thierry,
> >=20
> > thanks for taking time to reply in this thread.
> >=20
> > On Tue, Oct 09, 2018 at 09:34:07AM +0200, Thierry Reding wrote:
> > > On Mon, Aug 20, 2018 at 04:43:56PM +0200, Uwe Kleine-K=C3=B6nig wrote=
: =20
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
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
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
> duty=3D100%" logic should, IMHO, be a HW-specific optimization. And if you
> look at existing drivers, it shouldn't be that hard to patch those that
> support this optimization since they most of the time have a separate
> disable function which could be called from the their config function
> if needed.

There's nothing in the API that prevents you from doing so and I never
said that this couldn't be done in pwm_config(). If you know it's safe
to disable the PWM if the duty cycle goes to zero, then by all means
do it.

That doesn't mean we necessarily have to go and change the API. There
may be drivers that prefer to do it in pwm_disable() and I don't see a
reason why we shouldn't be able to have both.

Quite frankly I think this whole discussion is moot. We already have a
different API (atomic) that was created specifically to solve these
kinds of issues. So if there's any driver issues with the legacy API,
then those drivers should be moved to the new API. All the public-facing
APIs already use those if available anyway. I don't see the point in
rev'ing an API that's deprecated anyway.

Also, the whole discussion here started because Uwe reported that the
i.MX driver wasn't expecting according to the assumptions from PWM
consumers (i.e. the PWM pin goes low for inverted PWM). So really no
amount of API changes is going to magically fix that problem.

> On the other hand, if we do it the other way around, and expect
> pwm_disable() to keep the pin in the state it was after setting a duty
> of 0, it becomes more complicated (impossible?) for PWM blocks that do
> not support specifying a default pin state when the PWM is disabled.

I think that'd be an unrealistic expectation. If you look at your
typical hardware design, engineers will have put it together in a way
that with the (hardware) defaults, your device will behave normally.
Those hardware defaults, or at least something as close to it as
possible, are what you should be programming your hardware blocks with
before you relinquish control in the driver. For pretty much all the
hardware devices that I'm familiar with, the "off" or "no power" state
is that hardware default.

In other words, when you boot a device the fans, backlights and LEDs
will be off by default. Therefore I think pwm_disable() should put the
PWM back into that state. That's evidently not what is happening for
i.MX currently, otherwise Uwe wouldn't be seeing that problem.

Furthermore, there is another patch currently under review that does
attempt to fix this in a proper way. So I just don't understand why we
keep going around in circles here.

Thierry

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvIoYgACgkQ3SOs138+
s6HBPRAAuCmuj+EGUoIOXsJ2SmZovnp2XRvMFNOeZz/d3cA5lO4C5sd+KOr9BaBs
E26i74WKISL4H8IAzLawP9jBk98BG+BFWjzDhx2J9QY1TMyMSvekDbqLxOaGpUUu
LHv1cft6SVS01nZzjNFZTiQpi7ZbDGVK4Iq+bTEqhA+mWlk9lq2NKiLMFjxHBa8h
dwkTadLkKWg9HFMg4dHsj/wKjVo5fqIXifrhBUezS1+1NWPAxLS9LgOjlPHcH9uJ
1T9pqt9BGUjB5mcpJWH1orL3UOKjQNKnFkvOqS0m73idKD8CTQDYc8CxAWD4drv4
Do92omMljwt1NfK0mRp3MKKSP3LecBW8IwvUUX85eHJwEsLNcNJGdal6EBYJfRqX
7tnYUL0f8uMLsue4yJa65aRz1s5RhHGPDsKZ0hQHEBVkamn/X3389oAtDBPcM6ya
IjH9XU1aNhbTXUtEN3DP06avBaeDx6gSbxb1u6vszs2ugOhzLCRWEiIFPbDO7yAv
4Zu14XSwnes6R+sQfYhj+pBRlLTbjIimpQpc15KTY3962b+EH6+n4Ga8TcLRPkZT
jEw+k5VDOmO4C17osTw4m2t/YZ2QNAqrQHRSvk98sdkWNcVIXWT+Qij+fDqupvD9
tm+vdq3iv0A9DMpPICxGAUwgMMYN3K/C89ZVqeiyHjb89ttQ23Q=
=c1nL
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
