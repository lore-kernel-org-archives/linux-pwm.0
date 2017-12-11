From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 13:13:06 +0100
Message-ID: <20171211121306.GK10671@ulmo>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo>
 <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo>
 <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:46469 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdLKMNK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 07:13:10 -0500
Received: by mail-qt0-f175.google.com with SMTP id r39so37732759qtr.13
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 04:13:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DiOx5m1Wew9v5xaqgbcNDR7gio93EKP48bdM3kaqfkoA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 08:54:19AM -0200, Fabio Estevam wrote:
> Hi Thierry,
>=20
> On Mon, Dec 11, 2017 at 7:16 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
>=20
> > How does it break? Note that you have to change the polarity of the PWM
> > signal (in the pwms property) and then remove the "active-low" property
> > from the leds device tree node to avoid double inversion.
>=20
> This is what I tried as per your suggestion:
>=20
> --- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
> @@ -42,6 +42,7 @@
>  #include "imx6qdl-microsom-ar8035.dtsi"
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pwm/pwm.h>
>=20
>  / {
>         ir_recv: ir-receiver {
> @@ -57,10 +58,9 @@
>                 pinctrl-0 =3D <&pinctrl_cubox_i_pwm1>;
>=20
>                 front {
> -                       active-low;
>                         label =3D "imx6:red:front";
>                         max-brightness =3D <248>;
> -                       pwms =3D <&pwm1 0 50000>;
> +                       pwms =3D <&pwm1 0 50000 PWM_POLARITY_INVERTED>;
>                 };
>         };
>=20
> @@ -231,6 +231,7 @@
>  };
>=20
>  &pwm1 {
> +       #pwm-cells =3D <3>;
>         status =3D "okay";
>  };
>=20
> The problem I see is that it seems to be an off-by-one calculation in
> the pwm-imx driver for the inverted polarity case.
>=20
> For example:
>=20
> # cd /sys/class/leds/imx6\:red\:front/
> # echo 0 > brightness (This keeps the LED on with its maximum brightness)
> # echo 1 > brightness (This keeps the LED off)
> # echo 248 > brightness (This keeps the LED on with its maximum brightnes=
s)
>=20
> When I go to suspend:
>=20
> # echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> # echo mem > /sys/power/state
>=20
> Then LED goes on with its maximum brightness.
>=20
> So the issue now is that I need to tell the pwm-imx driver that '0'
> means to turn the LED off.

Yeah, my suggestion was to make setting the STOPEN bit dependent on the
polarity inversion setting of the PWM. That way you don't have to hard-
code it, which might not be the correct setting for non-inverted PWMs.

Thierry

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloudlIACgkQ3SOs138+
s6GiVxAAua7SMtBZfR66MiKgjXZdEYrpDjSPLVHUbIUPHpszSk7y5V0c0e/Amt8Y
7VqR48iK5+Kpuk8Ue0Dlfz9ISOYFTS3x8PStomLsB0JGDTafb2MCqIdo25kCa/ND
vz/ueWxGYFTx/uhajH2weca1k80Gz2q3uCmhI0EIz8/tWC0mya8CAh63ipS4jDmi
3cRv5XEP6Y3fIz+09kLCkfo4agTng2f7UtOLyC/+209hoC+hNLDYBxrKHXoTJjU7
Xf0QbDvYl+zoWP7HEHR1fklmJ9rxYsHzMQnjM9n0ICnJIDhNwimM3uq2/+a3ZJ1M
fAJucbSQVaDFItqBtsfBYf8wvmlubhcK4UNOnXYN1CvZSrhk6YOr6xDH6aTUCcCw
V8hQmGqlMZtd9/ts3wjuZg3J01yBS4lTqOeESpS2LpSc2G4ho5nB8ZLer0ldOqN6
x0w6vu1h+4Xc1ibPLL784GoFOvQ6LkuNziad9B+gaasfiupvWb7XKIKB2LY1niC6
MGhEg/QE+neW4g0g7fmeDff7vzicZA2XLQUv8JoxBc2Owag1JgdFnEttlAdxKZnm
W+WKYeFqeLK5rvtrvgzQcbgc7n3U5w6SmqbljlCaY309Lb4VkSHzEwhkn2juA1wO
Ki6HX8gIYKGAemVSU10LsdgYqdjbZE9qPLS95CEoljfWGGt8RJQ=
=MehS
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
