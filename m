From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/5] pwm: Fixes and support for Tegra186
Date: Mon, 11 Jul 2016 11:31:40 +0200
Message-ID: <20160711093140.GD5823@ulmo.ba.sec>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36345 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbcGKJbo (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 05:31:44 -0400
Content-Disposition: inline
In-Reply-To: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: robh+dt@kernel.org, swarren@wwwdotorg.org, gnurou@gmail.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 05:17:18PM +0530, Laxman Dewangan wrote:
> Have fixes for 100% duty cycle, avoid computation loss for duty
> period calculation and add support the Tegra186.
>=20
> Hyong Bin Kim (1):
>   pwm: tegra: fix overflow when calculating duty cycle
>=20
> Laxman Dewangan (2):
>   pwm: tegra: Add DT node compatible for Tegra186
>   pwm: tegra: Add support for Tegra186
>=20
> Rohith Seelaboyina (1):
>   pwm: tegra: Add support for reset control
>=20
> Victor(Weiguo) Pan (1):
>   pwm: tegra: Allow 100% duty cycle
>=20
>  .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 +++--
>  drivers/pwm/pwm-tegra.c                            | 46 ++++++++++++++++=
++----
>  2 files changed, 45 insertions(+), 11 deletions(-)

All of these applied, with some minor changes.

Thierry

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg2d6AAoJEN0jrNd/PrOhHW4P/ii6bT1N4cxSOaqNueCGQzbr
sWd+oNdXJ9EQGBgvCF81aOKtuWW5vY+cjXqLceIpvmaHEEt2HxrE24NxdXHoOxsI
ebCJ3Mm2Js//w0bomIOIfXWHEryqNuf6MyFRWp6yqCO/oXuXvgFrNyLEG8ChJ6cb
2oinzYODPdZGFUPlsMz6gA06/e2QUQQk8wKR8kvzdGm0aw9NrPF00QWXbxEYZZlN
UeTmqmPZBC/3g0pAz7tU0OfRV7HQqKFJVShC7Hd71EGayxLzWUU02RRSYq3aZ9SX
xK2V4DhfHxu7Q1xaE/v4hYhMWzTOIH0V/TX5u3Ujo1HjyOSKRzpBts01HY1BIxuH
xzJiKhnmgz9U2ap4bckkOg01Lx1YDLMAxzAybBiyShUStk85iYbY7a2nsJtuVvXb
UFrYP1Q0qMhJEoMlG03gRTbAYJRZv1bcXTWNpdLQnbfFMbKbqgFMXKDBWI6IWmot
pXR7pyzq7KSXdrhx0MFm3Kw5PDMQ6rEhwuubJFz3N9IJEnC0kESb7+LAXr3cM325
qtWuhc7x4o+tqzDPaltATfwRgTapMoIZcfS1dVANjMm6GLnsC/Zg48ZCJ2OqswlB
+Q8quKPnaK4bM/V80n6OaroHdWJulswoHFi1eHkk6HdPLPfswGIJJTjqqOrIm5he
j4mi326cxQjBdGr62x1b
=U9lr
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
