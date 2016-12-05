From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Make builtin and add
 lookup-table so that i915 can find the pwm_backlight
Date: Mon, 5 Dec 2016 08:46:30 +0100
Message-ID: <20161205074630.GD18069@ulmo.ba.sec>
References: <20161202101736.12236-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1495125422=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20161202101736.12236-1-hdegoede@redhat.com>
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


--===============1495125422==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 11:17:35AM +0100, Hans de Goede wrote:
> The primary consumer of the lpss pwm is the i915 kms driver, but
> currently that driver cannot get the pwm because i915 platforms are
> not using devicetree and pwm-lpss does not call pwm_add_table.
>=20
> Another problem is that i915 does not support get_pwm returning
> -EPROBE_DEFER and i915's init is very complex and this is almost
> impossible to fix.
>=20
> This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
> that when the i915 driver loads the lpss pwm will be available avoiding
> the -EPROBE_DEFER issue. Note that this is identical to how the same
> problem was solved for the pwm-crc driver.
>=20
> Being builtin also allows calling pwm_add_table directly from the
> pwm-lpss code, otherwise the pwm_add_table call would need to be put
> somewhere else to ensure it happens before i915 calls pwm_get,
> even if i915 would support -EPROBE_DEFER.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/Kconfig    | 12 +++---------
>  drivers/pwm/pwm-lpss.c | 11 +++++++++++
>  2 files changed, 14 insertions(+), 9 deletions(-)

This is completely backwards. You're putting board-specific bits into a
generic driver.

And no, this is not the same as pwm-crc because the board-specific bits
went into the MFD driver. I don't like that very much either, but there
is documentation that suggests that the Crystal Cove PMIC is used on a
single platform, whereas there's no such evidence for LPSS.

Why can't you just add something to drivers/platform/x86 to register the
table? You could base that on some kind of identifier (ACPI, DMI, ...)
to only do so if necessary.

I could probably live with making this builtin, but your justification
sounds like a bit of a lame excuse rather than a good technical reason.

Thierry

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRRtUAAoJEN0jrNd/PrOh4mMP/A9wBcwsvqBprUW9WlCWCkU7
sdPaQ0U+2T1je7/vjEZHUdCrEfInbG43mb4opAEyCdYlU4ZMTGrFLji2GbrwgxI0
jY3LjlsskzjLuATRdxTJjlU7zgwWlHdA/taA7EOPnvc9Zbch4RoYbFjTuVu8zW9U
Gy+JDQO+Ao1CoF1tp2vT1OqF6AJmpytHHImEHl7YpkWghrCMzDsJD+PSneP3OWSg
w8mLWx1+G8NCuWw0SdwhR7iU7npoQvSmZjPsfjS7HUdH+14De4nDYKyXA0HyhdGY
EHZWldVE0/OTGEQ4SspaMbs8+i2zck4QTDRrPu5rpezMHhtFsv0QAr5IAlo600cl
PsR10wfQkGi5Ae3oKsijx0wWV3mnhesvTn24SJF+Wtz0irMh91C+p1I3XOU1pnuA
6kMStEIjluGq1dINnLqhH+pMBr6wIEopkqtOWwATtzRax6CI1Zm1QMRY2YtpTQsJ
X29XoEwg8Me+gObbdRnXc07nTYs/nE2lZIIIhSE6lKssJPFwD9ER15vlQWexot/N
5ADlPCwBt0ajCfTelCFIrTNQH4gueQjd9e7XJaZBWX3EOZiFmk4X5L40QTtPWsW9
dc2gcmIb9fXu+w1GpKcd5UPuXpvbICMoSzQ334VSP3k0JiYeMFdRRTuKwMETieEE
f6ojes8CI+VGx5NdoZx4
=3uSq
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--

--===============1495125422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1495125422==--
