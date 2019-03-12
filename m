Return-path: <kernel-bounces@pengutronix.de>
Date: Tue, 12 Mar 2019 14:48:07 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: poke users of legacy drivers with a warning
Message-ID: <20190312134807.lzcxx6xujcshd3fh@pengutronix.de>
References: <20190312094249.27806-1-u.kleine-koenig@pengutronix.de>
 <20190312113944.GI31026@ulmo>
 <20190312120355.dfpcmuetcr56klbp@pengutronix.de>
 <20190312122835.GN31026@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190312122835.GN31026@ulmo>
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Tue, Mar 12, 2019 at 01:28:35PM +0100, Thierry Reding wrote:
> On Tue, Mar 12, 2019 at 01:03:55PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Mar 12, 2019 at 12:39:44PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 12, 2019 at 10:42:49AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > As it is hard to convert a given driver from the legacy functions
> > > > (.enable, .disable, .config) to the atomic stuff (.apply) without
> > > > testing make users aware that there is something to do with a warni=
ng to
> > > > eventually get rid of the legacy drivers.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/pwm/core.c | 14 +++++++++-----
> > > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >=20
> > > I don't think that's a good idea. What are regular users supposed to =
do
> > > when they see this warning?
> >=20
> > Ask on this list for directions or volunteer as tester.
>=20
> I don't think that's fair to expect from users. There's nothing risky
> about using a legacy API driver, so users shouldn't need to do anything.
> This is a maintenance issue that users don't have to be concerned about.

I don't quite agree here. In my eyes people running Linux should be
bothered with problems like testing API changes. Some people might not
want to invest the needed time and skill, a big part of the group of
these people probably won't even notice the warning.

But others who want their system to still work after a few kernel
releases might not even be aware there is something to fix. There is no
other way to activate them but by telling that there is something bad
happening.

> > Then in a few years we can as a next step make these drivers fail to
> > probe if they are still unfixed.
>=20
> Erm... no. Why would you want to purposely break a driver that's working
> perfectly fine?

That they are working perfectly fine is a theory. In my book it is ok to
cut hoary relics where there was a warning in place for a few releases,
the maintainer doesn't know if they are still in use and that prevent
cleanups to reduce maintenance effort. If somebody cares and cries that
support can be easily restored from git (and tested by the caring
person :-)

> > If you don't agree I wonder how you want to complete the task to convert
> > all drivers to the atomic API.
>=20
> There's technically nothing wrong with using the legacy API. It's worked
> well for a number of years and a large number of drivers. We have
> helpers that allow atomic API users to work with legacy API drivers.
> From my point of view there's no need to convert drivers that work fine
> with the legacy API.
>=20
> That said, it would be nice if it did happen eventually, if for no other
> reason than to get rid of the compatibility shims, which aren't really
> that bad in the first place. But I think the conversion could be done in
> a relatively automated way. pwm_apply_state() codifies what the sequence
> of calls is for the atomic API, so that's the sequence that ->apply()
> would need to implement as well, given the existing legacy callbacks.

Consider a PWM running at 30% duty cycle and then I call

	pwm_apply_state(pwm, { .enabled =3D false, .duty_cycle =3D 600, .period =
=3D 1000, ...})

This results in:

	ops->config(..., state->duty_cycle, state->period);
	ops->disable(...);

which results in at least one period with 60% duty cycle. So in my eyes
it is important also from a correctness point of view to get rid of the
legacy stuff. OK, you can do the disable first to fix this specific bug,
but then there is still the problem that pwm_apply_state disables the
PWM when polarity changes which might result in undesired effects. The
underlying problem is that pwm_apply_state promises an atomic change to
the consumer which cannot be done in all cases given that there are
several hw-driver functions involved that are not atomic when called in
sequence. That was after all the motivation to introduce the atomic API
because the legacy stuff cannot map all use cases.

> Another way of saying this is to push pwm_apply_state() down into driver
> implementations. That's probably not the ideal way of implementing the
> changes in a driver, but it's certainly one that should work.

Having someone being able to test this would still be great.

Another upside of the warning would be that authors of new drivers would
instantly notice that they have to implement .apply instead of .config,
.enable and .disable. (See the IMX TPM PWM driver patch just yesterday
on the list.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
