From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
Date: Fri, 12 Jun 2020 00:20:29 +0200
Message-ID: <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cab7bvsyn2ss63v7"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-10-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--cab7bvsyn2ss63v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
>=20
> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
> this commit makes crc_pwm_disable() clear it on disable and makes
> crc_pwm_enable() set it again on re-enable.
>=20
> This should disable the internal (divided) PWM clock and tri-state the
> PWM output pin when disabled, saving some power.

It would be great if you could also document that disabling the PWM
makes the output tri-state. There are a few drivers that have a
"Limitations" section at their top. Describing that there (in the same
format) would be the right place.

Also note that according to Thierry's conception getting a (driven)
inactive output is the right thing for a disabled PWM.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cab7bvsyn2ss63v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7irigACgkQwfwUeK3K
7Am/ugf/dDb23XNKHboy/tUBXfvicttKMcJeA2J2xQLa2smBZBSW6Rf227uTjwYi
LO+Kf0upcb1HCGqkE0t2BcTL6JwuMF6bIT8SONUYeHul6CyAYZTrberZhj/C6aoq
ea1xFjJr8WyAPUhXl4ZbTLfWyiNb2VeTdtF9FkB2FTarSuWTZR543f5Jk0mt6Xey
tMfjpCLepNvwDqYvfoqFgbhjzrSmIH8voI8IFGIOecEVpbc63L74FsNKQ3JNg8Ze
teRAOKKFK1VFYCrmBis286R9boQH2C5kkwC3raILdtXaJvPtFBJ9CKjITH/hTDzi
+YDSdup1pgUjtnMrUlmULfHAisd2sQ==
=JBUs
-----END PGP SIGNATURE-----

--cab7bvsyn2ss63v7--
