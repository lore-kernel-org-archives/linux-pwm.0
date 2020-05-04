From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Date: Mon, 4 May 2020 07:14:57 +0000
Message-ID: <BYAPR12MB3014895B534A8A0C559C8053ADA60@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1587130362-6149-1-git-send-email-spatra@nvidia.com>
 <1587130362-6149-2-git-send-email-spatra@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1587130362-6149-2-git-send-email-spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bitan Biswas <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Gentle reminder.

> -----Original Message-----
> From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Sent: Friday, April 17, 2020 7:03 PM
> To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; u.kleine-
> koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Bitan Biswas <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>;
> linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sandipan Patra
> <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Subject: [PATCH 2/2] hwmon: pwm-fan: Add profile support and add remove
> module support
>=20
> This change has 2 parts:
> 1. Add support for profiles mode settings.
>     This allows different fan settings for trip point temp/hyst/pwm.
>     T194 has multiple fan-profiles support.
>=20
> 2. Add pwm-fan remove support. This is essential since the config is
>     tristate capable.
>=20
> Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/hwmon/pwm-fan.c | 113
> +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 101 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> 30b7b3e..6332ed8 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -3,8 +3,10 @@
>   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020, NVIDIA Corporation.
>   *
>   * Author: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> + * Author: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>   */
>=20
>  #include <linux/hwmon.h>
> @@ -21,6 +23,8 @@
>  #include <linux/timer.h>
>=20
>  #define MAX_PWM 255
> +/* Based on OF max device tree node name length */
> +#define MAX_PROFILE_NAME_LENGTH	31
>=20
>  struct pwm_fan_ctx {
>  	struct mutex lock;
> @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
>  	unsigned int *pwm_fan_cooling_levels;
> +
> +	unsigned int pwm_fan_profiles;
> +	const char **fan_profile_names;
> +	unsigned int **fan_profile_cooling_levels;
> +	unsigned int fan_current_profile;
> +
>  	struct thermal_cooling_device *cdev;
>  };
>=20
> @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct
> device *dev,
>  				       struct pwm_fan_ctx *ctx)
>  {
>  	struct device_node *np =3D dev->of_node;
> +	struct device_node *base_profile =3D NULL;
> +	struct device_node *profile_np =3D NULL;
> +	const char *default_profile =3D NULL;
>  	int num, i, ret;
>=20
> -	if (!of_find_property(np, "cooling-levels", NULL))
> -		return 0;
> +	num =3D of_property_count_u32_elems(np, "cooling-levels");
> +	if (num <=3D 0) {
> +		base_profile =3D of_get_child_by_name(np, "profiles");
> +		if (!base_profile) {
> +			dev_err(dev, "Wrong Data\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (base_profile) {
> +		ctx->pwm_fan_profiles =3D
> +			of_get_available_child_count(base_profile);
> +
> +		if (ctx->pwm_fan_profiles <=3D 0) {
> +			dev_err(dev, "Profiles used but not defined\n");
> +			return -EINVAL;
> +		}
>=20
> -	ret =3D of_property_count_u32_elems(np, "cooling-levels");
> -	if (ret <=3D 0) {
> -		dev_err(dev, "Wrong data!\n");
> -		return ret ? : -EINVAL;
> +		ctx->fan_profile_names =3D devm_kzalloc(dev,
> +			sizeof(const char *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +		ctx->fan_profile_cooling_levels =3D devm_kzalloc(dev,
> +			sizeof(int *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +
> +		if (!ctx->fan_profile_names
> +				|| !ctx->fan_profile_cooling_levels)
> +			return -ENOMEM;
> +
> +		ctx->fan_current_profile =3D 0;
> +		i =3D 0;
> +		for_each_available_child_of_node(base_profile, profile_np) {
> +			num =3D of_property_count_u32_elems(profile_np,
> +							"cooling-levels");
> +			if (num <=3D 0) {
> +				dev_err(dev, "No data in cooling-levels inside
> profile node!\n");
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string(profile_np, "name",
> +						&ctx->fan_profile_names[i]);
> +			if (default_profile &&
> +				!strncmp(default_profile,
> +				ctx->fan_profile_names[i],
> +				MAX_PROFILE_NAME_LENGTH))
> +				ctx->fan_current_profile =3D i;
> +
> +			ctx->fan_profile_cooling_levels[i] =3D
> +				devm_kzalloc(dev, sizeof(int) * num,
> +							GFP_KERNEL);
> +			if (!ctx->fan_profile_cooling_levels[i])
> +				return -ENOMEM;
> +
> +			of_property_read_u32_array(profile_np, "cooling-
> levels",
> +				ctx->fan_profile_cooling_levels[i], num);
> +			i++;
> +		}
>  	}
>=20
> -	num =3D ret;
>  	ctx->pwm_fan_cooling_levels =3D devm_kcalloc(dev, num, sizeof(u32),
>  						   GFP_KERNEL);
>  	if (!ctx->pwm_fan_cooling_levels)
>  		return -ENOMEM;
>=20
> -	ret =3D of_property_read_u32_array(np, "cooling-levels",
> -					 ctx->pwm_fan_cooling_levels, num);
> -	if (ret) {
> -		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> -		return ret;
> +	if (base_profile) {
> +		memcpy(ctx->pwm_fan_cooling_levels,
> +		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
> +						num);
> +	} else {
> +		ret =3D of_property_read_u32_array(np, "cooling-levels",
> +				ctx->pwm_fan_cooling_levels, num);
> +		if (ret) {
> +			dev_err(dev, "Property 'cooling-levels' cannot be
> read!\n");
> +			return -EINVAL;
> +		}
>  	}
>=20
>  	for (i =3D 0; i < num; i++) {
> @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device
> *pdev)
>  	return 0;
>  }
>=20
> +static int pwm_fan_remove(struct platform_device *pdev) {
> +	struct pwm_fan_ctx *ctx =3D platform_get_drvdata(pdev);
> +	struct pwm_args args;
> +
> +	if (!ctx)
> +		return -EINVAL;
> +
> +	if (IS_ENABLED(CONFIG_THERMAL))
> +		thermal_cooling_device_unregister(ctx->cdev);
> +
> +	pwm_get_args(ctx->pwm, &args);
> +	pwm_config(ctx->pwm, 0, args.period);
> +	pwm_disable(ctx->pwm);
> +
> +	return 0;
> +}
> +
> +
>  static int pwm_fan_disable(struct device *dev)  {
>  	struct pwm_fan_ctx *ctx =3D dev_get_drvdata(dev); @@ -465,6 +552,7
> @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
>=20
>  static struct platform_driver pwm_fan_driver =3D {
>  	.probe		=3D pwm_fan_probe,
> +	.remove         =3D pwm_fan_remove,
>  	.shutdown	=3D pwm_fan_shutdown,
>  	.driver	=3D {
>  		.name		=3D "pwm-fan",
> @@ -476,6 +564,7 @@ static struct platform_driver pwm_fan_driver =3D {
> module_platform_driver(pwm_fan_driver);
>=20
>  MODULE_AUTHOR("Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_AUTHOR("Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
>  MODULE_ALIAS("platform:pwm-fan");
>  MODULE_DESCRIPTION("PWM FAN driver");
>  MODULE_LICENSE("GPL");
> --
> 2.7.4
