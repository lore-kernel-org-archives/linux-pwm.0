Return-Path: <fabrizio.castro@bp.renesas.com>
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v3 4/5] dt-bindings: pwm: renesas-tpu: Document r8a774[35]
 support
Date: Tue, 6 Mar 2018 16:52:18 +0000
Message-ID: <TY1PR01MB17708BAE34E36EEC33F06E72C0D90@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1513690500-12165-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513690500-12165-5-git-send-email-fabrizio.castro@bp.renesas.com>
 <SG2PR06MB088652C92964C6FE6959EF1FC0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB088652C92964C6FE6959EF1FC0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "Chris Paterson  <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Dear All,

same thing for this one, can someone take this patch?

Thanks,
Fab

> -----Original Message-----
> From: Fabrizio Castro
> Sent: 24 January 2018 17:17
> To: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org; devicetree@vger.kernel.org; Simon Horman <=
horms@verge.net.au>; Geert Uytterhoeven
> <geert+renesas@glider.be>; Chris Paterson <Chris.Paterson2@renesas.com>; =
Biju Das <biju.das@bp.renesas.com>; linux-renesas-
> soc@vger.kernel.org; Fabrizio Castro <fabrizio.castro@bp.renesas.com>; Ma=
rk Rutland <mark.rutland@arm.com>; Rob Herring
> <robh+dt@kernel.org>
> Subject: RE: [PATCH v3 4/5] dt-bindings: pwm: renesas-tpu: Document r8a77=
4[35] support
>
> Hello Thierry,
>
> I am sorry to bother you,  just wondering if this patch has any chance to=
 end up in v4.16?
>
> Thanks,
> Fabrizio
>
> > Subject: [PATCH v3 4/5] dt-bindings: pwm: renesas-tpu: Document r8a774[=
35] support
> >
> > Document r8a774[35] specific compatible strings. No driver change is
> > needed as the fallback compatible string "renesas,tpu" activates the
> > right code in the driver.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v2->v3:
> > * No change
> >
> >  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > index 1aadc80..16e5748 100644
> > --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > @@ -5,8 +5,10 @@ Required Properties:
> >    - compatible: should be one of the following.
> >      - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PW=
M controller.
> >      - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM =
controller.
> > +    - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM contr=
oller.
> > +    - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM contr=
oller.
> >      - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM con=
troller.
> > -    - "renesas,tpu": for generic R-Car TPU PWM controller.
> > +    - "renesas,tpu": for generic R-Car and RZ/G1 TPU PWM controller.
> >
> >    - reg: Base address and length of each memory resource used by the P=
WM
> >      controller hardware module.
> > --
> > 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
