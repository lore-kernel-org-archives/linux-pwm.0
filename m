Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:37404 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeKEVaj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 5 Nov 2018 16:30:39 -0500
Date: Mon, 5 Nov 2018 13:11:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <20181105121110.GM24212@piout.net>
References: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52F917CEA1B9C64C94833D53889D478C01AA4F33@dor-sms-xch01.digi.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: MFD with multiple PWM chips
To: "Palacios, Hector" <Hector.Palacios@digi.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "Perez, Pedro" <Pedro.Perez@digi.com>, "broonie@kernel.org" <broonie@kernel.org>

Hello Hector,

I'm not sure why I'm in cc but here is my 2 cents:

On 05/11/2018 11:50:12+0000, Palacios, Hector wrote:
> Hello,
>=20
> I have an MFD device connected via I2C. This chip has several PWM control=
lers, each one containing a number of PWM channels.
>=20
> The device tree looks like this:
>=20
> &i2c0 {
> 	mca@63 {
> 		...
> 		mca_pwm {
> 			compatible =3D "digi,mca-pwm";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <0>;
>=20

Why don't you simply have

pwm-channels =3D <10>;
#pwm-cells =3D <2>;

at this position?

The child nodes don't seems that necessary to me, especially since you
have to handle everything from a single driver anyway.

> 			mca_pwm0: pwm@0 {
> 				reg =3D <0>;
> 				pwm-channels =3D <6>;
> 				#pwm-cells =3D <2>;
> 			};
>=20
> 			mca_pwm1: pwm@1 {
> 				reg =3D <1>;
> 				pwm-channels =3D <2>;
> 				#pwm-cells =3D <2>;
> 			};
>=20
> 			mca_pwm2: pwm@2 {
> 				reg =3D <2>;
> 				pwm-channels =3D <2>;
> 				#pwm-cells =3D <2>;
> 			};
> 		};
>=20
> Being an MFD driver, the PWM driver is only probed once for the node "pwm=
s".
> I can iterate through the children, initialize them and add the PWM chips=
 with 'pwmchip_add()'. This works and I can then request and use the differ=
ent channels via the sysfs on each of the three controllers.
>=20
> The problem comes when another driver wants to use a PWM, for example:
>=20
> 	backlight {
> 		compatible =3D "pwm-backlight";
> 		pwms =3D <&mca_pwm2 0 50000>;
> 		brightness-levels =3D <0 4 8 16 32 64 128 255>;
> 		default-brightness-level =3D <6>;
> 		status =3D "okay";
> 	};
>=20
> This doesn't won't work because the PWM framework only knows about the "p=
wms" node (which is the parent of my PWM chips in the DT), so the call 'of_=
pwm_get()' returns with "PWM chip not found".
> I guess it is not common to have several PWM chips inside a single contro=
ller and that is why the framework doesn't support it. Other subsystems, li=
ke the regulators, do support declaring them as children, but not the PWM.
>=20
> What would be the best approach to support it?
> A patch like this makes it work but I guess it's not ideal:
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 172ef8245811..f4a4cbdda0b2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -627,6 +627,29 @@ static struct pwm_chip *of_node_to_pwmchip(struct de=
vice_node *np)
>         return ERR_PTR(-EPROBE_DEFER);
>  }
> =20
> +static struct pwm_chip *of_subnode_to_pwmchip(struct device_node *np)
> +{
> +       struct pwm_chip *chip;
> +       struct device_node *node;
> +
> +       mutex_lock(&pwm_lock);
> +
> +       list_for_each_entry(chip, &pwm_chips, list) {
> +               if (chip->dev && chip->dev->of_node) {
> +                       for_each_child_of_node(chip->dev->of_node, node) {
> +                               if (node =3D=3D np) {
> +                                       mutex_unlock(&pwm_lock);
> +                                       return chip;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       mutex_unlock(&pwm_lock);
> +
> +       return ERR_PTR(-EPROBE_DEFER);
> +}
> +
>  /**
>   * of_pwm_get() - request a PWM via the PWM framework
>   * @np: device node to get the PWM from
> @@ -669,9 +692,17 @@ struct pwm_device *of_pwm_get(struct device_node *np=
, const char *con_id)
> =20
>         pc =3D of_node_to_pwmchip(args.np);
>         if (IS_ERR(pc)) {
> -               pr_debug("%s(): PWM chip not found\n", __func__);
> -               pwm =3D ERR_CAST(pc);
> -               goto put;
> +               /*
> +                * Check the subnodes of the device before returning with=
 error,
> +                * just in case it is a device with multiple pwmchips def=
ined as
> +                * subnodes.
> +                */
> +               pc =3D of_subnode_to_pwmchip(args.np);
> +               if (IS_ERR(pc)) {
> +                       pr_debug("%s(): PWM chip not found\n", __func__);
> +                       pwm =3D ERR_CAST(pc);
> +                       goto put;
> +               }
>         }
> =20
>         if (args.args_count !=3D pc->of_pwm_n_cells) {
>=20
> Thanks,
> --
> H=E9ctor Palacios
>=20
>=20

--=20
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
