From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 08:18:53 +0100
Message-ID: <20170120071853.GE4894@ulmo.ba.sec>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720582363=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170120070333.GD4894@ulmo.ba.sec>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org


--===============0720582363==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 08:03:33AM +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2017 at 06:58:30PM +0100, Hans de Goede wrote:
> > The primary consumer of the lpss pwm is the i915 kms driver,
> > the i915 driver does not support get_pwm returning -EPROBE_DEFER and
> > its init is very complex making this is almost impossible to fix.
> >=20
> > This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
> > that when the i915 driver loads the lpss pwm will be available avoiding
> > the -EPROBE_DEFER issue. Note that this is identical to how the same
> > problem was solved for the pwm-crc driver, which is used by the i915
> > driver on other platforms.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > ---
> > Changes in v2:
> > -Drop the pwm_add_table call (this has been moved to the acpi_lpss driv=
er)
> > ---
> >  drivers/pwm/Kconfig | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
>=20
> For the record I think this is completely wrong and i915 should be
> taught how to deal with -EPROBE_DEFER. We've gone through a lot of
> pain to clean up this kind of init-level ordering on other devices
> and the result is, in my opinion, a *lot* better than what we had
> before. It'd be shame to see i915 backpedal on that.

Looking into i915 a little, I don't see why handling -EPROBE_DEFER would
be very complicated. The call stack looks somewhat like this:

	i915_pci_probe()
	i915_driver_load()
	i915_load_modeset_init()
	intel_modeset_init()
	intel_setup_outputs()
	intel_dsi_init()
	intel_panel_setup_backlight()
	pwm_setup_backlight()

In the above, intel_modeset_init() is the last one that propagates
errors, but its caller, i915_load_modeset_init() properly handles
failure from other function calls. Also, pwm_setup_backlight() can
return errors to intel_panel_setup_backlight(), which will in turn
propagate them to intel_dsi_init().

So I'd think that in order to properly handle -EPROBE_DEFER you'd only
need to propagate errors back up this way:

	intel_panel_setup_backlight()
	intel_dsi_init()
	intel_setup_outputs()
	intel_modeset_init()

That seems to me to be far from "almost impossible".

Thierry

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBudsACgkQ3SOs138+
s6FApA//Un0v0/S/iIMlKdaToASTwgNde8xXIy/gMSD70JnVOybZRtZf/NBY7Ao+
nRh1Vk/ZrChChYq4ZNqhrEFlSaDZIpiqau6+M70eoyELAwcgsLRSVG9Phrbsyu1p
GW01VIvIjFPLYX0OuoZb/4w4hFbPHu4F1igmWs30Ny5JNFa1hW9kw9awmU2IoCX3
tGSAtyyHQbZM5KX7S0xq3+wAVIGIVjq0LceoX68ti4Vey43BLmClFStIgW1kJw7n
r9DV5tUSxSl6KV3N4ITQtuw5VqyDf73wcR5OJRyOnhbV74y89ZfTaMMZbsjtbP3o
/w6h6cTHEzMZ005gprAJp2b/clvmKrdN+Jr+wdnamY0ZVF6x6pr1tcZjKshAGrFc
Haye/Wm7OjUFvTbDp1BXurEMyrseEEppRjH5QjqyO2P8aUxD78P6ls0O3P3PgMd9
n7Fd0Kl1lzNli/Mpa1DBw7YJNxsFfZ0cXn/kJzg/Y91tMtpWWTYQGjWcxkweNRBp
sC9do+NOPOUozXRciPu73MLe1U8nKFXxj3JInVd33jjfWpKwDbgh3Bfm9TK4RdHD
1qe+0P7nw2iwEZQlONTMtK/2RoPcaAOtbYvNpzXTlawIW2YQV6vi8U/9ey9imxfs
aUs4zwJMmXeIqeBY+C5ISVO2oTC4R5tz5iv1YY3OujI1w8vHcJs=
=3qwV
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--

--===============0720582363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0720582363==--
