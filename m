From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 13:03:54 +0200
Message-ID: <20190429110354.GB7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0013500382439460162=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190408143914.uucb5dwafq3cnsmk-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============0013500382439460162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 04:39:14PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 01, 2019 at 03:45:47PM -0700, Doug Anderson wrote:
> > Hi,
> >=20
> > On Sat, Mar 30, 2019 at 2:17 AM Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> > >
> > > Hi,
> > >
> > > [adding two chromeos people, because veyron and gru are quite
> > > heavy users of the rockchip pwm for both backlight and regulators]
> > >
> > > Doug, Brian: patchwork patch is here:
> > > https://patchwork.kernel.org/patch/10851001/
> > >
> > > Am Dienstag, 12. M=C3=A4rz 2019, 22:46:03 CET schrieb Uwe Kleine-K=C3=
=B6nig:
> > > > The pwm-rockchip driver is one of only two PWM drivers which update=
s the
> > > > state for the caller of pwm_apply_state(). This might have surprisi=
ng
> > > > results if the caller reuses the values expecting them to still
> > > > represent the same state.
> >=20
> > It may or may not be surprising, but it is well documented.  Specifical=
ly:
> >=20
> >  * pwm_apply_state() - atomically apply a new state to a PWM device
> >  * @pwm: PWM device
> >  * @state: new state to apply. This can be adjusted by the PWM driver
> >  *    if the requested config is not achievable, for example,
> >  *    ->duty_cycle and ->period might be approximated.
> >=20
> > I don't think your series updates that documentation, right?
> >=20
> >=20
> > > > Also note that this feedback was incomplete as
> > > > the matching struct pwm_device::state wasn't updated and so
> > > > pwm_get_state still returned the originally requested state.
> >=20
> > The framework handles that.  Take a look at pwm_apply_state()?  It does:
> >=20
> > ---
> >=20
> > err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> > if (err)
> >     return err;
> >=20
> > pwm->state =3D *state;
>=20
> >=20
> > ---
> >=20
> > So I think it wasn't incomplete unless I misunderstood?
>=20
> You're right, I missed that the updated state was saved.
>=20
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > >
> > > I've tested this on both veyron and gru with backlight and pwm regula=
tor
> > > and at least both still come up, so
> > > Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> > >
> > > But hopefully Doug or Brian could also provide another test-point.
> >=20
> > I'd definitely be concerned by this change.  Specifically for the PWM
> > regulator little details about exactly what duty cycle / period you
> > got could be pretty important.
> >=20
> > I guess the problem here is that pwm_get_state() doesn't actually call
> > into the PWM drivers, it just returns the last state that was applied.
> > How does one get the state?  I guess you could change get_state() to
> > actually call into the PWM driver's get_state if it exists?  ...but
> > your patch set doesn't change that behavior...
>=20
> My intention here is more to make all drivers behave the same way and
> because only two drivers updated the pwm_state this was the variant I
> removed.
>=20
> When you say that the caller might actually care about the exact
> parameters I fully agree. In this case however the consumer should be
> able to know the result before actually applying it. So if you do
>=20
> 	pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ...})
>=20
> and this results in .period =3D 100 and .duty_cycle =3D 0 then probably t=
he
> bad things you want to know about already happend. So my idea is a new
> function pwm_round_state() that does the adaptions to pwm_state without
> applying it to the hardware. After that pwm_apply_state could do the
> following:
>=20
> 	rstate =3D pwm_round_state(pwm, state)
> 	pwm.apply(pwm, state)
> 	gstate =3D pwm_get_state(pwm)
>=20
> 	if rstate !=3D gstate:
> 		warn about problems

I'm not sure this is really useful. I would expect that in most cases
where it is necessary to have an exact match between the requested state
and the actual state is important, you may not even get to warning about
problems because the system may shut down (e.g. the regulator might not
be outputting enough power to keep the system stable).

I think it'd be far more useful to give consumers a way to request that
the state be applied strictly. I'm not sure how realistic that is,
though. Most PWMs have some sort of restrictions, and in most cases this
might still be okay. Perhaps some sort of permissible relative deviation
factor could be added to give more flexibility?

Thierry

> But before doing that I think it would be sensible to also fix the rules
> how the round_state callback is supposed to round.
>=20
> Apart from that I agree that pwm_get_state should return the actually
> implemented configuration.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzG2hcACgkQ3SOs138+
s6G9yA//TJUld7Bl1E1jVgYYYck4BIbag3romh65N/ebXbdduGRvHe/mQZfUHUHn
rwjVci3hbFudig5uAwwuyPovz6CVa4Vb6DM5keC21sxz9FX49gOn9dH6n+7D0BM8
qj1fXhMn6XwXaib3M+L9tQ21jZ7Yl747BuHU2ATxALf4KVGBnxkgYqbpMcwGV7bg
tCZiH6w6RjzS/uUiATYYkr3JQNYst1RnKmIXjA2KtE7uXGbvGydAGIVl7WdNZi/r
HOPwGQQqnTEHr//IFximDrckJxXWWzP0rxJA3EQQAjSvSXLGCxKNVJ7MsXXV5dr+
12x5I/PctFvhdpbNRDI3v5s3pAqOkK1uGAB3LqczXZnY9W17KlIQuB2rjoyDAd3e
FXCSXxbrHFsBoUkrFz7GHnQ0IB2qP45Co/JUQBsTJq+MYJd8xSCFtFQn0SCkD5e6
baYk3Yh6CIHczNdqGtsC51kWXCH7XPhULISuDAMeHN0+YO9AWad7aD4wvJ4RP/BQ
FYSt81idlPqGILeA+6lakD5IPiAm7X7Snh9y3bRT+RsUzKS5W+t6C17P7C4EiKeJ
q1eVRcBrVe1VdwUsBLIAyD2m4ptqf+chZI4XGZBjdmWckGOIzqWpxskW4cx0AUWu
6qXRbc7lP45xqIN3KjMppqKXrXki2raBi7dXVJldnPQxv24fenU=
=08ZM
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--


--===============0013500382439460162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============0013500382439460162==--
