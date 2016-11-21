From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/2] backlight: pwm_bl: Check the pwm state for
 initial backlight power state
Date: Mon, 21 Nov 2016 09:13:35 +0100
Message-ID: <20161121081335.GB25171@ulmo.ba.sec>
References: <20161101125933.11168-1-peter.ujfalusi@ti.com>
 <20161101125933.11168-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36650 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752833AbcKUINi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Nov 2016 03:13:38 -0500
Content-Disposition: inline
In-Reply-To: <20161101125933.11168-3-peter.ujfalusi@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: lee.jones@linaro.org, tomi.valkeinen@ti.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2016 at 02:59:33PM +0200, Peter Ujfalusi wrote:
> If the pwm is not enabled the backlight initially should not be enabled
> either if we have booted with DT and there is a phandle pointing to the
> backlight node.
>=20
> The patch extends the checks to decide if we should keep the backlight off
> initially.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 4b07da278b4f..f680f7b033b2 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -215,6 +215,10 @@ static int pwm_backlight_initial_power_state(const s=
truct pwm_bl_data *pb)
>  	if (!regulator_is_enabled(pb->power_supply))
>  		return FB_BLANK_POWERDOWN;
> =20
> +	/* The pwm is disabled, keep it like this */
> +	if (!pwm_is_enabled(pb->pwm))
> +		return FB_BLANK_POWERDOWN;
> +
>  	return FB_BLANK_UNBLANK;
>  }

I prefer "PWM" instead of "pwm" in prose (comments and commit message)
because it's an abbreviation.

Otherwise this looks correct:

Reviewed-by: Thierry Reding <treding@nvidia.com>

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYMqyuAAoJEN0jrNd/PrOhVHYP/R2Zm/lYid9UeO0OgWptgWFU
kSQ34W9LHze9FfCfWiLC/8gcdcLmnZe3R38F9plMOtXMyfk/l9kBs8KokUhh6s6G
b8QoDWnNdvPe4Z9YSPWsqQTmVOkLKwAx9kgBX0p46evpwVPvEECKn9km9mZ9lTBh
ihahLFxmge3roQIYPGe8+yJCrGNYx3OF3sOVrAqeLELEMVQP8Otrn7xckhHPUWOm
UF5twFzdwiz3f6sNCqT39VIfD++h67Rnow/RU0WwvI2alMnmmR06eHBYRFnF6SEU
+x31OpJ5rt1E1OnLZP99j4g8s7xS60h3mcPuKK3yaHNrkCCoqM8ziVzIZACiSO0D
onVqcmHvcpEH7aUYQHok/nfyRfBBxAM2hTHFg9Qa8lpc5ZeI/9xTGOnGLw4qcWkR
XNNgBfwezbHPOx9+XLMW6Ht32ZYhz7S63Ep2SImEbxH4uZCGvtfPU2Ac2DnAKoQs
VK1J7VYWZHMMYfFyXYDC0EmxJe61AX1QlB+zp1epWjOKmw/s0C+0aLIY/FcDAAUd
NexQLYXAcQ8ZZng5SPuvD2GPzOs05wxtIzzE/nAGzcHU6idph1I/T1A19XO1Eeh/
gk7OqcK1eWWg2QIOFoyeXrliRRWm2quCCBSQsEEN6iRj9EEwaYZCsOuz4dHCy57s
xcvSO/E0mdOEQ8GoJVcR
=C1G1
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
