Return-Path: <thierry.reding@gmail.com>
Date: Tue, 16 Oct 2018 13:16:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] pwm: lpss: Force runtime-resume on suspend on CHT
 devices
Message-ID: <20181016111652.GF8852@ulmo>
References: <20181014151202.29955-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <20181014151202.29955-1-hdegoede@redhat.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2018 at 05:12:00PM +0200, Hans de Goede wrote:
> Hi All,
>=20
> Here are 2 more / new pwm-lpss fixes.
>=20
> I've received a bug report that the recent ACPI-LPSS code changes which
> properly order device resume on Cherry Trail so that the GFX0 _PS0 method
> no longer exits with an error causes the backlight to flicker on some
> Cherry Trail devices.
>=20
> This series is the result of investigating this issue. On Cherry Trail
> devices under Windows the PWM controller used for the backlight is
> considered part of the GPU even though it is part of the LPSS block and
> thus is an entirely different independent hardware unit.
>=20
> Because of this on Cherry Trail the GPU's (GFX0 ACPI node) _PS3 and _PS0
> ACPI methods save and restore the PWM controller registers.
>=20
> After the recent fixes this save + restore of the PWM controller registers
> is actually also happening under Linux.
>=20
> If userspace blanks the screen before suspending, such as e.g. GNOME
> does, then the PWM controller will be runtime-suspended when the suspend
> starts. This causes the GFX0 _PS3 method to save a value of 0xffffffff
> for the PWM control register and to restore this value on resume.
> Note that the GPU's _PS0 method also puts the PWM controller in D0, so
> this write of 0xffffffff does actually stick.
>=20
> The first patch in this patch-set fixes this. This fix exposes another
> issue, the pwm-lpss driver unconditionally sets the update bit when
> pwm_apply gets called, even if nothing has changed. At least on
> Cherry Trail this seems to cause the next update (which actually changes
> something) to be ignored. The second patch fixes this issue.

Applied, thanks.

Thierry

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFyKQACgkQ3SOs138+
s6GzEQ//WsHr46KV1MOWtGI8uKTsY9ga49WBsNPcyPA5k6UdpnOBn/5Og8Qyd9wn
lXuw3j7hYlyiqJsz2WJf3Phnh9+lgW0g2u8MZgAJrjrizkPhfX4WQb/X9D6Ic/0M
6LG5gtITTpKv4EvrbFj0n0JcV7VmyqB0Rn3Az6PH9yp9YzyTxGQyvxw8LRqzDAKD
c8SwIMcS9mPGCIfypn0OS8mAUHFx2FLIETtNflW1RXyDIUKSvc9qCO998LZA9FpE
6GskBcgvnDJRA8eI1QsYqsLMboBmJJvGNGNzKWe86WYvjwOrEoDrAtUt706vBHAK
IpI7i5FeMRHOxVx5z7CXuRslw1GhjbEswVjJDFgVjZVUTtta8EIWqAdJ1MvIKtCB
L9crUsbOHUpJICs1Pdg9otO/YO6UXnNFj20Uv1DmCWv/X49iHDLPX004kx4BBO4a
T3ex1KeGTnOGUjBeiXLvXF2sVvuDt7I46zD/EhUdKFdEfOIUIo69i+Rxz8XR99ca
UvAMOpfaiMwmYmxbj8EvsDDMMvzUTHy6B//sbS0MxGUms7tGxB8vfTcQE3CHP8MS
UCOjKwU1nNFLcj7Xyw1lnY7RQd668apGphGqOVgkUi3oyhQwcj3CJz6dLIU2uV7U
e3HwJMsJN6wvHITZ5evjSjI8M+rgweemJFaJJiEH+ZDhYqK/zJo=
=oCad
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
