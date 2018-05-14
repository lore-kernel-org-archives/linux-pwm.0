From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
Date: Mon, 14 May 2018 13:50:32 +0200
Message-ID: <20180514115032.GF18312@ulmo>
References: <20180426121024.22023-1-hdegoede@redhat.com>
 <2943907.WSHDcS9sfS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2943907.WSHDcS9sfS@aspire.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 05:25:10PM +0200, Rafael J. Wysocki wrote:
> On Thursday, April 26, 2018 2:10:23 PM CEST Hans de Goede wrote:
> > On some devices the contents of the ctrl register get lost over a
> > suspend/resume and the PWM comes back up disabled after the resume.
> >=20
> > This is seen on some Bay Trail devices with the PWM in ACPI enumerated
> > mode, so it shows up as a platform device instead of a PCI device.
> >=20
> > If we still think it is enabled and then try to change the duty-cycle
> > after this, we end up with a "PWM_SW_UPDATE was not cleared" error and
> > the PWM is stuck in that state from then on.
> >=20
> > This commit adds suspend and resume pm callbacks to the pwm-lpss-platfo=
rm
> > code, which save/restore the ctrl register over a suspend/resume, fixing
> > this.
> >=20
> > Note that:
> >=20
> > 1) There is no need to do this over a runtime suspend, since we
> > only runtime suspend when disabled and then we properly set the enable
> > bit and reprogram the timings when we re-enable the PWM.
> >=20
> > 2) This may be happening on more systems then we realize, but has been
> > covered up sofar by a bug in the acpi-lpss.c code which was save/restor=
ing
> > the regular device registers instead of the lpss private registers due =
to
> > lpss_device_desc.prv_offset not being set. This is fixed by a later pat=
ch
> > in this series.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Andy, Thierry, any comments or concerns regarding this series?

Hans said in the cover letter of the first version of this series that
he preferred to merge both patches through the PWM tree because of the
dependency. So I'm waiting for an Acked-by from you on the ACPI bits.

Thierry

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr5eAMACgkQ3SOs138+
s6H70w//TsEzHGKXHUJd5O13Ojh73XCSAjGsm7ptFw7q178CPP/i5roLJ7pd6pBw
gTazyfQsltoqd69ORWiz2qDvo2lj8NxFLqeZYSZ4si6v9FR8cKP4JzEg71rzYT0L
6BE++1Ko57TRXzXxK3/dTPS3AKxYE0Tt02AwQLr4vjDcmKBkvSU/Xr0mXyBC9MoA
b16UuYQvzL5xXmnof3h95JIaZlMm8fBTNZe5FU34BrfSgS6FStXLM6X9NDqxBCJB
T2frsgfI+s/1p/m9pELu/O3INHhfTZNoNbQvTDdD8Uq+SbliLJs69AHCQdgTdL7i
8oQYUTVVMhOJ2dqRDkpO8kn/0goj3EMEleQQdrXJggOjs+IFpyHYMkCn6tHlu2so
sVRjbYgpRLWbbxMU18aiumEyKWTBZ+ZKePzJ5Ned6AMDy3wEkH7PgwwjYFPTefVX
dnu0AdRkZoCUvDpbgxHePkctkVvMbqpxy8N919Y4mrcINAEgs3bgEF9Y3d+C9KAO
ZtM8sWW/iyPazOt4sgNOyclyQ8YeRMaAlaEJZRZpB3siRosWcFiYcDZYySfcAwqb
Irqi0tM+99ZBNQgAQ2DHjPih965KPotqOr+8xNJN/12JpX48Q2046c3yKFQmD74y
wkjmXnvpm0lDIZ/GJvJhwbWOol8rUzVpE37h53gt9JLpMN1p/Ig=
=2QsM
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
