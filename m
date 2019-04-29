From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 18:17:49 +0200
Message-ID: <20190429161749.GD7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <20190429110354.GB7747@ulmo>
 <20190429123102.7wfcdqusn24g5rm7@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6730447483608004427=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190429123102.7wfcdqusn24g5rm7-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============6730447483608004427==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 02:31:02PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 29, 2019 at 01:03:54PM +0200, Thierry Reding wrote:
> > On Mon, Apr 08, 2019 at 04:39:14PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Apr 01, 2019 at 03:45:47PM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >=20
> > > > On Sat, Mar 30, 2019 at 2:17 AM Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wr=
ote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > [adding two chromeos people, because veyron and gru are quite
> > > > > heavy users of the rockchip pwm for both backlight and regulators]
> > > > >
> > > > > Doug, Brian: patchwork patch is here:
> > > > > https://patchwork.kernel.org/patch/10851001/
> > > > >
> > > > > Am Dienstag, 12. M=C3=A4rz 2019, 22:46:03 CET schrieb Uwe Kleine-=
K=C3=B6nig:
> > > > > > The pwm-rockchip driver is one of only two PWM drivers which up=
dates the
> > > > > > state for the caller of pwm_apply_state(). This might have surp=
rising
> > > > > > results if the caller reuses the values expecting them to still
> > > > > > represent the same state.
> > > >=20
> > > > It may or may not be surprising, but it is well documented.  Specif=
ically:
> > > >=20
> > > >  * pwm_apply_state() - atomically apply a new state to a PWM device
> > > >  * @pwm: PWM device
> > > >  * @state: new state to apply. This can be adjusted by the PWM driv=
er
> > > >  *    if the requested config is not achievable, for example,
> > > >  *    ->duty_cycle and ->period might be approximated.
> > > >=20
> > > > I don't think your series updates that documentation, right?
> > > >=20
> > > >=20
> > > > > > Also note that this feedback was incomplete as
> > > > > > the matching struct pwm_device::state wasn't updated and so
> > > > > > pwm_get_state still returned the originally requested state.
> > > >=20
> > > > The framework handles that.  Take a look at pwm_apply_state()?  It =
does:
> > > >=20
> > > > ---
> > > >=20
> > > > err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> > > > if (err)
> > > >     return err;
> > > >=20
> > > > pwm->state =3D *state;
> > >=20
> > > >=20
> > > > ---
> > > >=20
> > > > So I think it wasn't incomplete unless I misunderstood?
> > >=20
> > > You're right, I missed that the updated state was saved.
> > >=20
> > > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>
> > > > >
> > > > > I've tested this on both veyron and gru with backlight and pwm re=
gulator
> > > > > and at least both still come up, so
> > > > > Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > > > >
> > > > > But hopefully Doug or Brian could also provide another test-point.
> > > >=20
> > > > I'd definitely be concerned by this change.  Specifically for the P=
WM
> > > > regulator little details about exactly what duty cycle / period you
> > > > got could be pretty important.
> > > >=20
> > > > I guess the problem here is that pwm_get_state() doesn't actually c=
all
> > > > into the PWM drivers, it just returns the last state that was appli=
ed.
> > > > How does one get the state?  I guess you could change get_state() to
> > > > actually call into the PWM driver's get_state if it exists?  ...but
> > > > your patch set doesn't change that behavior...
> > >=20
> > > My intention here is more to make all drivers behave the same way and
> > > because only two drivers updated the pwm_state this was the variant I
> > > removed.
> > >=20
> > > When you say that the caller might actually care about the exact
> > > parameters I fully agree. In this case however the consumer should be
> > > able to know the result before actually applying it. So if you do
> > >=20
> > > 	pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ...})
> > >=20
> > > and this results in .period =3D 100 and .duty_cycle =3D 0 then probab=
ly the
> > > bad things you want to know about already happend. So my idea is a new
> > > function pwm_round_state() that does the adaptions to pwm_state witho=
ut
> > > applying it to the hardware. After that pwm_apply_state could do the
> > > following:
> > >=20
> > > 	rstate =3D pwm_round_state(pwm, state)
> > > 	pwm.apply(pwm, state)
> > > 	gstate =3D pwm_get_state(pwm)
> > >=20
> > > 	if rstate !=3D gstate:
> > > 		warn about problems
> >=20
> > I'm not sure this is really useful. I would expect that in most cases
> > where it is necessary to have an exact match between the requested state
> > and the actual state is important, you may not even get to warning about
> > problems because the system may shut down (e.g. the regulator might not
> > be outputting enough power to keep the system stable).
> >=20
> > I think it'd be far more useful to give consumers a way to request that
> > the state be applied strictly. I'm not sure how realistic that is,
> > though. Most PWMs have some sort of restrictions, and in most cases this
> > might still be okay. Perhaps some sort of permissible relative deviation
> > factor could be added to give more flexibility?
>=20
> I think in practise this isn't going to work. Consider the case that
> Brian cares about: "we do need to be as precise as possible with the
> duty:period ratio". So if we want 1/5 duty we might request:
>=20
> 	.duty_cycle =3D 100, .period =3D 500
>=20
> an are using pwm_set_state_exact(). Now consider this fails. What is the
> next value you should try?

The idea is that if the driver fails to set the exact state if that's
what was requested, then we just fail. If we really need an exact set
of values, then it doesn't make sense to offer the user alternatives
using rounding helpers.

On the other hand, if we introduce an error margin, we could make the
above work. Let's say the PWM regulator requires accuracy within 1%, we
could do something like this:

	state.duty_cycle =3D 100;
	state.period =3D 500;
	state.accuracy =3D 1; /* there's a slew of ways to encode this */
	pwm_apply_state(pwm, &state);

That way, the PWM driver can determine whether or not the ratio of
possible duty-cycle/period is accurate within that 1% requested by the
user:

	ratio =3D duty-cycle / period

	requested =3D 100 / 500
	possible =3D 99 / 498

	possible / requested ~=3D 0.993

In other words, possible is > 99% of requested and therefore within the
1% accuracy that pwm-regulator requested. The PWM driver can therefore
go ahead and program the selected set of values.

> It's hard to say without knowing why it failed. If however you could do
>=20
> 	mystate.duty_cycle =3D 100
> 	mystate.period =3D 500
> 	pwm_round_state(pwm, &mystate);
>=20
> and after that we have:
>=20
> 	mystate.duty_cycle =3D 99;
> 	mystate.period =3D 498;
>=20
> (because pwm_round_state is supposed to round down[1] and the hardware can
> implement multiples of 3 only). Then it is easier to determine the next
> state to try.

No, it's really not any easier to determine the next state to try. The
problem is that the consumer doesn't know anything about the
restrictions of the driver, and it shouldn't need to know. Given the
above, how is it supposed to know that the restriction is "multiple of
3". Just because the two values happen to be multiples of 3 doesn't mean
that's the restriction. Also, we really don't want every consumer in the
kernel to implement factorization (and whatnot) to guess what possible
constraints there could be.

Thierry

>=20
> Best regards
> Uwe
>=20
> [1] this isn't fixed yet, but I think it's sensible.
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzHI6oACgkQ3SOs138+
s6E37w//YefJYX6Z6JBbB/mqbLTpMmNQmImJslNWbDDViVQ9BfMpnH+GB2WBqq+j
2P/JzZsnv0lwlL+CH7SdHT25DDbLtHP02NVOGOJB1ojGMiACagic92568JqGFVqE
CaCthmXBetjzXGlW8Ptv6eKLDfadgcIMBoLjIfsP9gvW/ikCl9o6u1m3gN5wIgcT
HHzj5tjTB0+U8vqOk1ZV4++e3H8oy8MzAlrtHc+AR/6iassKsiXL2MGj4+MDJZjK
T27JRyn8ZYmEI8KyoE+dU923k9j1jKgKK5BQzWOUlOfpHftxAqD979aMoHf4uLwG
QFRFWJD3L/Vvf3ELHTc2fIg+HXXXLo08mXyAfP/wnekAGRrwigI6Fy4v8j5y5vMo
8FppC0n/e46E18pOAYDPaKjnbXs2GvOC0NWpYwqHnhknNX+k1oZym/k02J9kxYqa
yFXaGEr9SGU4KCnwL6xWiX0I5Q1EpOImca80tU2ktH/LR0oxHIevUAznOuV/Ki4S
MoZ1wHJA8PYFYNSpxkwDmgO2sglyNb281AqrLxEy6QOPS9lwygEweh3bL7YHkn8M
pIC+GH3sVshap8YJFi5TeEoYww5GBCmZST/QVWsezBj2b/To7UqdOEHWLEyABXjL
fkeQFHL2XXua7OjkeUib7wYwBQrg/1u/+vGhSy6cguXCt6qGiwE=
=jTBu
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--


--===============6730447483608004427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============6730447483608004427==--
