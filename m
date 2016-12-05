From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Make builtin and add
 lookup-table so that i915 can find the pwm_backlight
Date: Mon, 5 Dec 2016 11:59:43 +0100
Message-ID: <20161205105943.GB19891@ulmo.ba.sec>
References: <20161202101736.12236-1-hdegoede@redhat.com>
 <20161205074630.GD18069@ulmo.ba.sec>
 <bcd2a008-7dac-5084-90b5-e21634e7b57d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0336051017=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <bcd2a008-7dac-5084-90b5-e21634e7b57d@redhat.com>
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
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pwm@vger.kernel.org


--===============0336051017==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 09:18:03AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 05-12-16 08:46, Thierry Reding wrote:
> > On Fri, Dec 02, 2016 at 11:17:35AM +0100, Hans de Goede wrote:
> > > The primary consumer of the lpss pwm is the i915 kms driver, but
> > > currently that driver cannot get the pwm because i915 platforms are
> > > not using devicetree and pwm-lpss does not call pwm_add_table.
> > >=20
> > > Another problem is that i915 does not support get_pwm returning
> > > -EPROBE_DEFER and i915's init is very complex and this is almost
> > > impossible to fix.
> > >=20
> > > This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
> > > that when the i915 driver loads the lpss pwm will be available avoidi=
ng
> > > the -EPROBE_DEFER issue. Note that this is identical to how the same
> > > problem was solved for the pwm-crc driver.
> > >=20
> > > Being builtin also allows calling pwm_add_table directly from the
> > > pwm-lpss code, otherwise the pwm_add_table call would need to be put
> > > somewhere else to ensure it happens before i915 calls pwm_get,
> > > even if i915 would support -EPROBE_DEFER.
> > >=20
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  drivers/pwm/Kconfig    | 12 +++---------
> > >  drivers/pwm/pwm-lpss.c | 11 +++++++++++
> > >  2 files changed, 14 insertions(+), 9 deletions(-)
> >=20
> > This is completely backwards. You're putting board-specific bits into a
> > generic driver.
>=20
> This is not really board specific I'm advertising that the goal of
> the pwm is to be used to control a backlight.

pwm_add_table() is a board-specific API. Documentation/pwm.txt says that
"board setup code" should be using pwm_add_table(). Using it from within
the provider is completely the opposite.

> Before typing this reply I've been thinking about another place
> to put the pwm_add_table call put I cannot come up with any.

I suggested drivers/platform/x86. A bunch of code in there is doing
exactly the kind of board/platform setup stuff that you're trying to do
here.

>=20
> drivers/acpi/acpi_lpss.c comes to mind, but that would only work
> with the pwm device in acpi mode and not with it in pci mode.
>=20
> Another candidate would be to put the pwm_add_table call in the
> i915 driver itself, when the vbt says we need to use an external
> pwm and the plaform is cherrytrail, but it does not know if the
> pwm device is in pci or acpi modes which requires a different
> provider entry in the table.

i915 isn't a good location for that either. This should really be driven
by code external to any generic drivers. It's exactly the kind of glue
that platform or board setup code is used for.

If you look at drivers/platform/x86/intel_oaktrail.c, it does very
similar things. If this is specific to Cherry Trail, I'm sure you can
find ways to identify the platform as such and drive it in a similar way
=66rom drivers/platform/x86/intel_cherrytrail.c.

> Besides that having the pwm in the table will not do anything
> unless the i915 driver does a pwm_get, so this does not gain us
> anything.

It will keep the driver generic and put the board code where it belongs.
I call that very much of a gain.

> Maybe we need to rename the con_id from "pwm_backlight" to
> "pwm_lpss0", that way it is very clear which pwm any pwm_get calls
> are getting (and lpss-pwm.c is obviously the correct place to
> do the add_table), and then we can teach the i915 code to look
> for "pwm_lpss0" based on vbt info ?

pwm_backlight is the much better consumer name because by your own words
that's exactly what the PWM is used for. Obfuscating this by turning the
name into something unrecognizable such as pwm_lpss0 isn't going to
change any of the above.

Thierry

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRUifAAoJEN0jrNd/PrOhOe0P/RA6b+9Q5ZYEFHEglVOPM6F9
LD7noL1hcEijI2RxKdRWw2dLExKf2KQmqe/8CTaoHq0MFewvihuaOked2wjeicfF
l29HoP2TC/wnZLv8PXK47Pk96QiLkbw8pmHK3Bf/R0tr9vIgO2LPfFh072Ofbu3J
ksVCtfrw2+bicYelSCzaMv0LSVU+S0x5IcCbRPiyNEv9eLbemyDB9Dgvmczo8Dvp
4X+lWtl3dJzTObhe5HK2LlWxfWY7cXrcvJ5xgs7f81kw/YF8MRPZyQG2jjLUEQeu
vlz1CNW1XR8OSLajhfqgCbO2IhQGB5Z2nXh/aZXotxiLz4n9F2P9mn8W8CPMchm5
U3GBWjcvxLzjEOhk7KWkV/8I8mC13gxY5jsZXEaUtdm5B2PGreXwYqZ5Pn/Vb7IY
1B7RaFuLuniptJ8ZfnDDheVEsPG7EZ8TdyJV/EDXJhWp1mSQ+wfpgKcaKiTWR0yK
mcyis++ngpMPe3D7lF97aeha9WVx3GgLq+6ihNZ6BNnb11HJNSCIqnmhpkVs9AZR
qtg0Tfvh+N8PuT5nEw0MGTwwOOIvqLgdmE6/Hrtr3RusGTYit67JAIcULiH/1Pb2
4obAG59549a7Y3tlOjgk7Z8YEOzN/kx7JO2pdHClOBSOfeFi49ahHToKCRwsLEFM
Thzk6edkt52PcoyVrsDn
=EdKX
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--===============0336051017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0336051017==--
