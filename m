From: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remove
 module support
Date: Tue, 26 May 2020 09:05:16 +0000
Message-ID: <BYAPR12MB30140CD3D7C7263594FD4F30ADB00@BYAPR12MB3014.namprd12.prod.outlook.com>
References: <1590469565-14953-1-git-send-email-spatra@nvidia.com>
 <20200526070450.sackolk6m3qv7omy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200526070450.sackolk6m3qv7omy-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org" <kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org>, "jdelvare-IBi9RG/b67k@public.gmane.org" <jdelvare-IBi9RG/b67k@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bitan Biswas <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,



> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Sent: Tuesday, May 26, 2020 12:35 PM
> To: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Jonathan Hunter
> <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; kamil-MZ2JYD8fkKLYtjvyW6yDsg@public.gmane.org; jdelvare-IBi9RG/b67k@public.gmane.org; linux@roeck-
> us.net; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; Bitan Biswas
> <bbiswas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>; linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 1/2] hwmon: pwm-fan: Add profile support and add remo=
ve
> module support
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, May 26, 2020 at 10:36:04AM +0530, Sandipan Patra wrote:
> > This change has 2 parts:
> > 1. Add support for profiles mode settings.
> >     This allows different fan settings for trip point temp/hyst/pwm.
> >     T194 has multiple fan-profiles support.
> >
> > 2. Add pwm-fan remove support. This is essential since the config is
> >     tristate capable.
>=20
> These two are orthogonal, aren't they? So they belong in two patches.
>=20
> You have to expand the binding documentation.
>=20
> > Signed-off-by: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/hwmon/pwm-fan.c | 112
> > ++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 100 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c index
> > 30b7b3e..26db589 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -3,8 +3,10 @@
> >   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
> >   *
> >   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> > + * Copyright (c) 2020, NVIDIA Corporation.
> >   *
> >   * Author: Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > + * Author: Sandipan Patra <spatra-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >   */
> >
> >  #include <linux/hwmon.h>
> > @@ -21,6 +23,8 @@
> >  #include <linux/timer.h>
> >
> >  #define MAX_PWM 255
> > +/* Based on OF max device tree node name length */
> > +#define MAX_PROFILE_NAME_LENGTH      31
> >
> >  struct pwm_fan_ctx {
> >       struct mutex lock;
> > @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
> >       unsigned int pwm_fan_state;
> >       unsigned int pwm_fan_max_state;
> >       unsigned int *pwm_fan_cooling_levels;
> > +
> > +     unsigned int pwm_fan_profiles;
> > +     const char **fan_profile_names;
> > +     unsigned int **fan_profile_cooling_levels;
> > +     unsigned int fan_current_profile;
> > +
> >       struct thermal_cooling_device *cdev;  };
> >
> > @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct
> device *dev,
> >                                      struct pwm_fan_ctx *ctx)  {
> >       struct device_node *np =3D dev->of_node;
> > +     struct device_node *base_profile =3D NULL;
> > +     struct device_node *profile_np =3D NULL;
> > +     const char *default_profile =3D NULL;
> >       int num, i, ret;
> >
> > -     if (!of_find_property(np, "cooling-levels", NULL))
> > -             return 0;
> > +     num =3D of_property_count_u32_elems(np, "cooling-levels");
> > +     if (num <=3D 0) {
> > +             base_profile =3D of_get_child_by_name(np, "profiles");
> > +             if (!base_profile) {
> > +                     dev_err(dev, "Wrong Data\n");
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +
> > +     if (base_profile) {
> > +             ctx->pwm_fan_profiles =3D
> > +                     of_get_available_child_count(base_profile);
> > +
> > +             if (ctx->pwm_fan_profiles <=3D 0) {
> > +                     dev_err(dev, "Profiles used but not defined\n");
> > +                     return -EINVAL;
> > +             }
> >
> > -     ret =3D of_property_count_u32_elems(np, "cooling-levels");
> > -     if (ret <=3D 0) {
> > -             dev_err(dev, "Wrong data!\n");
> > -             return ret ? : -EINVAL;
> > +             ctx->fan_profile_names =3D devm_kzalloc(dev,
> > +                     sizeof(const char *) * ctx->pwm_fan_profiles,
> > +                                                     GFP_KERNEL);
> > +             ctx->fan_profile_cooling_levels =3D devm_kzalloc(dev,
> > +                     sizeof(int *) * ctx->pwm_fan_profiles,
> > +                                                     GFP_KERNEL);
> > +
> > +             if (!ctx->fan_profile_names
> > +                             || !ctx->fan_profile_cooling_levels)
> > +                     return -ENOMEM;
> > +
> > +             ctx->fan_current_profile =3D 0;
> > +             i =3D 0;
> > +             for_each_available_child_of_node(base_profile, profile_np=
) {
> > +                     num =3D of_property_count_u32_elems(profile_np,
> > +                                                     "cooling-levels")=
;
> > +                     if (num <=3D 0) {
> > +                             dev_err(dev, "No data in cooling-levels i=
nside profile
> node!\n");
> > +                             return -EINVAL;
> > +                     }
> > +
> > +                     of_property_read_string(profile_np, "name",
> > +                                             &ctx->fan_profile_names[i=
]);
> > +                     if (default_profile &&
> > +                             !strncmp(default_profile,
> > +                             ctx->fan_profile_names[i],
> > +                             MAX_PROFILE_NAME_LENGTH))
> > +                             ctx->fan_current_profile =3D i;
> > +
> > +                     ctx->fan_profile_cooling_levels[i] =3D
> > +                             devm_kzalloc(dev, sizeof(int) * num,
> > +                                                     GFP_KERNEL);
> > +                     if (!ctx->fan_profile_cooling_levels[i])
> > +                             return -ENOMEM;
> > +
> > +                     of_property_read_u32_array(profile_np, "cooling-l=
evels",
> > +                             ctx->fan_profile_cooling_levels[i], num);
> > +                     i++;
> > +             }
> >       }
> >
> > -     num =3D ret;
> >       ctx->pwm_fan_cooling_levels =3D devm_kcalloc(dev, num, sizeof(u32=
),
> >                                                  GFP_KERNEL);
> >       if (!ctx->pwm_fan_cooling_levels)
> >               return -ENOMEM;
> >
> > -     ret =3D of_property_read_u32_array(np, "cooling-levels",
> > -                                      ctx->pwm_fan_cooling_levels, num=
);
> > -     if (ret) {
> > -             dev_err(dev, "Property 'cooling-levels' cannot be read!\n=
");
> > -             return ret;
> > +     if (base_profile) {
> > +             memcpy(ctx->pwm_fan_cooling_levels,
> > +               ctx->fan_profile_cooling_levels[ctx->fan_current_profil=
e],
> > +                                             num);
> > +     } else {
> > +             ret =3D of_property_read_u32_array(np, "cooling-levels",
> > +                             ctx->pwm_fan_cooling_levels, num);
> > +             if (ret) {
> > +                     dev_err(dev, "Property 'cooling-levels' cannot be=
 read!\n");
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       for (i =3D 0; i < num; i++) {
> > @@ -390,6 +458,25 @@ static int pwm_fan_probe(struct platform_device
> *pdev)
> >       return 0;
> >  }
> >
> > +static int pwm_fan_remove(struct platform_device *pdev) {
> > +     struct pwm_fan_ctx *ctx =3D platform_get_drvdata(pdev);
> > +     struct pwm_args args;
> > +
> > +     if (!ctx)
> > +             return -EINVAL;
> > +
> > +     if (IS_ENABLED(CONFIG_THERMAL))
> > +             thermal_cooling_device_unregister(ctx->cdev);
> > +
> > +     pwm_get_args(ctx->pwm, &args);
> > +     pwm_config(ctx->pwm, 0, args.period);
> > +     pwm_disable(ctx->pwm);
>=20
> What is what you really here? Is it only that the PWM stops oscillating, =
or is it
> crucial that the output goes to its inactive level?
>=20
> (The intended semantic of pwm_disable includes that the output goes low, =
but
> not all implementations enforce this.)
>=20
> Also please don't introduce new users of pwm_config() and pwm_disable() u=
se
> pwm_apply() instead.
>=20
> I wonder if this unregistration is "safe". When the driver is in use I'd =
expect that
> the hwmon device doesn't go away and so the devm unregistration callback =
that
> belongs to
> devm_hwmon_device_register_with_groups() blocks. But at this time the PWM
> is already stopped and so the device stops functioning earlier.
>=20
> Best regards
> Uwe
>=20

Thanks for reviewing the changes.

I see that pwm_fan_shutdown() which has got merged recently, can also be us=
ed for
module remove functionality. May be it will need a little bit of tweak in t=
he code.
However I should have not made both multiple profiles support and fan remov=
e functionality on
same patch.

For now I will prepare the current patch only to handle multiple profiles a=
nd corresponding
device tree settings.


Thanks & Regards,
Sandipan

> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
