From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 13:18:55 +0200
Message-ID: <20190429111855.GC7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045416247342741734=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190429065613.n52uwgys5eugmssd-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============0045416247342741734==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 08:56:13AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:
> > Hi,
> >=20
> > I'm not sure if I'm misreading you, but I thought I'd add here before
> > this expires out of my inbox:
> >=20
> > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > My intention here is more to make all drivers behave the same way and
> > > because only two drivers updated the pwm_state this was the variant I
> > > removed.
> >=20
> > To be clear, this patch on its own is probably breaking things. Just
> > because the other drivers don't implement the documented behavior
> > doesn't mean you should break this driver. Maybe the others just
> > aren't used in precise enough scenarios where this matters.
> >=20
> > > When you say that the caller might actually care about the exact
> > > parameters I fully agree. In this case however the consumer should be
> > > able to know the result before actually applying it. So if you do
> > >
> > >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12, ..=
=2E})
> > >
> > > and this results in .period =3D 100 and .duty_cycle =3D 0 then probab=
ly the
> > > bad things you want to know about already happend. So my idea is a new
> > > function pwm_round_state() that does the adaptions to pwm_state witho=
ut
> > > applying it to the hardware. After that pwm_apply_state could do the
> > > following:
> > >
> > >         rstate =3D pwm_round_state(pwm, state)
> > >         pwm.apply(pwm, state)
> > >         gstate =3D pwm_get_state(pwm)
> > >
> > >         if rstate !=3D gstate:
> > >                 warn about problems
> >=20
> > For our case (we're using this with pwm-regulator), I don't recall [*]
> > we need to be 100% precise about the period, but we do need to be as
> > precise as possible with the duty:period ratio -- so once we get the
> > "feedback" from the underlying PWM driver what the real period will
> > be, we adjust the duty appropriately.
>=20
> I admit that I didn't understood the whole situation and (some) things
> are worse with my patches applied. I still think that changing the
> caller's state variable is bad design, but of course pwm_get_state
> should return the currently implemented configuration.
>=20
> > So I don't see that "warning" would really help for this particular cas=
e.
> >=20
> > > But before doing that I think it would be sensible to also fix the ru=
les
> > > how the round_state callback is supposed to round.
> >=20
> > I'm not quite sure I grok exactly what you're planning, but I would
> > much appreciate if you didn't break things on the way toward fixing
> > them ;)
>=20
> There are currently no rules how the driver should behave for example if
> the consumer requests
>=20
> 	.duty_cycle =3D 10, .period =3D 50
>=20
> and the hardware can only implement multiples of 3 for both values. The
> obvious candidates are:
>=20
>  - .duty_cycle =3D 9, .period =3D 51 (round nearest for both)
>  - .duty_cycle =3D 12, .period =3D 51 (round up)
>  - .duty_cycle =3D 9, .period =3D 48 (round down)
>  - .duty_cycle =3D 9, .period =3D 45 (round duty_cycle and keep proportio=
n)
>  - return error (which code?)
>=20
> And there are some other variants (e.g. round duty_cycle to nearest and
> period in the same direction) that might be sensible.

The problem is that probably all of the above are valid, though maybe
not for all cases. The choice of algorithm probably depends on both the
PWM driver and the consumer, so I don't think fixing things to one such
algorithm is going to improve anything.

> Also it should be possible to know the result before actually
> configuring the hardware. Otherwise things might already go wrong
> because the driver implements a setting that is too far from the
> requested configuration.

I agree.

Perhaps somebody with more experience with pwm-regulator can chime in
here, but it sounds to me like if you really want to accurately output a
voltage, you may want to hand-tune the duty-cycle/period pairs that are
used for pwm-regulator. According to the device tree bindings there's
already support for a voltage table mode where an exact duty-cycle to
output voltage correspondence is defined. This is as opposed to the
continuous voltage mode where the duty cycle is linearly interpolated
based on the requested output voltage.

pwm-regulator in voltage table mode could run in "strict" mode with zero
deviation allowed, on the assumption that duty-cycle values were hand-
picked to give the desired results. For continuous voltage mode it
probably doesn't matter all that much, since very exact results can't be
guaranteed anyway.

Thierry

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzG3ZwACgkQ3SOs138+
s6Hjlg/+KleJYXhK9kjCa33D5P5SF18UKOyghAs6mxeOgEsKUX6VEpVM6bsWej0y
TgG4yaM57AROrmuTdWWTs8IrpQwsvpkR/clzeo9UJ6FYSmjv4046lwzFZGSX+usz
dJMtf0WvRq61o2EVdKiAc8JyKrAC83+9d3194A73C/iDlQ2eWsR3UyvNtdZOlavK
mYFkLrx4DIE80LCVavcl2FRDhOhg1Rb/4dztJ6p8aAsljVQ2N9ARApKz4eDm6vaK
x6dMYvz+YeU2PAr9gtRLTTmFD+7/OClnegvuQKmiskrZKSgNpzmrSQyndrIKARp1
mndt3fyHguunNQtKV9nMVJSLDRV4a6aVM9Zamb6M/JxogWqOgN6Dd2EYX5gmrms0
aurN5uoci43uIp1MnwM5pLupIkJpUHYKwaVbC1jUFpIqiRsJDSydjCeEKabLFcDb
g2ba3V7OASGR7fu+aMaXbvvsTUMVxzHgiIx3JSiVKIVask0ohgRQDx2tqvGZcgj+
S2vX+pnCA4F4CWZ091BHmF00GX0QvpmiP8crYgD+xW+kX4xsJXabrvVjm7rQ5tvS
LPxDYP1LUIzsPax3xDwI9oJb3otVHJDQniWBRC5R0YkgTL1MB6wyJqMfU2+DwqNL
IUTXCPbF8/gGXiYR1g5tpS7N0ElG5Rh9+jKbOsg5WJuEMnz3TmE=
=WCCG
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--


--===============0045416247342741734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============0045416247342741734==--
