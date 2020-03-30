From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 6/6] clocksource: timer-ti-dm: Enable autoreload in
 set_pwm
Date: Mon, 30 Mar 2020 15:18:47 +0200
Message-ID: <20200330131847.GE2431644@ulmo>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
 <20200305082715.15861-7-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200305082715.15861-7-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-pwm@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 01:57:15PM +0530, Lokesh Vutla wrote:
> dm timer ops set_load() api allows to configure the load value and to
> set the auto reload feature. But auto reload feature is independent of
> load value and should be part of configuring pwm. This way pwm can be
> disabled by disabling auto reload feature using set_pwm() so that the
> current pwm cycle will be completed. Else pwm disabling causes the
> cycle to be stopped abruptly.
>=20
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/clocksource/timer-ti-dm.c          | 16 +++++-----------
>  drivers/pwm/pwm-omap-dmtimer.c             |  8 +++++---
>  include/linux/platform_data/dmtimer-omap.h |  5 ++---
>  3 files changed, 12 insertions(+), 17 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B8bcACgkQ3SOs138+
s6GHXRAAsrVQlvWFy21hBIzF6GkkySuSLfUoa99TThDUvtL3Kiy2x/ZGXSRnA4GD
DpdJWpka1MkXPruK3aLfH9vAXNGX2HhtUjNY2tlQmw3JwrNTB4UnpSIYj7tJ0WWU
CXOL6UPMoT6OSKGXrm2gYe/f0otVAKjJWDsT0CsJRgUeTpA0gZwX6BRTTtxbebRe
urFAuAvQhBbpK8tEvPLRyiiO/utpYUPxBU/NpCgtyG6ZyKPg6WbWAgHGO5jRoGB9
A/0GHJvCX50yz/3b3sVrZN5KCaOoR57tB1yTOaDsFCCnMLtipFZQ9xehGoDies32
EHtb+8D3Lp283gWXkoU/RgfF2CNCArYxtdNprx6J7yQg7yKViYLHMNNNr69BN+aY
yx9Y03lIx6LBHRok+zjB5wPxFA53DJzUhqztNOfZGEEM9PD3GfppgnjX1L+IjyiP
vV34rKNS7VX05xUc9A4IinMlJrpGqWebxaC9ADLNUdGOGMUb/tVY8iii7E3joIq7
EY9VA4GH58Z9ndjNv+ou3ySB+3fNyVpjBiVHcJPrTc4iElj5A07huaTnStwlvs1W
TmeVKqgdjNGFuMUtjP6N74EsTgIGpWp0KWDfHGnHPOeCegWX2h/xFY3VqhMfyi9v
cRr5NoAipz0LwaNtQPiROUMI4N1AjY+hm+4Xp7HRYrk+3EDPezY=
=CayU
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
