From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg' warning
Date: Wed, 15 Apr 2020 15:35:46 -0500
Message-ID: <CAL_JsqJs1mvJU53RFsv0PeGkzaX0xdryrqBA1SWm5Ka_a8uJ=Q@mail.gmail.com>
References: <20200415182639.18534-1-robh@kernel.org> <20200415192928.tjmh2m6a63lmnp3b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200415192928.tjmh2m6a63lmnp3b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 15, 2020 at 2:29 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
> Hello Rob,
>
> On Wed, Apr 15, 2020 at 01:26:39PM -0500, Rob Herring wrote:
> > The example for the CrOS EC PWM is incomplete and now generates a dtc
> > warning:
> >
> > Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dts:17=
.11-23.11:
> > Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit na=
me, but no reg or ranges property
> >
> > Fixing this results in more warnings as a parent spi node is needed as
> > well.
> >
> > Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > Cc: Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >  .../bindings/pwm/google,cros-ec-pwm.yaml        | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > index 24c217b76580..41ece1d85315 100644
> > --- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
> > @@ -31,10 +31,17 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > -    cros-ec@0 {
> > -        compatible =3D "google,cros-ec-spi";
> > -        cros_ec_pwm: ec-pwm {
> > -            compatible =3D "google,cros-ec-pwm";
> > -            #pwm-cells =3D <1>;
> > +    spi {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        cros-ec@0 {
> > +            compatible =3D "google,cros-ec-spi";
> > +            reg =3D <0>;
> > +
> > +            cros_ec_pwm: ec-pwm {
> > +                compatible =3D "google,cros-ec-pwm";
> > +                #pwm-cells =3D <1>;
> > +            };
>
> Looks reasonable
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks.

> Is this supposed to go via the pwm tree, or do you apply yourself via a
> device-tree tree?

I'll take it for rc2.

Rob
