From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 14:31:02 +0200
Message-ID: <20190429123102.7wfcdqusn24g5rm7@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <20190429110354.GB7747@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190429110354.GB7747@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 29, 2019 at 01:03:54PM +0200, Thierry Reding wrote:
> On Mon, Apr 08, 2019 at 04:39:14PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 01, 2019 at 03:45:47PM -0700, Doug Anderson wrote:
> > > Hi,
> > > =

> > > On Sat, Mar 30, 2019 at 2:17 AM Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrot=
e:
> > > >
> > > > Hi,
> > > >
> > > > [adding two chromeos people, because veyron and gru are quite
> > > > heavy users of the rockchip pwm for both backlight and regulators]
> > > >
> > > > Doug, Brian: patchwork patch is here:
> > > > https://patchwork.kernel.org/patch/10851001/
> > > >
> > > > Am Dienstag, 12. M=E4rz 2019, 22:46:03 CET schrieb Uwe Kleine-K=F6n=
ig:
> > > > > The pwm-rockchip driver is one of only two PWM drivers which upda=
tes the
> > > > > state for the caller of pwm_apply_state(). This might have surpri=
sing
> > > > > results if the caller reuses the values expecting them to still
> > > > > represent the same state.
> > > =

> > > It may or may not be surprising, but it is well documented.  Specific=
ally:
> > > =

> > >  * pwm_apply_state() - atomically apply a new state to a PWM device
> > >  * @pwm: PWM device
> > >  * @state: new state to apply. This can be adjusted by the PWM driver
> > >  *    if the requested config is not achievable, for example,
> > >  *    ->duty_cycle and ->period might be approximated.
> > > =

> > > I don't think your series updates that documentation, right?
> > > =

> > > =

> > > > > Also note that this feedback was incomplete as
> > > > > the matching struct pwm_device::state wasn't updated and so
> > > > > pwm_get_state still returned the originally requested state.
> > > =

> > > The framework handles that.  Take a look at pwm_apply_state()?  It do=
es:
> > > =

> > > ---
> > > =

> > > err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> > > if (err)
> > >     return err;
> > > =

> > > pwm->state =3D *state;
> > =

> > > =

> > > ---
> > > =

> > > So I think it wasn't incomplete unless I misunderstood?
> > =

> > You're right, I missed that the updated state was saved.
> > =

> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > >
> > > > I've tested this on both veyron and gru with backlight and pwm regu=
lator
> > > > and at least both still come up, so
> > > > Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > > >
> > > > But hopefully Doug or Brian could also provide another test-point.
> > > =

> > > I'd definitely be concerned by this change.  Specifically for the PWM
> > > regulator little details about exactly what duty cycle / period you
> > > got could be pretty important.
> > > =

> > > I guess the problem here is that pwm_get_state() doesn't actually call
> > > into the PWM drivers, it just returns the last state that was applied.
> > > How does one get the state?  I guess you could change get_state() to
> > > actually call into the PWM driver's get_state if it exists?  ...but
> > > your patch set doesn't change that behavior...
> > =

> > My intention here is more to make all drivers behave the same way and
> > because only two drivers updated the pwm_state this was the variant I
> > removed.
> > =

> > When you say that the caller might actually care about the exact
> > parameters I fully agree. In this case however the consumer should be
> > able to know the result before actually applying it. So if you do
> > =

> > 	pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ...})
> > =

> > and this results in .period =3D 100 and .duty_cycle =3D 0 then probably=
 the
> > bad things you want to know about already happend. So my idea is a new
> > function pwm_round_state() that does the adaptions to pwm_state without
> > applying it to the hardware. After that pwm_apply_state could do the
> > following:
> > =

> > 	rstate =3D pwm_round_state(pwm, state)
> > 	pwm.apply(pwm, state)
> > 	gstate =3D pwm_get_state(pwm)
> > =

> > 	if rstate !=3D gstate:
> > 		warn about problems
> =

> I'm not sure this is really useful. I would expect that in most cases
> where it is necessary to have an exact match between the requested state
> and the actual state is important, you may not even get to warning about
> problems because the system may shut down (e.g. the regulator might not
> be outputting enough power to keep the system stable).
> =

> I think it'd be far more useful to give consumers a way to request that
> the state be applied strictly. I'm not sure how realistic that is,
> though. Most PWMs have some sort of restrictions, and in most cases this
> might still be okay. Perhaps some sort of permissible relative deviation
> factor could be added to give more flexibility?

I think in practise this isn't going to work. Consider the case that
Brian cares about: "we do need to be as precise as possible with the
duty:period ratio". So if we want 1/5 duty we might request:

	.duty_cycle =3D 100, .period =3D 500

an are using pwm_set_state_exact(). Now consider this fails. What is the
next value you should try? It's hard to say without knowing why it
failed. If however you could do

	mystate.duty_cycle =3D 100
	mystate.period =3D 500
	pwm_round_state(pwm, &mystate);

and after that we have:

	mystate.duty_cycle =3D 99;
	mystate.period =3D 498;

(because pwm_round_state is supposed to round down[1] and the hardware can
implement multiples of 3 only). Then it is easier to determine the next
state to try.

Best regards
Uwe

[1] this isn't fixed yet, but I think it's sensible.

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
