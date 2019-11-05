From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Date: Tue, 5 Nov 2019 11:07:16 +0100
Message-ID: <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com> <20191103110841.3ad3ecfb@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191103110841.3ad3ecfb@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alexandre Torgue <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-iio@vger.kernel.org, u.kleine-koenig@pengutronix.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Le dim. 3 nov. 2019 =C3=A0 12:08, Jonathan Cameron <jic23@kernel.org> a =C3=
=A9crit :
>
> On Thu, 31 Oct 2019 13:30:38 +0100
> Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
>
> > Convert the STM32 IIO trigger binding to DT schema format using json-sc=
hema
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> I'm far from great on these as still haven't taken the time I should to l=
earn
> the yaml syntax properly.  A few comments inline however based mostly on =
this
> doesn't quite look like other ones I've seen recently.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++=
++++++++
> >  .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
> >  2 files changed, 44 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm3=
2-timer-trigger.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-t=
imer-trigger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer=
-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-=
trigger.yaml
> > new file mode 100644
> > index 000000000000..1c8c8b55e8cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigge=
r.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: STMicroelectronics STM32 Timers IIO timer bindings
> > +
> > +maintainers:
> > +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> > +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> > +
> > +properties:
> > +  $nodemane:
>
> nodename?

That will be in v2

>
> > +    pattern: "^timer@[0-9]+$"
> > +    type: object
> > +
> > +    description:
> > +      must be a sub-node of an STM32 Timer device tree node
> > +
> > +    properties:
> > +      compatible:
> > +        oneOf:
>
> enum is I think preferred for these.

as you like it will be in v2

>
> > +          - const: st,stm32-timer-trigger
> > +          - const: st,stm32h7-timer-trigger
> > +
> > +      reg: true
>
> Normally some info for what the reg value is..
I can't put "description" on this field because the syntax doesn't allow it=
.
I will add a comment in v2 to explain what reg is.

Thanks for your review.
Benjamin
>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +examples:
> > +  - |
> > +    timers2: timer@40000000 {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      timer@0 {
> > +        compatible =3D "st,stm32-timer-trigger";
> > +        reg =3D <0>;
> > +      };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-tr=
igger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger=
.txt
> > deleted file mode 100644
> > index b8e8c769d434..000000000000
> > --- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.t=
xt
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -STMicroelectronics STM32 Timers IIO timer bindings
> > -
> > -Must be a sub-node of an STM32 Timers device tree node.
> > -See ../mfd/stm32-timers.txt for details about the parent node.
> > -
> > -Required parameters:
> > -- compatible:        Must be one of:
> > -             "st,stm32-timer-trigger"
> > -             "st,stm32h7-timer-trigger"
> > -- reg:               Identify trigger hardware block.
> > -
> > -Example:
> > -     timers@40010000 {
> > -             #address-cells =3D <1>;
> > -             #size-cells =3D <0>;
> > -             compatible =3D "st,stm32-timers";
> > -             reg =3D <0x40010000 0x400>;
> > -             clocks =3D <&rcc 0 160>;
> > -             clock-names =3D "int";
> > -
> > -             timer@0 {
> > -                     compatible =3D "st,stm32-timer-trigger";
> > -                     reg =3D <0>;
> > -             };
> > -     };
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
