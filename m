From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
Date: Fri, 8 Jul 2016 17:43:02 +0200
Message-ID: <20160708154302.GC1151@ulmo.ba.sec>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36687 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbcGHPnH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Jul 2016 11:43:07 -0400
Content-Disposition: inline
In-Reply-To: <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 11:13:20AM +0200, Boris Brezillon wrote:
> The continuous PWM voltage regulator is caching the voltage value in
> the ->volt_uV field. While most of the time this value should reflect the
> real voltage, sometime it can be sightly different if the PWM device
> rounded the set_duty_cycle request.
> Moreover, this value is not valid until someone has modified the regulator
> output.
>=20
> Remove the ->volt_uV field and always rely on the PWM state to calculate
> the regulator output.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Mark,
>=20
> I know you already added your Tested-by/Acked-by tags on this patch
> but this version has slightly change and is now making use of the
> pwm_get_relative_duty_cycle() helper instead of manually converting
> the absolute duty_cycle value into a relative one.
> ---
>  drivers/regulator/pwm-regulator.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-re=
gulator.c
> index 2000118..80d083f 100644
> --- a/drivers/regulator/pwm-regulator.c
> +++ b/drivers/regulator/pwm-regulator.c
> @@ -35,9 +35,6 @@ struct pwm_regulator_data {
>  	struct regulator_ops ops;
> =20
>  	int state;
> -
> -	/* Continuous voltage */
> -	int volt_uV;
>  };
> =20
>  struct pwm_voltages {
> @@ -135,8 +132,13 @@ static int pwm_regulator_is_enabled(struct regulator=
_dev *dev)
>  static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
>  {
>  	struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(rdev);
> +	int min_uV =3D rdev->constraints->min_uV;
> +	int diff =3D rdev->constraints->max_uV - min_uV;
> +	struct pwm_state pstate;
> =20
> -	return drvdata->volt_uV;
> +	pwm_get_state(drvdata->pwm, &pstate);
> +
> +	return min_uV + pwm_get_relative_duty_cycle(&pstate, diff);
>  }
> =20
>  static int pwm_regulator_set_voltage(struct regulator_dev *rdev,
> @@ -162,8 +164,6 @@ static int pwm_regulator_set_voltage(struct regulator=
_dev *rdev,
>  		return ret;
>  	}
> =20
> -	drvdata->volt_uV =3D min_uV;
> -
>  	/* Delay required by PWM regulator to settle to the new voltage */
>  	usleep_range(ramp_delay, ramp_delay + 1000);
> =20

This hunk has a minor conflict with the regulator tree and the commit
830583004e61 ("regulator: pwm: Drop unneeded pwm_enable() call") that
it contains.

Mark, do you want me to provide a stable branch with the PWM regulator
patches and resolve that conflict in your tree? Or would you rather take
the whole set based on a stable branch from the PWM tree? Or maybe yet
another possibility would be to base the PWM tree on a stable branch
=66rom the regulator tree containing the above commit.

Or we can let Linus sort out the conflict, it's really quite trivial.

Thierry

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXf8oDAAoJEN0jrNd/PrOh7MwQALo8s/ft6ZkGltrlvtDOsbWH
Ouriepw6c04tWUc0L2XU6YWN/QEGRioqCG6xiMLGluWAzOxzhq6mReDKHkBE9jmT
NGBoT5rPKJEHG6jniogaFd4rAw4/xWXgBikFqO266wpDA8IWwNliIIvFi2eTXqEx
ubZ3OXuAxpzB17mk30em4j3pWxDIp1OQ+KitQ65HmfUKbQHAQIEU/RZG96B/ivG9
9zO3wcc6Lxa64JzVIRItnbveUF19/4qrF2TF2QfBt56WcPEZap/O2mictje0MAIa
XF6bQjaF6LTgPkmVkDx40STGMStmmx1LuapSRW+G03cwcq3t8iDKAOjY9WchLp+b
K0dguQw95Ul52Ui9cQ8PMvtod9j50O8UXs0d8+Z2yPGSGseskfIb7gjVdtWEJHbB
C92S4B0hRw4okxs7dkhv8eT+fCOeHzyoLpcFgjFnXbb1GEwa2TWPAeM0XYecZ73z
dEkHgMX1z6F2OunLDyXmsVcTQYt/SMPLVELeSVdI1dyuBK62UeQD8nMvBlvKMyKd
bkYOo7KIVCPO0cM3f+OMIfvatRncw15wx3AObQzk4PksRu7uGCXoNnE90Ndzee0D
Bhx1OWm50+4gyFctJnbB/sZCcvNn2JVt21pJ3mXGMY9+Xt/hcmGycuZlTwiHKRYB
G+7zKdMAE4/KdvqlZYi6
=dkY1
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
