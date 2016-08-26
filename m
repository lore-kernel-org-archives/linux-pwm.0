From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/2] pwm: sunxi: Yield some time to the pwm-block to
 become ready
Date: Sat, 27 Aug 2016 00:25:23 +0200
Message-ID: <20160826222523.GH3165@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-3-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55690 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbcHZWZZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Aug 2016 18:25:25 -0400
Content-Disposition: inline
In-Reply-To: <1472147411-30424-3-git-send-email-oliver@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Olliver Schinagl <o.schinagl@ultimaker.com>


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 07:50:11PM +0200, Olliver Schinagl wrote:
> From: Olliver Schinagl <o.schinagl@ultimaker.com>
>=20
> The pwm-block of some of the sunxi chips feature a 'ready' flag to
> indicate the software that it is ready for new commands.
>=20
> Right now, when we call pwm_config and set the period, we write the
> values to the registers, and turn off the clock to the IP. Because of
> this, the hardware does not have time to configure the hardware and set
> the 'ready' flag.
>=20
> By running the clock just before making new changes and before checking
> if the hardware is ready, the hardware has time to reconfigure itself
> and set the clear the flag appropriately.
>=20
> Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 5e97c8a..dd198c3 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -105,6 +105,22 @@ static int sun4i_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	u64 clk_rate, div =3D 0;
>  	unsigned int prescaler =3D 0;
>  	int err;
> +	int ret =3D 0;
> +
> +	/* Let the PWM hardware run before making any changes. We do this to
> +	 * allow the hardware to have some time to clear the 'ready' flag.
> +	 */

This is not the proper comment style.

> +	err =3D clk_prepare_enable(sun4i_pwm->clk);
> +	if (err) {
> +		dev_err(chip->dev, "failed to enable PWM clock\n");
> +		return err;
> +	}

New line please.

> +	spin_lock(&sun4i_pwm->ctrl_lock);
> +	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +	clk_gate =3D val & BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> +	val |=3D BIT_CH(PWM_CLK_GATING, pwm->hwpwm);

What are you doing here? You clear a bit, and then put the same one
back in?

> +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> +	spin_unlock(&sun4i_pwm->ctrl_lock);
> =20
>  	clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> =20
> @@ -137,7 +153,9 @@ static int sun4i_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> =20
>  		if (div - 1 > PWM_PRD_MASK) {
>  			dev_err(chip->dev, "period exceeds the maximum value\n");
> -			return -EINVAL;
> +			ret =3D -EINVAL;
> +			spin_lock(&sun4i_pwm->ctrl_lock);

Uh? That's really suspicious. And even if right, please don't do that,
this is just really bad for the comprehension of the workflow.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXwMHTAAoJEBx+YmzsjxAggkkP/RxUsQKG8u00UQAmCc91sbOg
6d1a7Y0ixB7l43wlUg7nt5QSE9Hg/muiQbNppl2waMRDOlCYdM+dTU2iq3BsqNHj
FoHOaRhhpsZMl6KTM4S+xiFwelZt+4gj9tIa99C9ATvDnjBW/gtKNJ80Ud9A75T5
oZErh0sl61R4bWbjZfZZ7DgI4FKCg9H3cGFXBOg4U080XVO1kTXXEuVcwMexs/Ik
gY3NT0dGJyiqrCKkoljAfB2pP9waQfmQpn5/uBZGZsgXRIy3k6t3qfe/8E2N6mnQ
5jGrtYBCVfxynUQ8kfv0z0IOKRnNp519leL/IPbganbjYa+SPN+jL071G442UMUE
r3ZsGCm4Vw6XpCZ6/bNVZ3kZ+ljfaDap/Y4L3N6da4mi+7BCNeF+vMgKPCNdmDv4
xCumfSiFE3xosUM000dP5s3Prm2zah2X5zR6u5OZ9GZCPYet4UV8XB/hFS/LOm90
DDvcV2RoOB90KfBdTU29Fex+zJxKzezqaHvHs3aSgua85806+KJvDUvh+kEMKLkr
/oNLx9cPrIri4uIovG1Se3qPD9QjWF6EfdwrAPjFSsbxrkul0C34Tg9KqWUyTMTG
JBLx21jZRtXasYOb672SbEs4uUnoQWB07RKSu274c1bIqw9Z7fExsDghKixos7ug
dBO6iFojdbt7pu2wkE5d
=RmJZ
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
