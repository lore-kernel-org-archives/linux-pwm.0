From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 04/15] pwm: lpss: Add range limit check for the
 base_unit register value
Date: Tue, 7 Jul 2020 21:09:55 +0200
Message-ID: <20200707190955.e7wzmphdgi5reeyg@pengutronix.de>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-5-hdegoede@redhat.com>
 <20200622073554.wf3smq3tvnr6t2xy@taurus.defre.kleine-koenig.org>
 <e07a7dd6-c361-32b8-c4e7-91e022f9c21d@redhat.com>
 <20200707073424.w6vd6e4bhl56kosd@pengutronix.de>
 <1496178b-ce39-9285-ff75-cd39bc0e9aa7@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7plpv6eju6vsnduo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496178b-ce39-9285-ff75-cd39bc0e9aa7@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org


--7plpv6eju6vsnduo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

On Tue, Jul 07, 2020 at 07:31:29PM +0200, Hans de Goede wrote:
> On 7/7/20 9:34 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jul 06, 2020 at 10:53:08PM +0200, Hans de Goede wrote:
> > > But if we do then I think closest to the truth would be:
> > >=20
> > > state->period     =3D UINT_MAX;
> > > state->duty_cycle =3D 0;
> >=20
> > I'd say state->period =3D 1 & state->duty_cycle =3D 0 is a better
> > representation.
>=20
> But that would suggest the output is configured for an
> infinitely high output frequency, but the frequency is
> actually 0, the reason why get_state needs to treat a
> base_unit val of 0 special at all is to avoid a division
> by 0, and in math dividing by 0 gives infinite, isn't
> UINT_MAX a better way to represent infinity ?

Given that duty_cycle is 0, how can to tell anything about the period
when only seeing the signal (=3D a constant low)?

Given that (ideally) a period is completed when pwm_apply_state() is
called, a short period is much more sensible.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7plpv6eju6vsnduo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8EyIAACgkQwfwUeK3K
7Ambpgf+OJ0vfCZ750TsxFAYyk4uk7rXKWCSqHpltV8Pe7x4Mr2iu+tbdOiznRX9
ynS7zwePeRY1gwvSL31SrekGtm+JNGgLCvq2Dz/9xhHXA3W3wKFw3SO8am+MhT3R
Y9MDsdHpxTBh0AjbN1daU/7BNP+hTsWnTkJVTiSXu38aaj7heo5gpCB0R7OQ2D3j
9JCQOIMXKfnwSojxgXqOyjs5Pq2CbI8EXhgrQzkCObHFMQI9mNsq+pDsNqHAR/KJ
McCWW0NQOASKTyTD30+7VanXhcX3Mo462MoVWK2n+HsAkIZmwiTYs3L0+MiJvBSQ
A320+clEqiXwb25gfgV2LmabdrQA6w==
=Ac4Q
-----END PGP SIGNATURE-----

--7plpv6eju6vsnduo--
