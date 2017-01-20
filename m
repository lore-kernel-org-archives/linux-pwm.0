From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 08:03:33 +0100
Message-ID: <20170120070333.GD4894@ulmo.ba.sec>
References: <20170119175830.3754-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0619500208=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20170119175830.3754-1-hdegoede@redhat.com>
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


--===============0619500208==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 06:58:30PM +0100, Hans de Goede wrote:
> The primary consumer of the lpss pwm is the i915 kms driver,
> the i915 driver does not support get_pwm returning -EPROBE_DEFER and
> its init is very complex making this is almost impossible to fix.
>=20
> This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
> that when the i915 driver loads the lpss pwm will be available avoiding
> the -EPROBE_DEFER issue. Note that this is identical to how the same
> problem was solved for the pwm-crc driver, which is used by the i915
> driver on other platforms.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---
> Changes in v2:
> -Drop the pwm_add_table call (this has been moved to the acpi_lpss driver)
> ---
>  drivers/pwm/Kconfig | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

For the record I think this is completely wrong and i915 should be
taught how to deal with -EPROBE_DEFER. We've gone through a lot of
pain to clean up this kind of init-level ordering on other devices
and the result is, in my opinion, a *lot* better than what we had
before. It'd be shame to see i915 backpedal on that.

That said, if everyone else thinks that it really can't be done and
this workaround is the best way forward, I'll just shut up about it
and stop caring.

Mika, Andy, any objections to this?

Thierry

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliBtkMACgkQ3SOs138+
s6EnDw//fQwLynafw2cvXzsF5UC+iK6vaCXKSddQVqe12gcZnp0bWR3HRhC+wNbN
rdpRyYrhWsRLFL12kr9VMccxn4MVuARpHlJv342pTrU5CbtNC7h8d9Ctj+bKqp+q
ALT7XO6evpyZH8tNIcV3beBCm+hwiAKNa2uZ52nISYu4ztECaMKwKjxPH7893N0l
9jBy+7nP2tMlkwFrALIU0JnZLKN9+HhxbW35s39t1jMNJ8zcUIvT+37F1VY/XRwm
Kp1ixQlWV2nJjfxnPyl9mFtpdnBEfXDXN8QgjiDXTKQdhhROmtciwFFsPGNCutGn
LYuPUwDY+/VZyyA22LGb7CTsYdUYUuAPvJeq7USBcTgYJJNvX4S+J3tF2rP4PQ1g
RV4f1ZsXbfCxAE3xH56tvLOe7zSRpthv8oJjA3Soq4ZHY0p7hGO0p97Z/yXFv6rP
PB0pcOELJygwfWF2b6QWEdJ1AGJr0zJdFtW560t8cVXYlNaMVNxzXbb4qZsEZZ3l
zF3riiPJ0IxKfOs8o3AZuY1h/sTqgQrtTyGsHzvf0NNjWtSbw3Vbj0obbTUpJlld
ovszma4cjlDs6SmowmdJKztNE5sFezDb98N3VReUDdWe02Ll+gihlEjuUVmKmm1I
d9tGOrM3j3crqqQLaSH/cpvkXRwLUe+2+mIGbbXFnoKMDmv4CjM=
=aeUO
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

--===============0619500208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0619500208==--
