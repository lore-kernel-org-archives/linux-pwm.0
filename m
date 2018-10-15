Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 15 Oct 2018 11:28:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181015092825.GC12357@ulmo>
References: <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
 <20181012101143.GC9162@ulmo>
 <20181014113400.nm6ajbjnju2h6dz3@pengutronix.de>
 <20181015081421.7kx3syv4rnp5vqma@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20181015081421.7kx3syv4rnp5vqma@pengutronix.de>
Subject: Re: RFC: don't let drivers issue pwm_disable after pwm_config(pwm,
 0, period)
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, kernel@pengutronix.de, "Philip, Avinash" <avinashphilip@ti.com>
List-ID: <linux-pwm.vger.kernel.org>


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 10:14:21AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> adding the author of the commit that introduced the .set_polarity
> callback (0aa0869c3c9b10338dd92a20fa4a9b6959f177b5), maybe he can add
> some value to this discussion.
>=20
> On Sun, Oct 14, 2018 at 01:34:00PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Fri, Oct 12, 2018 at 12:11:43PM +0200, Thierry Reding wrote:
> > > On Fri, Oct 12, 2018 at 11:45:57AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vok=C3=A1=C4=8D Michal wr=
ote:
> > > [...]
> > > > > >> Sidenote: With the current capabilities of the pwm framework t=
here is no
> > > > > >> technical reason to expose to the hardware drivers that the pw=
m user uses
> > > > > >> inverted logic. The framework could just apply
> > > > > >>
> > > > > >> 	duty =3D period - duty;
> > > > > >>
> > > > >=20
> > > > > I prefer to utilize as much HW capabilities as possible. And it s=
eems
> > > > > like most PWM chips support HW output inversion (to some extent) =
so to
> > > > > me it seems perfectly OK that that information can be propagated =
=66rom
> > > > > the upper SW levels to the lowest one.
> > > >=20
> > > > If the hardware capability is useful I fully agree. But if inversio=
n can
> > > > be accomplished by a chip that doesn't support inversion in hardwar=
e by
> > > > just using duty =3D period - duty (and so can be accomplished by a =
chip
> > > > that has inversion support without making use of it) then the drive=
rs
> > > > shouldn't be confronted with it.
> > >=20
> > > These two are orthogonal problems. If all you care about is the power
> > > output of the PWM (as is the case for backlights, LEDs or fans, for
> > > example), then inverted polarity has the same effect as duty =3D peri=
od -
> > > duty.
> > >=20
> > > However, the two don't result in identical waveforms.
> >=20
> > OK, let's find the difference then. Consider a pwm that is off at start,
> > then it's configured to run at 66% duty cycle at time A and then it's
> > disabled again at time B.
> >=20
> > The resulting wave form is:
> >=20
> > ______________       __       __       __       _____________________
> >               \_____/  \_____/  \_____/  \_____/
> >             A                                B
> >               ^        ^        ^        ^
> >=20
> > With the ^ markers pointing out where the periods started.
> >=20
> > Correct?
> >=20
> > Now with the duty =3D period - duty trick the wave would look as follow=
s:
> >=20
> >=20
> > _________________       __       __       __       __________________
> >                  \_____/  \_____/  \_____/  \_____/
> >             A                                B
> >               ^        ^        ^        ^
> >=20
> > Apart from a shift I cannot see any difference. I confirm that this
> > might be bad if there are two (or more) PWMs that are expected to run in
> > sync, but given that the current API doesn't provide the possibility to
> > map such a use case this is irrelevant.
> >=20
> > Another difference I confirm there might be is that this might result in
> > one more (or less) periods depending on timing and the capabilities of
> > the hardware. Is this bad? I'd say it isn't.
> >=20
> > What am I missing?
>=20
> The commit log of 0aa0869c3c9b10338dd92a20fa4a9b6959f177b5 mentions:
>=20
>     A practical example where [changing polarity] can prove useful is to
>     simulate inversion of the duty cycle. While inversion of polarity
>     and duty cycle are not exactly the same, the differences for most
>     use-cases are negligible.
>=20
> This doesn't help me to understand why the polarity stuff is useful
> though. Does this log say that the motivation to support changing
> polarity was to simulate "inversion of the duty cycle"? What exactly is
> "inversion of the duty cycle"? Just
>=20
> 	duty_cycle =3D period - duty_cycle;
>=20
> ? Why does this have to be simulated, the API was able to do this
> without any simulation before?
>=20
> Is there a single use-case that can be done with polarity support in the
> API that isn't possible without it? I cannot imagine there is any but
> would like to learn and understand why this is valuable.

See my earlier mail which will hopefully answer these questions.

> Currently there is no user of pwm_set_polarity(), I suggest to remove it
> to not give users an incentive to still rely on the non-atomic API.

Yeah, that's probably a good idea. The long-term plan was always to get
rid of the legacy API, but I haven't gotten around to that yet.

> Also among the users of pwm_apply_state there is none which makes use of
> the polarity setting.

Well, this is primarily because our current users don't care much about
the polarity setting, so they just go with whatever initial setting they
get (usually via pwm_get_args()). These correspond to whatever was
specified in the flags of the PWM specifier in DT or in the lookup table
for non-DT devices (see for example of_pwm_xlate_with_flags()).

There is one user that allows changing the polarity, and that's sysfs.

Thierry

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvEXbkACgkQ3SOs138+
s6F0jA//d1pwsJTK07aWv9lo7bfIBa+7UCVRpJRJL0ANSxb6N7S7LmZmqwo/iIaJ
OLwNOYpfa3q6ieKoRZynTbClP6nYX/cZyPCvzWBoXEGL/Y5KToa11JQpCchmL2VH
MkJPQF+sCyhJsf/93J2exHWq0hRDO3NPTvweaPFKEAjikwW1EouoOwXDetLJVkzi
aViscYLn7E7KF3T+/8TqSNWparXn8vXLtM5xh2DFHfNJXwxTcHC3sf5NTPM02txw
DoDjk4M5ArvlHtNF8JA6VnstNjj3zQwN3RlDuUC2OiGOXtWPDOI7bCeBM9vdX9VJ
BXqy/pr3Xx++XuPm5HigxugVK94ZAaCnEUkT8R6uDaFILUX/EXbmOp1yAw/+9rwt
H+v0bP57h+G3lfu/bf0QzBcrIxn1llnFy6WRg429dRzV7r90nOhVJHmokrXtyT6K
u4m3F8UVJ7b26g62+MKnzYGGkK7mGwlq1KALxRqjqcU1a3lMAM8da+WqGLbpahDg
jOQI2Sp0TZRVS+rFf4YuYFhblJWy4gGCXAN7JzPzFkVt2cNEsEkMMpAc7IUskIcF
LEmhopRRm/HYMzKv9jLvXq/+cUengLBEVLX4iVVHJw6TMHo9EY3t3z5jPEvxJboM
GXs6V4xsEJNgDIX/lA9/pkyn2ujLsYFHDsTC4FKEtttTePZPcwo=
=x+M1
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
