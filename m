Return-Path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Tue, 6 Mar 2018 16:49:54 +0000
Message-ID: <TY1PR01MB1770084635548C8981CF8C83C0D90@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1513768543-7943-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <SG2PR06MB0886D203D3F529D4AD3B07B6C0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB0886D203D3F529D4AD3B07B6C0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Chris Paterson  <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Dear All,

I am very sorry to bother you, just wondering if someone can take this patc=
h?

Thanks,
Fab

> -----Original Message-----
> From: Fabrizio Castro
> Sent: 24 January 2018 17:14
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; Simon Horman <=
horms@verge.net.au>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>; =
Biju Das <biju.das@bp.renesas.com>; linux-renesas-
> soc@vger.kernel.org; Fabrizio Castro <fabrizio.castro@bp.renesas.com>; Ro=
b Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>
> Subject: RE: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM b=
indings
>
> Hello Thierry,
>
> I am sorry to bother you,  just wondering if this patch has any chance to=
 end up in v4.16?
>
> Thanks,
> Fabrizio
>
> > Subject: [PATCH v4] dt-bindings: pwm: rcar: Document r8a774[35] PWM bin=
dings
> >
> > This patch adds compatible strings specific to r8a774[35], no driver
> > change is needed as the fallback compatible string will activate the
> > right code.
> >
> > Also, this patch replaces the example with a DT snippet used
> > for adding PWM0 support to an r8a7743 based platform as the r8a7743 is
> > now the first platform fully compatible with this driver and its PWM DT
> > nodes refer to up-to-date code.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v3->v4:
> > * The changelog now explains why the patch is replacing the example.
> >
> >  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 10 ++++++=
+---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> > b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> > index 74c1180..f3bba59 100644
> > --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> > @@ -2,6 +2,8 @@
> >
> >  Required Properties:
> >  - compatible: should be "renesas,pwm-rcar" and one of the following.
> > + - "renesas,pwm-r8a7743": for RZ/G1M
> > + - "renesas,pwm-r8a7745": for RZ/G1E
> >   - "renesas,pwm-r8a7778": for R-Car M1A
> >   - "renesas,pwm-r8a7779": for R-Car H1
> >   - "renesas,pwm-r8a7790": for R-Car H2
> > @@ -17,13 +19,15 @@ Required Properties:
> >  - pinctrl-0: phandle, referring to a default pin configuration node.
> >  - pinctrl-names: Set to "default".
> >
> > -Example: R8A7790 (R-Car H2) PWM Timer node
> > +Example: R8A7743 (RZ/G1M) PWM Timer node
> >
> >  pwm0: pwm@e6e30000 {
> > -compatible =3D "renesas,pwm-r8a7790", "renesas,pwm-rcar";
> > +compatible =3D "renesas,pwm-r8a7743", "renesas,pwm-rcar";
> >  reg =3D <0 0xe6e30000 0 0x8>;
> > +clocks =3D <&cpg CPG_MOD 523>;
> > +power-domains =3D <&sysc R8A7743_PD_ALWAYS_ON>;
> > +resets =3D <&cpg 523>;
> >  #pwm-cells =3D <2>;
> > -clocks =3D <&mstp5_clks R8A7790_CLK_PWM>;
> >  pinctrl-0 =3D <&pwm0_pins>;
> >  pinctrl-names =3D "default";
> >  };
> > --
> > 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
