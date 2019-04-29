From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Date: Mon, 29 Apr 2019 18:28:47 +0200
Message-ID: <20190429162847.GE7747@ulmo>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <20190429111855.GC7747@ulmo>
 <20190429131127.x535uhhtputb7zwl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0582994242795099779=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190429131127.x535uhhtputb7zwl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============0582994242795099779==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 03:11:27PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 29, 2019 at 01:18:55PM +0200, Thierry Reding wrote:
> > On Mon, Apr 29, 2019 at 08:56:13AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:
> > > > Hi,
> > > >=20
> > > > I'm not sure if I'm misreading you, but I thought I'd add here befo=
re
> > > > this expires out of my inbox:
> > > >=20
> > > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > > My intention here is more to make all drivers behave the same way=
 and
> > > > > because only two drivers updated the pwm_state this was the varia=
nt I
> > > > > removed.
> > > >=20
> > > > To be clear, this patch on its own is probably breaking things. Just
> > > > because the other drivers don't implement the documented behavior
> > > > doesn't mean you should break this driver. Maybe the others just
> > > > aren't used in precise enough scenarios where this matters.
> > > >=20
> > > > > When you say that the caller might actually care about the exact
> > > > > parameters I fully agree. In this case however the consumer shoul=
d be
> > > > > able to know the result before actually applying it. So if you do
> > > > >
> > > > >         pwm_apply_state(pwm, { .period =3D 17, .duty_cycle =3D 12=
, ...})
> > > > >
> > > > > and this results in .period =3D 100 and .duty_cycle =3D 0 then pr=
obably the
> > > > > bad things you want to know about already happend. So my idea is =
a new
> > > > > function pwm_round_state() that does the adaptions to pwm_state w=
ithout
> > > > > applying it to the hardware. After that pwm_apply_state could do =
the
> > > > > following:
> > > > >
> > > > >         rstate =3D pwm_round_state(pwm, state)
> > > > >         pwm.apply(pwm, state)
> > > > >         gstate =3D pwm_get_state(pwm)
> > > > >
> > > > >         if rstate !=3D gstate:
> > > > >                 warn about problems
> > > >=20
> > > > For our case (we're using this with pwm-regulator), I don't recall =
[*]
> > > > we need to be 100% precise about the period, but we do need to be as
> > > > precise as possible with the duty:period ratio -- so once we get the
> > > > "feedback" from the underlying PWM driver what the real period will
> > > > be, we adjust the duty appropriately.
> > >=20
> > > I admit that I didn't understood the whole situation and (some) things
> > > are worse with my patches applied. I still think that changing the
> > > caller's state variable is bad design, but of course pwm_get_state
> > > should return the currently implemented configuration.
> > >=20
> > > > So I don't see that "warning" would really help for this particular=
 case.
> > > >=20
> > > > > But before doing that I think it would be sensible to also fix th=
e rules
> > > > > how the round_state callback is supposed to round.
> > > >=20
> > > > I'm not quite sure I grok exactly what you're planning, but I would
> > > > much appreciate if you didn't break things on the way toward fixing
> > > > them ;)
> > >=20
> > > There are currently no rules how the driver should behave for example=
 if
> > > the consumer requests
> > >=20
> > > 	.duty_cycle =3D 10, .period =3D 50
> > >=20
> > > and the hardware can only implement multiples of 3 for both values. T=
he
> > > obvious candidates are:
> > >=20
> > >  - .duty_cycle =3D 9, .period =3D 51 (round nearest for both)
> > >  - .duty_cycle =3D 12, .period =3D 51 (round up)
> > >  - .duty_cycle =3D 9, .period =3D 48 (round down)
> > >  - .duty_cycle =3D 9, .period =3D 45 (round duty_cycle and keep propo=
rtion)
> > >  - return error (which code?)
> > >=20
> > > And there are some other variants (e.g. round duty_cycle to nearest a=
nd
> > > period in the same direction) that might be sensible.
> >=20
> > The problem is that probably all of the above are valid, though maybe
> > not for all cases. The choice of algorithm probably depends on both the
> > PWM driver and the consumer, so I don't think fixing things to one such
> > algorithm is going to improve anything.
>=20
> But if you have pwm_round_state (which implements rounding down for
> example) you could easily implement a helper that rounds nearest or up.
> If however each driver rounds the way it prefers coming up with a helper
> for rounding up is considerably harder.

pwm_round_state() is fundamentally racy. What if, for example, you have
two consumers racing to set two PWMs provided by the same controller. If
you have some dependency between the two PWMs (perhaps they need to
share the same divider or something like that), then between the time
where pwm_round_state() returns and pwm_apply_state() is called, the
results of the pwm_round_state() may no longer be valid.

> > > Also it should be possible to know the result before actually
> > > configuring the hardware. Otherwise things might already go wrong
> > > because the driver implements a setting that is too far from the
> > > requested configuration.
> >=20
> > I agree.
> >=20
> > Perhaps somebody with more experience with pwm-regulator can chime in
> > here, but it sounds to me like if you really want to accurately output a
> > voltage, you may want to hand-tune the duty-cycle/period pairs that are
> > used for pwm-regulator.
>=20
> This might be more ugly than needed because then you have to setup the
> table in dependance of the used PWM.

Well, that's what you have to do anyway. I mean, you can't write one
voltage table that works for one device and then expect it to work for
every other device. DT by definition is a board-level definition.

> Looking at the pwm-regulator code I
> think the binding is badly worded. The "Duty-Cycle" parameter is used as
> second parameter to pwm_set_relative_duty_cycle (with scale =3D 100). So
> with the regulator defined in the Voltage Table Example of
> Documentation/devicetree/bindings/regulator/pwm-regulator.txt you'd have
> to configure
>=20
> 	.duty_cycle =3D 2534, .period =3D 8448
> =09
> to get 1.056 V.

Hm... indeed. Requiring the duty-cycle to be in percent is not a good
idea. That's going to lead to rounding one way or another.

>=20
> Note that my considerations are not only about pwm-regulators.
>=20
> Also in general I prefer a suitable and well reviewed algorithm (if
> possible) over a requirement to provide a hand-tuned table of values in
> a machine-specific device tree.

I agree that an algorithm is usually better, but if you can't create an
algorithm that works, it's usually better to have a hand-coded fallback
rather than have no working system at all.

> > According to the device tree bindings there's
> > already support for a voltage table mode where an exact duty-cycle to
> > output voltage correspondence is defined. This is as opposed to the
> > continuous voltage mode where the duty cycle is linearly interpolated
> > based on the requested output voltage.
> >=20
> > pwm-regulator in voltage table mode could run in "strict" mode with zero
> > deviation allowed, on the assumption that duty-cycle values were hand-
> > picked to give the desired results. For continuous voltage mode it
> > probably doesn't matter all that much, since very exact results can't be
> > guaranteed anyway.
>=20
> I don't understand the last sentence? Why is it impossible to get exact
> results in continuous voltage mode?

I didn't say it was impossible. I said it can't be guaranteed. There may
very well be combinations of drivers and consumers where the results
will be accurate, but there may very well be other combinations where
the results won't be. So if you don't know the exact combination, you
can't be sure that the result will be accurate.

Now it seems like both voltage table and continuous modes seem to rely
on some relative duty cycle setting, in which case there's typically
going to be rounding in both cases (unless you make the duty cycle range
large enough to accomodate the whole range from 0 to period.

Thierry

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzHJjwACgkQ3SOs138+
s6F+vg//XwtHr6bwoEWwb8ABsYBxluAwGg26p3zajc0Fk6tr0PdRKO5DcipO+aq8
1Gh3KwMew85ceeGe93QsRCc64tyG/Geo4UoOtY5ge/wtS9IBtQ3d/9c/zNpN5l8I
IaSakOqCMySBGZ4DjSe2xmtsTKSVJmc0dPd1ua+tnyblHh3uEXsl8wOrkySnJGUc
U23bQMj+ua3QfB+4DGNCGJ+CZoYUvmOMhKy/uQDoXU5z8WDOOn4FAAS96oH3vk56
Hhh9Gon5Zmje4qyccbghBjD5rDH5bk6Re9H/F9HQj15aMbQ79990eJt9nHAkVUG8
qZ0gagUf6pEEuc7SCVVFm0BVqTUu99GCO1gV2eBYlSw85XgzZqnSmWOL9O5gViE9
7cK5PSwbByBVxslkeK4TJdpUPTQLRzoWxZLQlJwwEFlBV0sfR8ja2ZKdkR2xCZsJ
ioy43b09B8Tc6mquFmTfrwbmmxt+G7OSsNKVW+jTkfa5wZiwspJfihFrqewJbIIN
OiUPGmX9SCkwQvvXHWoue1iDXJlw8SbFaxW/2PSAhMeqNDes4chqRtmFJvOHvXpH
JYn1mupAhrH9SQuY15qSc0tisgSyJgHyTojwmF/eAPHh7PN25ntoL1Q1Q8qic9XG
hlw6x7yyM2j/Hjwyndl/dgagg4ZXgIXX9+5KH/p+CMOuShb61sU=
=8pBY
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--


--===============0582994242795099779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============0582994242795099779==--
