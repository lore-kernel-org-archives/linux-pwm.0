From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] acpi: lpss: call pwm_add_table() for bsw pwm device
Date: Fri, 20 Jan 2017 07:48:19 +0100
Message-ID: <20170120064819.GC4894@ulmo.ba.sec>
References: <20170119175338.3543-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119175338.3543-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 06:53:38PM +0100, Hans de Goede wrote:
> On x86 we do not have devicetree to link the pwm controller and
> the display controller together. So someone needs to call
> pwm_add_table() to create the link, so that the i915 driver's
> pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.
>=20
> The pwm subsystem does not want to have pwm_add_table() calls
> directly in pwm drivers (this leads to probe ordering issues),
> so lets do it here since the acpi-lpss code is always builtin.

Nit: "pwm" -> "PWM" in the above. Other than that this looks like a much
more suitable location for pwm_add_table(), so:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBsrMACgkQ3SOs138+
s6EIcQ/8DCN3xgUa6SndPuVTiFgf64gWbxrUdJSNjDDgrqhIrldAHgxnFfM424uJ
CvURi2YePoHxtcR3MRWO7i08DjHXU0N1GPUrZMaWDYhRFGE4/dn5pL13ZcurZh/w
JnRd2jsYUUNIUHptB2XIAi1S8Ab7uXO3HGYQuxYoV0midKjsfixJQAwUFshsLzoR
qbKVsUNUADn+z6GTNBCw9YcSE2zpPj/W5lypEwTS4at7ohlsrQtvV966yk3gsW2I
PP4pQ2wqCZG15/so0/9aHfIrsi02c4PxGfkL7GWkk7XE+E4TzK3WOlTX7uV0sXrk
bzw1tIhBvbge662SfBqtzSgozcn0FERZgHlozM8KPsCPYe17gNkRKOcrX9GLSIWZ
vqDXkdh0OSBNefdlHDG5JSP64Bw90dRnXkJpZ8btW6H8uyWP1Zo1r5lr5WT4mbX1
eBGaGApyx+lTbjNemPcbjbwS1T8pmpc7boWDdPI8ve+0fZaO90clphUHBPu0Hs+7
l8tLs72DPA0jcJ57oI9d7/oI0igpMm22qSQpOtzfzjFiNGJ8fiVb7/mZkAB+Yv34
qM/AEVMtkvee79NrnyfsOOEh7FllXwPIj2/Q//aMtcBvsu/AdOJ/uA8g0Vv80Gl9
MxVCFbRH9zLVkurvSmbsxYjrpyUzqMw/hibQfeOQdIvdvOjjZ8g=
=nYYY
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
