From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpss: Fix get_state runtime-pm reference handling
Date: Tue, 2 Jun 2020 14:40:45 +0200
Message-ID: <20200602124045.GC3360525@ulmo>
References: <20200512110044.95984-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200512110044.95984-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2020 at 01:00:44PM +0200, Hans de Goede wrote:
> Before commit cfc4c189bc70 ("pwm: Read initial hardware state at request
> time"), a driver's get_state callback would get called once per PWM from
> pwmchip_add().
>=20
> pwm-lpss' runtime-pm code was relying on this, getting a runtime-pm ref f=
or
> PWMs which are enabled at probe time from within its get_state callback,
> before enabling runtime-pm.
>=20
> The change to calling get_state at request time causes a number of
> problems:
>=20
> 1. PWMs enabled at probe time may get runtime suspended before they are
> requested, causing e.g. a LCD backlight controlled by the PWM to turn off.
>=20
> 2. When the request happens when the PWM has been runtime suspended, the
> ctrl register will read all 1 / 0xffffffff, causing get_state to store
> bogus values in the pwm_state.
>=20
> 3. get_state was using an async pm_runtime_get() call, because it assumed
> that runtime-pm has not been enabled yet. If shortly after the request an
> apply call is made, then the pwm_lpss_is_updating() check may trigger
> because the resume triggered by the pm_runtime_get() call is not complete
> yet, so the ctrl register still reads all 1 / 0xffffffff.
>=20
> This commit fixes these issues by moving the initial pm_runtime_get() call
> for PWMs which are enabled at probe time to the pwm_lpss_probe() function;
> and by making get_state take a runtime-pm ref before reading the ctrl reg.
>=20
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1828927
> Fixes: cfc4c189bc70 ("pwm: Read initial hardware state at request time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WSM0ACgkQ3SOs138+
s6FhRRAAuvaWzzTcka9pbQE9E0+InpTkaaM4jW+gV5eJAwbFAH/ggDepZsNJpRRy
H1c3PubRZFR3XPJFMcrJKDOvCAZC2pkChaeTqjtwBBForNIt+AoRhF3hgmr3bhMZ
Q7S3rahk9eDABzTNXWemesQfoyoNjnYAKqqRvPHG+rDIewOVBc6zY8lnQ3SS6Dy/
HY1oQopujNaub1T2aKfufdLGlPzCzIG/ZxuMmx5i2hG7SMVnS/Z//tKNhLrIPxt4
6fOun1F+2GgScUyjRz6tNIflHJ0B9emCZH6sc8J5vWtnXNtQ3XHft0YT7EQRpu7n
h6A9434xaPSblA/FLXTGxdW2qwPvrxFQ4ZAA43CdGYka9Ibd8A7T3jQMYdQs6vr0
r7z1s6dSVTQ+ai2+jds7GwU6v6TfQvlFb21nXz2cAbJBh0ZM9WrpFdaiXG//odXt
HNGNn6O3XcsSThigBk+j+RmJ2MSeGsUiTVD9w3TBknyrpPOdaMikeVtDjaD6dnbA
De9cIubENvTmEdsOp1MN2meImbPx9IrKYr/dPo+PSx01L6U550PiYg7L05rsulB1
15qEC0FRjtxypAjDXKcu1ovYM8749OnXskMmW4Ybq1aEvJROwYXfQiiBbU6RrwWZ
FBf5LQdD9ELqscfR70bcE/S0hrEgQ+jLAEdsr3OtpIXqrJuxN1s=
=oZB2
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
