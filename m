From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
Date: Mon, 11 Jul 2016 09:02:51 +0200
Message-ID: <20160711070251.GA5823@ulmo.ba.sec>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
 <20160708154302.GC1151@ulmo.ba.sec>
 <20160709094718.GB6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35313 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcGKHCz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 03:02:55 -0400
Content-Disposition: inline
In-Reply-To: <20160709094718.GB6247@sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 09, 2016 at 11:47:18AM +0200, Mark Brown wrote:
> On Fri, Jul 08, 2016 at 05:43:02PM +0200, Thierry Reding wrote:
>=20
> > Mark, do you want me to provide a stable branch with the PWM regulator
> > patches and resolve that conflict in your tree? Or would you rather take
> > the whole set based on a stable branch from the PWM tree? Or maybe yet
> > another possibility would be to base the PWM tree on a stable branch
> > from the regulator tree containing the above commit.
>=20
> Probably easiest to use this signed tag and resolve it in your tree:
>=20
> The following changes since commit 1a695a905c18548062509178b98bc91e675108=
64:
>=20
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tag=
s/pwm-modernization
>=20
> for you to fetch changes up to c2588393e6315ab68207323d37d2a73713d6bc81:
>=20
>   regulator: pwm: Fix regulator ramp delay for continuous mode (2016-07-0=
7 11:45:06 +0200)
>=20
> ----------------------------------------------------------------
> regulator: Provide a branch for moderninzation of the PWM code
>=20
> There's a new, improved PWM API which allows a lot of improvements in
> the PWM regulator driver.  Since the bulk of the changes are in the PWM
> API this is being managed in the PWM tree, merge pending regulator API
> changes to allow this to be resolved more easily.
>=20
> ----------------------------------------------------------------
> Alexandre Courbot (1):
>       regulator: pwm: Support for enable GPIO
>=20
> Boris Brezillon (1):
>       regulator: pwm: Drop unneeded pwm_enable() call
>=20
> Douglas Anderson (1):
>       regulator: pwm: Fix regulator ramp delay for continuous mode
>=20
>  .../bindings/regulator/pwm-regulator.txt           |  7 +++-
>  drivers/regulator/pwm-regulator.c                  | 40 ++++++++++++++++=
++----
>  2 files changed, 39 insertions(+), 8 deletions(-)

Merged into for-4.8/regulator of the PWM tree and rebased Boris'
pwm-regulator patches on top.

Boris, everything looks right to me, but can you take a quick look to
see if it all matches up with what you expect?

Thanks,
Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg0SYAAoJEN0jrNd/PrOhVjQQAIVc10FUWch6gk982/Bx5e1T
/UyHKQTNLh22B5RCd+zwRHmuz4ukqFkGgh0E3cXVih7i47VBvZpBAlS40Y5jPjH4
6B0LzfTbg1I9hT0xjr9gyAy+H2VhZINY/mRoJkkkdBy9zY6GeAhekuOqaoMLIdvf
zvQrVJan0M6DCoIgM5R+5Pxw8ZVzodyLNw/UMIIkVf8+WWElrs/ImlAI1t2+35Uy
gpjj6d0r9LclODfl9wro05Na7u2U4Rep54kzD9EALBNcAyoih86ZS61Cm/Xqh6Tc
Rb2Xn3arK/IyKcIPWvEHakX3kzzF1EkfnuHVvJnxuxV6bPxrMgLcT0bHpNciP3qF
WyagPZjiuI8r317oaL4cs4SUC4VL8sN9pYoHawVn+qAxeHrB+L7x6cDp8EIinyF8
F4UH2kDaep0qEMEIG7CdY5QQy3dnqg5zN1EXKS79uK9yGCbVAv4LME/gWYZR8RiO
10yJn4z0NqF6gcj/V7uj1811ouL/wkz0DZwmNEc0F6aLJWOgXzhmk1tDWg6tb5NY
Gl1KLcpwjkvkUqx38pzyg53u1xvNQhRrSVVqZatrXnv238S4YPv2OxmGfTqpSi6g
VncO9VQK4JJMU7VV0uyLVYmInXCJ2vNg/Y4ukqRqPu4czgwkIjLkj7RbY2Imet6Y
2Ly8gBxwOG3BpRn4wsNI
=/XGk
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
