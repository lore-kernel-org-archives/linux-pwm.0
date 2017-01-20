From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 11:42:10 +0100
Message-ID: <20170120104210.GH3824@ulmo.ba.sec>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
 <20170120085617.GG4894@ulmo.ba.sec>
 <280ead58-d2c9-f36e-cbfb-90cd7ad5b6f3@redhat.com>
 <1484906109.2133.262.camel@linux.intel.com>
 <94d3254b-c658-526d-dd5e-173aad9779c6@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1285343483=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <94d3254b-c658-526d-dd5e-173aad9779c6@redhat.com>
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


--===============1285343483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 11:18:29AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 20-01-17 10:55, Andy Shevchenko wrote:
> > On Fri, 2017-01-20 at 10:48 +0100, Hans de Goede wrote:
> > > I'm fine with doing a v3 with a comment, how about putting that
> > > comment
> > > right at all the module* stuff and explain there that that is to
> > > stay as the builtin only status is meant to be temporary ?
> >=20
> > Can we do other way around? I mean that either i915 selects PWM_LPSS to
> > be built-in, or uses request_module() call?
>=20
> PWM_LPSS needs to be built-in if enabled, a stripped down kernel
> for non cherrytrail hardware does not need it ...
>=20
> Also (and esp for request_module) this means building knowledge
> into the i915 driver about which pwm hardware there is on which
> boards which is undesirable.
>=20
> Thierry, this does give me an idea though, what if we extend
> the info passed to pwm_add_table with a module-name and
> make pwm_get call request_module() ?

I'm not sure that's even necessary. request_module() forwards the string
you pass to it to the userspace helper, so you can pass things like the
modalias to it. I suspect that for ACPI the modalias could be trivially
derived from the provider name already in the table.

Or maybe it couldn't. We don't have information about the type of device
and the name doesn't match, or at least it would be much more difficult
to extend the same method to other types of devices. Module name doesn't
sound too bad, as long as it's optional.

Thierry

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB6YAACgkQ3SOs138+
s6FDIw//f6EBXRJ0eVzSe6qXf26GZVRgnveWKDvlp+KlBdik5WUXETlS4sEjo5Ct
O5TuDfPf6cd4X8DSh8NhzT4cnRLm4oJKNLw55hGXVgkYzZSwIWpTs8v1mgUpJrxC
AQYgHsv0F6GAjLV03JCY7f6QDR1k0hUMPkGX2AGXY3xDcpaJoBugcOsN2nryyjUp
6MNyEkloqbkd7xChQL9Jxn73pxQ51KurmrPYsSCRAUpgd5VUIGmP/1fcDq+2Ql/T
epIjsR/8IJ82fLcmCHgOYslvPFPwK/78A0p0GLLM77/CqhhEJXxBTC82+BDxg/vX
1jVMnxSZAyuy73yUcOTVZwlKtWNbniLsvUt7UDk50AYFSbmpDDMVuNp9it5s9WcG
LR4KQ85xQXjf+6U+xn3huzuVTtcicz5EEkYuQLQMyii8lg2Gg4A9cZ4C+FWZY+vF
t9WSowCH+tEo0lhgzcpfIDRrNV/Wf8HLjmQZneDeUPv8T8jIhUudaY3x8Dw6xce7
+mpeGz0FT6Stxot9Rd7qpX6txWaUVi+TnngUzT9hyzCKdKilgK8X7yUKVL8p2XYC
qzSrpaQRCaXOIQXPvE4WudP3/3UqJ27X01pKcxaBvONy+JI+vxBc2zPaL0TWcy+h
wZX3gkU6Z74pv3rZGgAhE2DrMWcK/a1LQBRPAVeXLVw8KRqutXE=
=I0b+
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--

--===============1285343483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1285343483==--
