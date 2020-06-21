From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [RFC PATCH 05/10] dt-bindings: pwm: Add bindings for PWM
 function in Netronix EC
Date: Sun, 21 Jun 2020 20:41:23 +0200
Message-ID: <20200621204123.6c761d98@aktux>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
        <20200620224222.1312520-4-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200620224222.1312520-4-j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.chen-4K37Az1KcQBeoWH0uzbU5w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020 00:42:16 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org> wrote:

> The Netronix embedded controller as found in Kobo Aura and Tolino Shine
> supports one PWM channel, which is used to control the frontlight
> brightness on these devices.
>=20
> Known problems:
> - `make dt_binding_check` shows the following warnings:
>   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-=
42:
>   Warning (pwms_property): /example-0/backlight:pwms: cell 2 is not a
>   phandle reference
>   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.17-=
42:
>   Warning (pwms_property): /example-0/backlight:pwms: Could not get
>   phandle node for (cell 2)
>=20
In the tolino sources in ./drivers/misc/ntx-misc.c I find this line

        if(4=3D=3DgptHWCFG->m_val.bFL_PWM) {

No idea what it does but I would expect to have a kind of translation to
a dt property?

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> ---
>  .../bindings/mfd/netronix,ntxec.yaml          | 13 ++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.yaml      | 33 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-=
pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml b/=
Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> index 596df460f98eb..6562c41c5a9a9 100644
> --- a/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> @@ -31,6 +31,9 @@ properties:
>      description:
>        The EC can signal interrupts via a GPIO line
>=20
> +  pwm:
> +    $ref: ../pwm/netronix,ntxec-pwm.yaml
> +
>  required:
>    - compatible
>    - reg
> @@ -53,5 +56,15 @@ examples:
>                      interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
>                      interrupt-controller;
>                      #interrupt-cells =3D <1>;
> +
> +                    ec_pwm: pwm {
> +                            compatible =3D "netronix,ntxec-pwm";
> +                            #pwm-cells =3D <1>;
shouldn't that be 2?
> +                    };
>              };
>      };
> +
> +    backlight {
> +            compatible =3D "pwm-backlight";
> +            pwms =3D <&ec_pwm 0 50000>;
since you have 2 values after the &ec_pwm=20

> +    };
> diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> new file mode 100644
> index 0000000000000..1dc1b1aba081c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/netronix,ntxec-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM functionality in Netronix embedded controller
> +
> +maintainers:
> +  - Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> +
> +description: |
> +  See also Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
> +
> +  The Netronix EC contains PWM functionality, which is usually used to d=
rive
> +  the backlight LED.
> +
> +  The following PWM channels are supported:
> +    - 0: The PWM channel controlled by registers 0xa1-0xa7
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: netronix,ntxec-pwm
> +
> +  "#pwm-cells":
> +    const: 1

shouln't that be 2?
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> --
> 2.27.0
>=20
>=20

Regards,
Andreas
