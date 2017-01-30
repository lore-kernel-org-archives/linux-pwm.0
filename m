From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/3] acpi: lpss: call pwm_add_table() for bsw PWM
 device
Date: Mon, 30 Jan 2017 09:18:39 +0100
Message-ID: <20170130081839.GN3585@ulmo.ba.sec>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XLsjFikA86nwwlhe"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170122161409.21601-4-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--XLsjFikA86nwwlhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 22, 2017 at 05:14:09PM +0100, Hans de Goede wrote:
> On x86 we do not have devicetree to link the PWM controller and
> the display controller together. So someone needs to call
> pwm_add_table() to create the link, so that the i915 driver's
> pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.
>=20
> The PWM subsystem does not want to have pwm_add_table() calls
> directly in PWM drivers (this leads to probe ordering issues),
> so lets do it here since the acpi-lpss code is always builtin.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> Changes in v2:
> -Set new pwm_lookup module_name field in the table
> ---
>  drivers/acpi/acpi_lpss.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Rafael, do you mind if I take this through the PWM tree to resolve the
build-time dependency?

Thanks,
Thierry

>=20
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 8ea836c..794be64 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_data/clk-lpss.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
>  #include <linux/delay.h>
> =20
>  #include "internal.h"
> @@ -154,6 +155,17 @@ static void byt_i2c_setup(struct lpss_private_data *=
pdata)
>  	writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
>  }
> =20
> +/* BSW PWM used for backlight control by the i915 driver */
> +static struct pwm_lookup bsw_pwm_lookup[] =3D {
> +	PWM_LOOKUP_MODNAME("80862288:00", 0, "0000:00:02.0", "pwm_backlight",
> +			   0, PWM_POLARITY_NORMAL, "pwm-lpss-platform"),
> +};
> +
> +static void bsw_pwm_setup(struct lpss_private_data *pdata)
> +{
> +	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
> +}
> +
>  static const struct lpss_device_desc lpt_dev_desc =3D {
>  	.flags =3D LPSS_CLK | LPSS_CLK_GATE | LPSS_CLK_DIVIDER | LPSS_LTR,
>  	.prv_offset =3D 0x800,
> @@ -191,6 +203,7 @@ static const struct lpss_device_desc byt_pwm_dev_desc=
 =3D {
> =20
>  static const struct lpss_device_desc bsw_pwm_dev_desc =3D {
>  	.flags =3D LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
> +	.setup =3D bsw_pwm_setup,
>  };
> =20
>  static const struct lpss_device_desc byt_uart_dev_desc =3D {
> --=20
> 2.9.3
>=20

--XLsjFikA86nwwlhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO9t8ACgkQ3SOs138+
s6GpcRAAvkRKqA3Dr//lSj9CaCPfHkkPSkePG8BJ9GZ0MwwFutsSkfNu6UyKB+Mk
NiVfnzWDpI25ZtP59FPO3syzcK6v1NjgPkyL6ti0kNKNy/HwYnKe1FBzOH+DEGj6
ixWQd5acV8oZF+VZioICxOLWYQqUZVPFryIyAdQ9SUZsFPaCUfQzNUXekGIa+d18
Q53NyAa26nXftuQGEygwcb5d/4cHQmT9CWAeaIeK9WEscxKFRLBNKyn1AFvBHMIA
h/dX5v0jMuWl90EmNuZGsL6fB+UbDUyAWcyQdtkTdeN5i201bmPWwk2r1aJHHQR6
7o0rL93LuAqsdhDvTlLO/iY4hhWdophX2ZRrWEAZkvFkqpidcGeMUORKl7ocql7h
GH/pAUnKH52VtPUUu2wIdHMwp98/pjal1iWSSGXRxzYc6tOddXK+waOjN72oQ27Y
6ozFgNfM3JKzffkPkw4hHL4Vp99YFstOat8GMA9wML4VGZF/zJN6a3mB9QyWjOy5
QvnR2B6kx/jIxcC2yFrT3MrVAgiCBbg7pKe9gYbyTzRdGKfP5RsQ5oM4BD+4MQ/k
6teyxa/537BTwXS3rnrolzi2KOMf6hbace9uIdbQuE9M2As9Zegoqud5RFDF7DLc
jRRdNlqQr1SrWLOODzlKEUP38Od9jNbXlaOk0rDvQ8P5rYqBzdw=
=X4qh
-----END PGP SIGNATURE-----

--XLsjFikA86nwwlhe--
