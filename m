From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: lpss: platform: Save/restore the ctrl
 register over a suspend/resume
Date: Wed, 6 Jun 2018 10:03:51 +0200
Message-ID: <20180606080351.GA11810@ulmo>
References: <20180426121024.22023-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426121024.22023-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 02:10:23PM +0200, Hans de Goede wrote:
> On some devices the contents of the ctrl register get lost over a
> suspend/resume and the PWM comes back up disabled after the resume.
>=20
> This is seen on some Bay Trail devices with the PWM in ACPI enumerated
> mode, so it shows up as a platform device instead of a PCI device.
>=20
> If we still think it is enabled and then try to change the duty-cycle
> after this, we end up with a "PWM_SW_UPDATE was not cleared" error and
> the PWM is stuck in that state from then on.
>=20
> This commit adds suspend and resume pm callbacks to the pwm-lpss-platform
> code, which save/restore the ctrl register over a suspend/resume, fixing
> this.
>=20
> Note that:
>=20
> 1) There is no need to do this over a runtime suspend, since we
> only runtime suspend when disabled and then we properly set the enable
> bit and reprogram the timings when we re-enable the PWM.
>=20
> 2) This may be happening on more systems then we realize, but has been
> covered up sofar by a bug in the acpi-lpss.c code which was save/restoring
> the regular device registers instead of the lpss private registers due to
> lpss_device_desc.prv_offset not being set. This is fixed by a later patch
> in this series.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add Cc: stable@vger.kernel.org to make sure this goes into stable
>  together with "ACPI / LPSS: Add missing prv_offset setting for byt/cht
>  PWM devices" which depends on this
> ---
>  drivers/pwm/pwm-lpss-platform.c |  5 +++++
>  drivers/pwm/pwm-lpss.c          | 30 ++++++++++++++++++++++++++++++
>  drivers/pwm/pwm-lpss.h          |  2 ++
>  3 files changed, 37 insertions(+)

Applied, thanks.

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXlWQACgkQ3SOs138+
s6GL8w/9GUfLl7kLvAPfHJuyKdTfjIEEUJLJyEL4eGy7YDfsEU9CU9Faaaw9c7US
PKip6BLJ4jnlQdmkMIGqIFg7bHFu5ldEPDYQSVN92+VrdnXsn6etWUAYaExNJyri
6hNoupkD94TQwF7ASKqDHNEStixXTjsqRDVBKJTWkqlyEXCkzslp5vFx3sU24tM7
nYzH/EekQOSEE67WktJQEdZ50MIwL2kn2GQfuvNiPCmh3tS0Hz/904BaqdJaqHSj
h6qr/Xn4XJajSa8GiDYfiiHUwNZcg8tOexpbeXsrJFTYDLRIntFFJl2IGEmxC4b6
BxpoEtkd2gsS89aZXRu5NQvpH7y+8h2w47pC5BX23GK2FiEZzfovW/X+Iv6Ys/bR
ZcwXv/i25Pj0GCd20lo7XyUsUI9Q+V4DinKt7K4ai9qyxl+hOL6vl7x/JlbgIIZX
jPqcIcJ+Rzv9cThrztexhFAErDr2YP/TT+Sn7/W9t+kB/H12L29Ou+Jl+UIYQzYY
lGYBMMo11j6RHXNgNwv2u3rxzYCwSv5lOy0q5trMrR04PeP6ZM9HmfrVvk6P4E4v
kDDP2TXNRKi4ZVPKCnaY22v/M/38Z5uPEI3YvfatS2IafabIQ+6pt/CRapL9DVaN
yCeI4X5UMEhdkQV4BpuVIch4UJ9JbC2gC+TgwkeQ2Mzz13/DolE=
=BI9V
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
