Return-path: <kernel-bounces@pengutronix.de>
Date: Fri, 12 Oct 2018 12:11:43 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20181012101143.GC9162@ulmo>
References: <20180806155129.cjcc7okmwtaujf43@pengutronix.de>
 <20181009075345.GB5565@ulmo>
 <20181009093554.ugfxek3n4wacc7px@pengutronix.de>
 <20181010122607.GA21134@ulmo>
 <20181011101914.dapsvczsd4lteugk@pengutronix.de>
 <20181011120007.GA22811@ulmo>
 <c11b425a-0907-d489-81a9-92289dc51028@ysoft.com>
 <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20181012094557.ktasxus2zrbsp5rx@pengutronix.de>
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
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Gavin Schenk <g.schenk@eckelmann.de>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>
List-ID: <linux-pwm.vger.kernel.org>


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2018 at 11:45:57AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Oct 11, 2018 at 01:15:44PM +0000, Vok=C3=A1=C4=8D Michal wrote:
[...]
> > >> Sidenote: With the current capabilities of the pwm framework there i=
s no
> > >> technical reason to expose to the hardware drivers that the pwm user=
 uses
> > >> inverted logic. The framework could just apply
> > >>
> > >> 	duty =3D period - duty;
> > >>
> >=20
> > I prefer to utilize as much HW capabilities as possible. And it seems
> > like most PWM chips support HW output inversion (to some extent) so to
> > me it seems perfectly OK that that information can be propagated from
> > the upper SW levels to the lowest one.
>=20
> If the hardware capability is useful I fully agree. But if inversion can
> be accomplished by a chip that doesn't support inversion in hardware by
> just using duty =3D period - duty (and so can be accomplished by a chip
> that has inversion support without making use of it) then the drivers
> shouldn't be confronted with it.

These two are orthogonal problems. If all you care about is the power
output of the PWM (as is the case for backlights, LEDs or fans, for
example), then inverted polarity has the same effect as duty =3D period -
duty.

However, the two don't result in identical waveforms. Again, a backlight
or LED doesn't care about the exact waveform, but there are other uses
for PWMs where these actually are important. I have admittedly never
used any of them myself, but this was brought to my attention a long
time ago when polarity support was introduced. I'm sure you can find the
discussions in some archives if you are inclined to do so.

> (I'm not sure if inversion is really relevant with the current status
> quo, as the expectations are not documented in a place I'm aware of.)

See the kerneldoc for enum pwm_polarity which does document this.

Thierry

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAc1wACgkQ3SOs138+
s6FOlRAAtOypw660m+1pC3ymorsFTTSA87ex5kAJQ6dnPRxwA2AqHGyTOJAx1I1w
xC44ABqBGNqUXYnRPq/p6JvUH03e46sGmegq7H3AF0Xpoic0DGWh2M9AWo+G91ah
dcHMbkux+zt/hL5j0DiHG1o6m8ctvrwXWImjb375lpWo3tJwiX4aJ54laWDBZVYc
ir4MpgmhgHGlodtSJ7/KhHKBauwwOZ7EssYAquJqoHSsxUEcvoEmftNes8PSAMLZ
uuGbMlllMgt6sOrVOrnxTVu7JYJFciSh35dZQqm4X8ciOk+QXc7zrBilvPWm4iE5
uDuj/2XDhZkfhtQGu5wqIWUeOueWTbQpy2BUvchMyOFqJsvviT5o17T4rlEL3A+z
G8ITItsh2uOqN8BM6tx/t8q1pSn7SLeCeZzQE9zblaOSjoL180n4Y9PNUKE8Nm87
u9bVTG02O4ldaJp0QEHBtXGlWcgHfOHxuraXwy9xf7FH+79UkZ595skhf9O0wPJM
wSdJJnc1RtFVo5AxDnML0n8Ud+ePdCf7Zp0vRCrIQkxgsiE3xz/Ef58lgl1nqCkZ
dsDQ7da83D80MmSBLnL8M3nH02aUb9Bm/nRANbZKm7M8FukGhPNAcOoDFkZkOO8u
JoYzTKjEJP8rY66ZkowMhKg85a2evFa0nol0oTcKhzK52iNuH9M=
=ip6N
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
