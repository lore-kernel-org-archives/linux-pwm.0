From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 12:49:02 +0200
Message-ID: <20190429104902.GA7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826548295145271282=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-pwm <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--===============1826548295145271282==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:45:47PM -0700, Doug Anderson wrote:
> Hi,
>=20
> On Sat, Mar 30, 2019 at 2:17 AM Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> wrote:
> >
> > Hi,
> >
> > [adding two chromeos people, because veyron and gru are quite
> > heavy users of the rockchip pwm for both backlight and regulators]
> >
> > Doug, Brian: patchwork patch is here:
> > https://patchwork.kernel.org/patch/10851001/
> >
> > Am Dienstag, 12. M=C3=A4rz 2019, 22:46:03 CET schrieb Uwe Kleine-K=C3=
=B6nig:
> > > The pwm-rockchip driver is one of only two PWM drivers which updates =
the
> > > state for the caller of pwm_apply_state(). This might have surprising
> > > results if the caller reuses the values expecting them to still
> > > represent the same state.
>=20
> It may or may not be surprising, but it is well documented.  Specifically:
>=20
>  * pwm_apply_state() - atomically apply a new state to a PWM device
>  * @pwm: PWM device
>  * @state: new state to apply. This can be adjusted by the PWM driver
>  *    if the requested config is not achievable, for example,
>  *    ->duty_cycle and ->period might be approximated.
>=20
> I don't think your series updates that documentation, right?

The documentation is arguably ambiguous here, but I don't think this was
meant as you intepret here. I think the original intent was to give the
drivers some leeway in how they apply a state. So a driver could for
example adjust duty_cycle or period if it doesn't support exactly the
combination requested. However, I don't think it was meant as a
suggestion that it would report that back to the caller.

This obviously implies that ->apply() is deterministic, so given a state
it would program the same register values, irrespective of when, or how
many times that state is applied.

> > > Also note that this feedback was incomplete as
> > > the matching struct pwm_device::state wasn't updated and so
> > > pwm_get_state still returned the originally requested state.
>=20
> The framework handles that.  Take a look at pwm_apply_state()?  It does:
>=20
> ---
>=20
> err =3D pwm->chip->ops->apply(pwm->chip, pwm, state);
> if (err)
>     return err;
>=20
> pwm->state =3D *state;
>=20
> ---
>=20
> So I think it wasn't incomplete unless I misunderstood?
>=20
>=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >
> > I've tested this on both veyron and gru with backlight and pwm regulator
> > and at least both still come up, so
> > Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> >
> > But hopefully Doug or Brian could also provide another test-point.
>=20
> I'd definitely be concerned by this change.  Specifically for the PWM
> regulator little details about exactly what duty cycle / period you
> got could be pretty important.
>=20
> I guess the problem here is that pwm_get_state() doesn't actually call
> into the PWM drivers, it just returns the last state that was applied.
> How does one get the state?  I guess you could change get_state() to
> actually call into the PWM driver's get_state if it exists?  ...but
> your patch set doesn't change that behavior...
>=20
> For instance, look at pwm_regulator_set_voltage().  The first line
> there is  pwm_init_state().  That calls into pwm_get_state() which
> just grabs the cached state.  If the last call to pwm_apply_state()
> didn't update that then it seems like it'd be bad.

The whole point of this atomic API is that the cached state would always
match the hardware state. Given what I said above that doesn't
necessarily mean that the cached state exactly matches the values that
were written to hardware.

But it does mean that the following is idempotent:

	pwm_get_state(pwm, &state);
	pwm_apply_state(pwm, &state);

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzG1pkACgkQ3SOs138+
s6HnJg//Z/zYy3o/pl5f9e9zd0C077CFTp3GxG4oEd2nGUq03avn1tVHcjI55vH5
9iiOpnBHY+1d5y02FyBbGLB+NozT9WZZuNOss588970p8MTGKbSDbsPy3rS7D37/
wrqiYCJ66/cwM0nuUZjPwJ8MPcvBf7ZMy9hLT8BbLkQUuLNiB/DYvloQ2szrfiNi
EKqrGqJGyP2MhUmghedV2FOYSU2nIhjttcT9boTG0N9iezerudTle7yj41qjSnth
+KC/d+Iv8hijy7imo9vXrcK3KYIFuJKSiRU4/G2ompKrfwf4JrMBQ5atvKaJMRbU
Rkif15K2UuyP8NmFj9/JXorwWY6z2KpmW97YUUpliEbnhPf1p8gQ3oKfXpLhTeDB
v+0DmLwFtayerbvLNunUURJJ0jz/pWydm4UvnOyW5xn469MbWP1kri2+RVh8HTCb
+SBnYkAyDLgTiuqNcUzTrprLxlny71VdWkrPMkZZ3spAc9MTJ/uLez3P1GVBaZm6
UzBQ9QHzgOD2kZvfxDMqF6bym2wczRIVgm1qv1CbyO2AF1XjdyxYRAixyuhn932K
nm8bUUHOlRXBKOpn3kE630pXjbaRhT9SvZj9eHTUxktMdhBwLljl4keLZGtM51eS
PzX81VFgjbk7R+aCuN5qYTbw11tHM1aoXTkvR2OhWwQiixPF6Ck=
=iul9
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


--===============1826548295145271282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============1826548295145271282==--
