From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
Date: Sat, 11 Jul 2020 08:11:20 +0200
Message-ID: <20200711061120.di53sk5utjerb72q@pengutronix.de>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
 <20200709145013.GA3703480@smile.fi.intel.com>
 <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i75tuyf6yvyngkr2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--i75tuyf6yvyngkr2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2020 at 05:47:59PM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 7/9/20 4:50 PM, Andy Shevchenko wrote:
> > On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
> > > The datasheet specifies that programming the base_unit part of the
> > > ctrl register to 0 results in a contineous low signal.
> > >=20
> > > Adjust the get_state method to reflect this by setting pwm_state.peri=
od
> > > to 1 and duty_cycle to 0.
> >=20
> > ...
> >=20
> > > +	if (freq =3D=3D 0) {
> > > +		/* In this case the PWM outputs a continous low signal */
> >=20
> > > +		state->period =3D 1;
> >=20
> > I guess this should be something like half of the range (so base unit c=
alc
> > will give 128). Because with period =3D 1 (too small) it will give too =
small
> > base unit (if apply) and as a result we get high frequency pulses.
>=20
> You are right, that if after this the user only changes the duty-cycle
> things will work very poorly, we will end up with a base_unit value of
> e.g 65535 and then have almost no duty-cycle resolution at all.

Is this a problem of the consumer that we don't need to solve? Are there
known consumers running into this problem?

pwm_lpss_prepare() is buggy here, a request for a too low period should be
refused.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i75tuyf6yvyngkr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8JWAUACgkQwfwUeK3K
7Am6bwgAirh2AhV7d8cwVN4Wt7xXxd/MnOKxV17Cw3zranjnJE7tQZeRBOL5/Civ
dtfHNHU2LwoYrg8cFpa+zymwBfweQchUthe/mgyLGXAcnbgLHXYA//CxamUG2cUC
UMWI72IPGZbFfCadvNyPUBtMWpNH+zCr6QBxUtLKHsOBfT/1CF2nJm/yj/5tYnrD
T9YL0QaZ453zh7l7hNxoGrZqDKyeFVGiH3+g2GQ5e82MJ48Q/J/YGXyttOi5kQql
pjRC2BCsid7VEQ8I+1Oo3/XGTAAg1fHUtv7fSACvfX7F7IgrAZNZhSFGCNHnL7af
cDGBdDBztLhtWKBxczlFBvpcrnqKrA==
=uohE
-----END PGP SIGNATURE-----

--i75tuyf6yvyngkr2--
