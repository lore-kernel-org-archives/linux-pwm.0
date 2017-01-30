From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 3/3] acpi: lpss: call pwm_add_table() for
 bsw PWM device
Date: Mon, 30 Jan 2017 10:47:14 +0100
Message-ID: <20170130094714.GA529@ulmo.ba.sec>
References: <20170122161409.21601-1-hdegoede@redhat.com>
 <20170122161409.21601-4-hdegoede@redhat.com>
 <20170130081839.GN3585@ulmo.ba.sec>
 <CAJZ5v0hS08PX88+bXcnCz_V5f_VZ1L49iXnu9rHwDGO2uM7Q0A@mail.gmail.com>
 <20170130093310.GI17297@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0093382778=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170130093310.GI17297@lahna.fi.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pwm@vger.kernel.org


--===============0093382778==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 11:33:10AM +0200, Mika Westerberg wrote:
> On Mon, Jan 30, 2017 at 09:28:09AM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 30, 2017 at 9:18 AM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > On Sun, Jan 22, 2017 at 05:14:09PM +0100, Hans de Goede wrote:
> > >> On x86 we do not have devicetree to link the PWM controller and
> > >> the display controller together. So someone needs to call
> > >> pwm_add_table() to create the link, so that the i915 driver's
> > >> pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.
> > >>
> > >> The PWM subsystem does not want to have pwm_add_table() calls
> > >> directly in PWM drivers (this leads to probe ordering issues),
> > >> so lets do it here since the acpi-lpss code is always builtin.
> > >>
> > >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> > >> ---
> > >> Changes in v2:
> > >> -Set new pwm_lookup module_name field in the table
> > >> ---
> > >>  drivers/acpi/acpi_lpss.c | 13 +++++++++++++
> > >>  1 file changed, 13 insertions(+)
> > >
> > > Rafael, do you mind if I take this through the PWM tree to resolve the
> > > build-time dependency?
> >=20
> > No, I don't, please go ahead, unless Mika/Andy see any problems in it.
>=20
> No problems from my side - looks good.

I've pulled this into a separate branch that also contains the
prerequisites, so if you ever need this in ACPI, I can provide a stable
branch or tag.

Thanks,
Thierry

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliPC58ACgkQ3SOs138+
s6Fnbw//WrG2p9/fcRocjeOxE8zhLyMH44ctX7oweg0Hp+Fpm+z8FGRpZKJh8Mph
691mKeYGeoMVWlxKbxyPlQl+ReQFxTwmpuI7mtEvJXKTkbTvYBg4mNUdi68/J9tc
UkQZCrPCN/KtCWEmPyXQX8Wr3gT+FXma+TQJSh0YHRimuM5BdIxSPdX5Gr1BRnGw
EPR5gJqkxhfxiLYSRXiAJvBxz9kwB3NcVXLOF38ZQeqtdPT/U5en1TrQWn23gdT4
72kx7VS2rm60R9CkEBlWDHG7CJpERp4udN6Q80QL0oaMcYzLcStD43bBGEx79dPN
dl9E00kcYB3XD1krm0/MI0vl36XS+nb/B+zLCLGVwe7gJD+wr/L0kdA6e2youaGo
z8TMuIg9lAieu4/sHgSL4SrxC3gxmN+eG0jp/3f22ns63H6paTiNjBY5Eug4vsr6
dUbg2z8BIsb4h5q6/piC8sQhnjalNBuBy8HRhwufszEqyZzJcbqDLVy00YR23q4z
kfYx6g1l1UefeR2MFiDPOZfAA98iJRET0puUKbpd/pyNJpwE6KeR+/oDDESCdFJT
WmeC3SdFiKOZn8MCSw9EsTK3JvDlDZt2ZK7mJAkjnw3kt8XnuYUHlsQnku8ERKVc
jYNzN5cRxnablRgjiNyWTsF+mRg151f+S2XREgJthOA1f+Qw/58=
=EHFD
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============0093382778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0093382778==--
