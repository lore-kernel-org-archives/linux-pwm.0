From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Date: Wed, 26 Jun 2019 11:58:44 +0200
Message-ID: <20190626095844.GA6362@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <20190625093839.GB1516@ulmo>
 <20190626085827.fija4kfzb5uhwosi@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626085827.fija4kfzb5uhwosi@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Paul Cercueil <paul@crapouillou.net>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, od@zcrc.me, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 10:58:27AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jun 25, 2019 at 11:38:39AM +0200, Thierry Reding wrote:
> > On Mon, Jun 24, 2019 at 12:28:44PM +0100, Daniel Thompson wrote:
> > > [...] although given pwm-backlight is essentially a wrapper driver
> > > round a PWM I wondered why the pinctrl was on the backlight node
> > > (rather than the PWM node).
> >=20
> > I agree with this. We're defining the pin control state for the PWM pin,
> > so in my opinion it should be the PWM driver that controls it.
> >=20
> > One reason why I think this is important is if we ever end up with a
> > device that requires pins from two different controllers to be
> > configured at runtime, then how would we model that? Since pin control
> > states cannot be aggregated, so you'd have to have multiple "default"
> > states, each for the pins that they control.
>=20
> I thought you can do:
>=20
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pinctrl_in_first_pincontroller>, <&pinctrl_in_another_co=
ntroller>;
>=20
> if two (or more) controllers are involved.

You're right. Both the bindings say that this can be done and the code
is also there to parse multiple states per pinctrl-* entry.

> > On the other hand if we associate the pin control states with each of
> > the resources that need those states, then when those resources are
> > controlled, they will automatically know how to deal with the states.
> > The top-level device (i.e. backlight) doesn't need to concern itself
> > with those details.
>=20
> So the options are:
>=20
>  a) put "active" and "inactive" pinctrls into the pwm-node, and nothing
>     related to the involved PWM pins in the consumer
>=20
>  b) put the PWM pin config in the consumer's "default" pinctrl (and
>     maybe leave it out int "init" if you want smooth taking over).

You can't put it into the "default" state because that state is applied
before the consumer driver's ->probe().

>=20
> (Or maybe use "enabled" and "disabled" in a) to match the pwm_states
> .enabled?)

Yeah, I think this is what we'll need to do in order to implement the
explicit behaviour that we need here.

> The advantages I see in b) over a) are:
>=20
>  - "default" and "init" are a known pinctrl concept that most people
>    should have understood.

The problem is that they won't work in this case. The "init" state will
be applied before the consumer driver's ->probe() if it exists. If it
doesn't then "default" will be applied instead. Both cases are not
something that we want if we want to take over the existing
configuration.

>  - You have all pinctrl config for the backlight in a single place.

Depending on your point of view this could be considered a disadvantage.

>  - none of the involved driver must explicitly handle pinctrl stuff

Like I said, none of the automatic state handling is flexible enough for
this situation. Also, my understanding is that even if you use the
standard pinctrl state names ("default" and "idle") you still need to
explicitly select them at the right time. "default" will always be
applied before the consumer driver's ->probe(), but if you want to go to
the "idle" state you have to make that explicit. Now, there are helpers
to simplify this a bit, but you still need to implement suspend/resume
callbacks (or however you want to deal with it) that call these helpers.

In the case of PWM I think what we want is to select an "active" and
"idle" state on enable and disable, respectively. I suppose we could add
some infrastructure to help with this, such as perhaps scanning the
device tree for per-PWM pin control states at PWM chip registration time
and then adding helpers to select these states at the driver's
discretion. I don't think we can add generic code to do this because the
exact time when the pin control state needs to be applied may vary from
one PWM controller to another.

> You presume that b) being commonly done is a sign of "our device trees
> and kernel subsystems still maturing". But maybe it's only that the
> capabilities provided by pinctrl subsystem without extra effort is good
> enough?

Like I pointed out above, I don't think that's the case. But I don't
want to overcomplicate things, so if you can prove that it can be done
with the existing pinctrl helpers, I'd be happy to be proven wrong.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0TQdEACgkQ3SOs138+
s6Ex3RAAjClObHbY4caZt7PjHEVLwZp9p0uGXYE7ZemSo5DwnYe5KNVqX+Kez3jS
JDE/DK7UMkD1Xwf6HuYsZ1u/pwHE0Af7FE+TeM16T26zvPS2K1bSjytshBIXcLkp
kgfWKEQMgNF11bUZ03aFz833Po0sK+2LFzjhNCugRi1owXQ0910iefni03Jmna4g
4ZHqaQx7oetefd22xPHgpgHR43WN3qG/Ykz2gn2yxE/RLaojTiv+QC3B3/s6pCmL
SrlbkuqGJSUehGRJhVmxBC5CkQaJjV4L3JVysKl6Svf6e1RBZOeoiyS6eGv7xR7/
th556XLjVZggDCMurtRwEppxjZPVhi0ohl9sCD4kHpF35ZgQ5A/ZEvH/IjU5xFdW
Cros48qyEq4TlKqzUpYpJ2m7cpq0CCv+EGdGo51eHICBIvjvT1cy/DftCc13x2z4
16ButDJ+3xc75gVjHfVtIyH6g5jSrV0pYlOE1mC1FUj9uOPS+yqo0U5Q8l9ElzI/
VpHIhLU6jw2iOPVhrOFoJ2gIr86+cuwXqxAK3Rf7ccmI4P3DQeKK1S2ci+uY/SHe
IOlQT3ITZUjZKA57iQQIMc+Stb1SICEFcZFtybT6/jmmootTjgUnARLbmnPsE5QI
g4TArRprq3PzZQvmANv9QnWsLgTlum6hlul3j0gspYFDX4iyjes=
=b0SN
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
