From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] backlight: pwm_bl: re-add driver internal enabled tracking
Date: Wed, 14 Nov 2018 13:35:54 +0100
Message-ID: <20181114123554.GH2620@ulmo>
References: <20181109094857.27079-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0898309736=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181109094857.27079-1-heiko@sntech.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, enric.balletbo@collabora.com, lee.jones@linaro.org
List-Id: linux-pwm@vger.kernel.org


--===============0898309736==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 09, 2018 at 10:48:57AM +0100, Heiko Stuebner wrote:
> Commit e6bcca0890b9 ("backlight: pwm_bl: Switch to using "atomic" PWM API=
")
> removed the driver internal enabled tracking in favor of simply checking
> the pwm state.
>=20
> This can lead to issues as all of gpio-, regulator- and pwm-state are used
> to determine the initial state and the bootloader or kernel can leave them
> in an inconsistent state at boot.
>=20
> In my case on rk3399-kevin, the pwm backlight is build as module and the
> kernel disables the supply regulator as unused while keeping the pwm runn=
ing
> thus pwm_bl calling pwm_backlight_power_off() during probe and creating an
> unmatched regulator-disable call, as it never got enabled from the pwm-bl
> before.
>=20
> To prevent these consistency issues, reintroduce the driver-internal
> tracking of the enabled state.
>=20
> Fixes: e6bcca0890b9 ("backlight: pwm_bl: Switch to using "atomic" PWM API=
")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvsFqoACgkQ3SOs138+
s6Ep6w/+JzswUnZ2dv0rqO2wZBlRzpI0pCoz9RY2iVEyxQVN6K07ejOGHjnpvZbb
Lp/7avkuzl56cb9DRwqkGokBLX6zLZoLGRBYvwMN7yPACAdnA6IdkXm1k9MtwnpD
hCSwi1El5EXeuK/k/rLgl46LlaTDPotxb9KIJCdN26p4TcyrTVozoYgdbr7/4xZc
PCrfSsO/FyONwu8yN3Css9mzDvDRgqFd6dNyEDHdSm5smfUpcU7VG2+BF87BbsTQ
jzlkctTqlBeJ9FLPaZO4ztANJf6/J9ikW2A0r7yGi3/yD8zwzMYBPk+n0ej5eNZt
vcFxx9hrin15Bd6cLXJjEefL8zwrB78kZkBUwiecf+Zx2vy4E4/Srz98Yo4pjiT2
Zqzob2yp8tkd3+6fIopwLU3pBSVeAiMK4/12lBMdQm3/hl31ATc38ADKzO4xDcGi
4NGGwtT8gn5eUgx35qvu1fHqyw82sO5IYKuTGPesJL5kVxosaeDfnobIRucWBkBV
mr5mveBSiIJytQmiASGTB0n0/EpHV05W9NVRUV32NrqZAp/VtPUw0uJ7uNbsUFo9
2p7K2EWDSZ+AN75APJd9vTqNciHSuNJQM1G0/6NYawB78Fsdj6yc35lyKUwjQQpp
ZPWt49ecXoZoI1o4/w7pzfEnHVoBrh8eRxRCYd3cZyzv9+GSvRs=
=kUw3
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--

--===============0898309736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0898309736==--
