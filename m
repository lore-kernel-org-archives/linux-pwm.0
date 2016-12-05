From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: lpss: Add get_state callback
Date: Mon, 5 Dec 2016 08:36:19 +0100
Message-ID: <20161205073619.GC18069@ulmo.ba.sec>
References: <20161202101736.12236-1-hdegoede@redhat.com>
 <20161202101736.12236-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165211997=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20161202101736.12236-2-hdegoede@redhat.com>
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


--===============0165211997==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 11:17:36AM +0100, Hans de Goede wrote:
> Add a get_state callback so that the initial state correctly reflects
> the actual hardware state.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Please don't mix legacy with atomic PWM. There's a little bit of mixing
in the core for transitional purposes, but if you want to deal with PWM
state, please also replace the ->enable(), ->disable() and ->config()
implementations with ->apply().

Thierry

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRRjwAAoJEN0jrNd/PrOhRVcP/RrOCZCyOWiwliKnozZRCmCe
uwLs8FbVBxjNE/9CkHYz8PuHAKeoZLueOxivtBC1aqKeJV4PwrROJZsVF8wG32hw
NNnMa/x+1Mn33BECtPPodbXdGYKhZvKK88LBTqWbSmn0ZDGs1yaBsDszeT0HCRgy
35HFnVc55PcwtHkfTKPBmi9aTorlt0W4EqpgJnWG6WN5wXi5v0rEiKtQ6wjMWx0l
ATgqmmaeezLzuveB67n+B+KyNLWo75drTHwRq96QXzGlr9j72+ykGYuF/OtVFsV1
PDF8QOTblXoNy/lg7z24NfsQZ+eiU1+PLMZqzV8db0pDAD2W+zZ/FrormDC8yC5W
TDDmKzoIk5GYVTUQTASt/x2s7e+b43b9qpgmpDWpq4cQ7TsoVxLJzWF7+XaHJW3q
bDWqnMXO0FLURM31lQV3p+DydZq+pV+aDeGabcEz8mc13PXgUTlZq9Ka0q4pt7Ud
Dsol9mYF5l5g29Kt8zU/UBpE2XNf6D+vBOycWF6sBhrJ82EutWDjN/P+RPNCmC5Q
0SyQYjlYIdZxCW5+FNwlrFmGpFiAyWdyyTA9PE8LevBmUzzlpPjkXEspmURkEElJ
PU1ZHhtaI1gKo483mCPiWzivSdrbDezxWpNxiVthLZxjeJUMXi6diSrXEERLH9vc
deFsghs4JVfTPXBFsdp6
=z1aq
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--

--===============0165211997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0165211997==--
