From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: RE: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Wed, 24 Jan 2018 17:14:25 +0000
Message-ID: <SG2PR06MB0886D203D3F529D4AD3B07B6C0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
References: <1513768543-7943-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513768543-7943-1-git-send-email-fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

I am sorry to bother you,  just wondering if this patch has any chance to e=
nd up in v4.16?

Thanks,
Fabrizio

> Subject: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM bindi=
ngs
>
> This patch adds compatible strings specific to r8a774[35], no driver
> change is needed as the fallback compatible string will activate the
> right code.
>
> Also, this patch replaces the example with a DT snippet used
> for adding PWM0 support to an r8a7743 based platform as the r8a7743 is
> now the first platform fully compatible with this driver and its PWM DT
> nodes refer to up-to-date code.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> Reviewed-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v3->v4:
> * The changelog now explains why the patch is replacing the example.
>
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 10 +++++++-=
--
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> index 74c1180..f3bba59 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -2,6 +2,8 @@
>
>  Required Properties:
>  - compatible: should be "renesas,pwm-rcar" and one of the following.
> + - "renesas,pwm-r8a7743": for RZ/G1M
> + - "renesas,pwm-r8a7745": for RZ/G1E
>   - "renesas,pwm-r8a7778": for R-Car M1A
>   - "renesas,pwm-r8a7779": for R-Car H1
>   - "renesas,pwm-r8a7790": for R-Car H2
> @@ -17,13 +19,15 @@ Required Properties:
>  - pinctrl-0: phandle, referring to a default pin configuration node.
>  - pinctrl-names: Set to "default".
>
> -Example: R8A7790 (R-Car H2) PWM Timer node
> +Example: R8A7743 (RZ/G1M) PWM Timer node
>
>  pwm0: pwm@e6e30000 {
> -compatible =3D "renesas,pwm-r8a7790", "renesas,pwm-rcar";
> +compatible =3D "renesas,pwm-r8a7743", "renesas,pwm-rcar";
>  reg =3D <0 0xe6e30000 0 0x8>;
> +clocks =3D <&cpg CPG_MOD 523>;
> +power-domains =3D <&sysc R8A7743_PD_ALWAYS_ON>;
> +resets =3D <&cpg 523>;
>  #pwm-cells =3D <2>;
> -clocks =3D <&mstp5_clks R8A7790_CLK_PWM>;
>  pinctrl-0 =3D <&pwm0_pins>;
>  pinctrl-names =3D "default";
>  };
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
