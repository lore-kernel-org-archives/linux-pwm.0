From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 00/14] regulator: pwm: various improvements
Date: Fri, 8 Jul 2016 18:35:42 +0200
Message-ID: <20160708163542.GD1151@ulmo.ba.sec>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35451 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbcGHQfr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Jul 2016 12:35:47 -0400
Content-Disposition: inline
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 11:13:08AM +0200, Boris Brezillon wrote:
> Hello,
>=20
> This patch series series aims at adding two important features to the
> pwm-regulator driver.
>=20
> The first one is the support for 'smooth handover' between the
> bootloader and the kernel. This is mainly solving problems we have when
> the PWM is controlling a critical regulator (like the one powering the
> DDR chip). Currently, when the PWM regulator acquire the PWM device it
> assumes it was off and it's safe to change the configuration before
> enabling it, which can generate glitches on the PWM signal which in turn
> generated glitches on the output voltage.
> To solve that we've introduced support for hardware readout to the
> PWM framework, so that the PWM regulator driver can adjust the PWM
> a probe time and avoid glitches.
> Atomic update is also helping in this regard.
>=20
> Patch 1 is adding convenient helpers (at the PWM level) that will be
> used by the PWM regulator driver.
> Patches 2 to 7 are preparing everything on the PWM driver side to make
> hardware readout available to all platforms using the PWM regulator
> driver (rockchip and sti).
> Patches 8 to 11 are making use of the atomic update and hardware readout
> features to implement this smooth handover.
>=20
> The second feature we add to the driver is the capability of using
> a sub duty_cycle range in continuous mode. By default the regulator
> is assuming that min_uV is achieved with a 0% dutycyle and max_uV
> with a 100% dutycycle, but this is not necessarily true.
> Moreover, in some cases (when the PWM device does not support
> polarity inversion), we might have min_uV at 100% and max_uV at 0%.
> Hence the addition of new properties to the existing DT bindings.
> The feature is added in patch 12 and 13.
>=20
> Best Regards,
>=20
> Boris
>=20
> Changes since v2:
> - add Heiko's Tested-by
> - split patch 1 in 2 patches
> - rework the documentation
> - rename pwm_prepare_new_state() into pwm_init_state()
> - make pwm_set_relative_duty_cycle() return an error code when scale
>   or duty_cycle are inconsistent
>=20
> Changes since v1:
> - dropped already applied patches
> - added R-b/A-b/T-b tags
> - s/readl/readl_relaxed/ in patch 3 (as suggested by Brian)
> - fixed pwm-regulator DT binding doc
> - added some comments in the code
> - replaced pwm_get_state() + if (state.enabled) by if (pwm_is_enabled())
>=20
> Boris Brezillon (14):
>   pwm: Add an helper to prepare a new PWM state
>   pwm: Add two helpers to ease relative duty cycle manipulation
>   pwm: rockchip: Fix period and duty_cycle approximation
>   pwm: rockchip: Add support for hardware readout
>   pwm: rockchip: Avoid glitches on already running PWMs
>   pwm: rockchip: Add support for atomic update
>   pwm: sti: Add support for hardware readout
>   pwm: sti: Avoid glitches on already running PWMs
>   regulator: pwm: Adjust PWM config at probe time
>   regulator: pwm: Switch to the atomic PWM API
>   regulator: pwm: Properly initialize the ->state field
>   regulator: pwm: Retrieve correct voltage
>   regulator: pwm: Support extra continuous mode cases
>   regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

I've applied everything in this series to the PWM tree, except for the
two pwm-sti driver patches, which I'd like to get an Acked-by from one
of the maintainers.

Mark, let me know how you'd like to handle the miniature conflict in the
regulator-pwm driver that I mentioned in one of the patches.

Thierry

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXf9ZbAAoJEN0jrNd/PrOhhvAP/id19sAxwTv6pemfbCbfg2HF
fUmCm9rGz6XNuNmdNaZWXC7U3e2K2Uc07slCpK/mQHCARk+d6o9G64SnYmaN8NlN
PQI2G5X2mTs57oBDc9bTIaztvVBqK7hmRur2WufGgTEjOGtZyuTOstBb9iy05t7N
9PrNz6ArZNlo3kVlklYM8GraomDOiYzsnKtnvXaUT8mpPaVwRXxaYY8w7Y9uyy0a
6PhrZO8WDFGVuWojADdQv8DU1bmGGQA0JjWNFRElgj8v0f3ePCfDornRINa0joEX
qzqXpza/dVMFyvhpAb7tca7ZcvA3qhkMEK5M+W8qgfRuLnNmlyjGMaUf1RsjYEqt
Tx2RB7Uz+Ytz+8CkNbTla/haTxoaIB/BBocTG1PE5I4YZyUhxox0IDMGekuozIsD
4EqBOI8zo/hTqzKpnBvuy0PuD0dcRqFmoxxcLjfyXxykjGRC1thzRmqS7iDS7wMS
3bt62xmP4YNqT8+WBzU2dqWCRsO2i7JlU+4qm0xiG3DG79xGMNLl5yvFohJRGGhc
RyLUfSvZS7hnkMzESvKowdeQw8YbcIiDkDmwEkczUU7MzHUJ5XSKNxEQshlxqzUe
0B5yWCqQlH+laacmd/b6mGSbwiy+Y/EpmqYsJ0Nmt/6YhuAxlpFL37m++BJOGkNu
yVdtKPI098XrdwIKvBfr
=rfTA
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
