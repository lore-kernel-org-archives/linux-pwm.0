Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:11495
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfLTEAw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Dec 2019 23:00:52 -0500
From: Jeff LaBundy <jeff@labundy.com>
Date: Fri, 20 Dec 2019 04:00:45 +0000
Message-ID: <20191220040042.GB2658@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com>
 <20191218235252.GA19438@bogus>
In-Reply-To: <20191218235252.GA19438@bogus>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9C820E91F18CF43AECB3466A7F63700@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
To: Rob Herring <robh@kernel.org>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>

Hi Rob,

Thank you for your prompt review and your kind words. A couple of questions
and comments for you below.

On Wed, Dec 18, 2019 at 05:52:52PM -0600, Rob Herring wrote:
> On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> > This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> > IQS622, IQS624 and IQS625 multi-function sensors.
> >=20
> > A total of three bindings are presented (one MFD and two child nodes);
> > they are submitted as a single patch because the child node bindings
> > have no meaning in the absence of the MFD binding.
> >=20
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > ---
> > Changes in v2:
> >   - Removed "prox" child node and moved "keys" and "pwm" child nodes to=
 their
> >     own bindings
> >   - Replaced linux,fw-file property with more common firmware-name prop=
erty
> >   - Converted all bindings to YAML
>=20
> Good job for first go.
>=20
> >=20
> >  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++++++=
++
> >  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++++++=
++++++++
> >  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
> >  3 files changed, 333 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys=
.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
> >  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.y=
aml
>=20
> A couple of minor things below. With those fixed:
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.yaml b=
/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > new file mode 100644
> > index 0000000..e9b54e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > @@ -0,0 +1,126 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function=
 sensors
> > +  feature a variety of self-capacitive, mutual-inductive and Hall-effe=
ct sens-
> > +  ing capabilities that can facilitate a variety of contactless key an=
d switch
> > +  applications.
> > +
> > +  These functions are collectively represented by a "keys" child node =
from the
> > +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs62x.=
yaml for
> > +  further details and examples. Sensor hardware configuration (self-ca=
pacitive
> > +  vs. mutual-inductive, etc.) is selected based on the device's firmwa=
re.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a-keys
> > +      - azoteq,iqs621-keys
> > +      - azoteq,iqs622-keys
> > +      - azoteq,iqs624-keys
> > +      - azoteq,iqs625-keys
> > +
> > +  linux,keycodes:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - minItems: 1
> > +        maxItems: 16
> > +    description: |
> > +      Specifies the numeric keycodes associated with each available to=
uch or
> > +      proximity event according to the following table. An 'x' indicat=
es the
> > +      event is supported for a given device. Specify 0 for unused even=
ts.
> > +
> > +      ----------------------------------------------------------------=
---------
> > +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS624 |=
 IQS625 |
> > +      ----------------------------------------------------------------=
---------
> > +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Antenna 1 Touch*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Antenna 1 Prox.*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x   |=
    x   |
> > +      |    | Ant. 1 Deep Touch* |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x   |=
    x   |
> > +      ----------------------------------------------------------------=
---------
> > +      | 4  | CH2 Touch          |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 5  | CH2 Proximity      |    x    |        |        |        |=
        |
> > +      |    | Antenna 2 Prox.*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 6  | Metal (+) Touch**  |    x    |    x   |        |        |=
        |
> > +      |    | Ant. 2 Deep Touch* |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |        |=
        |
> > +      |    | Antenna 2 Touch*   |    x    |        |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 8  | Metal (-) Touch**  |    x    |    x   |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 10 | SAR Active***      |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 12 | SAR Movement***    |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 13 | SAR Filter Halt*** |    x    |        |    x   |        |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 14 | Wheel Up           |         |        |        |    x   |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      | 15 | Wheel Down         |         |        |        |    x   |=
        |
> > +      ----------------------------------------------------------------=
---------
> > +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and proximi=
ty events
> > +          if enabled via firmware.
> > +      **  "+" and "-" refer to the polarity of a channel's delta (LTA =
- counts),
> > +          where "LTA" is defined as the channel's long-term average.
> > +      *** One-channel SAR. Replaces CH0-2 touch and proximity events i=
f enabled
> > +          via firmware.
> > +
> > +required:
> > +  - compatible
> > +  - linux,keycodes
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

When I add this, the dt_binding_check step complains that the hall switch c=
hild nodes
used in the examples are unrecognized, e.g.:

iqs620a@44: keys: 'hall-switch-south' does not match any of the regexes: 'p=
inctrl-[0-9]+'

When I originally encountered this, I found that the mdio-mux child node in=
 [0] seems
to be a similar example and omits additionalProperties, which is why I orig=
inally did
that here. Do you have any advice on how to proceed?

> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - azoteq,iqs620a-keys
> > +          - azoteq,iqs621-keys
> > +          - azoteq,iqs622-keys
> > +then:
> > +  patternProperties:
> > +    "^hall-switch-(north|south)$":
> > +      type: object
> > +      description:
> > +        Represents north/south-field Hall-effect sensor touch or proxi=
mity
> > +        events. Note that north/south-field orientation is reversed on=
 the
> > +        IQS620AXzCSR device due to its flip-chip package.
> > +
> > +      properties:
> > +        linux,code:
> > +          $ref: /schemas/types.yaml#/definitions/uint32
> > +          description: Numeric switch code associated with the event.
> > +
> > +        azoteq,use-prox:
> > +          $ref: /schemas/types.yaml#/definitions/flag
> > +          description:
> > +            If present, specifies that Hall-effect sensor reporting sh=
ould
> > +            use the device's wide-range proximity threshold instead of=
 its
> > +            close-range touch threshold (default).
> > +
> > +      required:
> > +        - linux,code
> > +

Do you think I should specify additionalProperties: false within these chil=
d nodes?

> > +...
> > diff --git a/Documentation/devicetree/bindings/mfd/iqs62x.yaml b/Docume=
ntation/devicetree/bindings/mfd/iqs62x.yaml
> > new file mode 100644
> > index 0000000..24e6004
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/iqs62x.yaml
> > @@ -0,0 +1,177 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/iqs62x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A/621/622/624/625 Multi-Function Sensors
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-function=
 sensors
> > +  integrate multiple sensing technologies in a single package.
> > +
> > +  Link to data sheets: https://www.azoteq.com/
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a
> > +      - azoteq,iqs621
> > +      - azoteq,iqs622
> > +      - azoteq,iqs624
> > +      - azoteq,iqs625
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  firmware-name:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Specifies the name of the calibration and configuration file sel=
ected by
> > +      the driver. If this property is omitted, the name is chosen base=
d on the
> > +      device name with ".bin" as the extension (e.g. iqs620a.bin for I=
QS620A).
> > +
> > +  keys:
> > +    $ref: ../input/iqs62x-keys.yaml
> > +
> > +  pwm:
> > +    $ref: ../pwm/iqs620a-pwm.yaml
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

Sure thing, will do.

> > +
> > +examples:
> > +  - |
> > +    /*
> > +     * Dual capacitive buttons with additional "air button," unipolar =
lid
> > +     * switch and panel-mounted LED.
> > +     */
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs620a@44 {
> > +                    compatible =3D "azoteq,iqs620a";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs620a-keys";
> > +
> > +                            linux,keycodes =3D <KEY_SELECT>,
> > +                                             <KEY_MENU>,
> > +                                             <KEY_OK>,
> > +                                             <KEY_MENU>;
> > +
> > +                            hall-switch-south {
> > +                                    linux,code =3D <SW_LID>;
> > +                                    azoteq,use-prox;
> > +                            };
> > +                    };
> > +
> > +                    iqs620a_pwm: pwm {
> > +                            compatible =3D "azoteq,iqs620a-pwm";
> > +                            #pwm-cells =3D <2>;
> > +                    };
> > +            };
> > +    };
> > +
> > +    pwmleds {
> > +            compatible =3D "pwm-leds";
> > +
> > +            panel {
> > +                    pwms =3D <&iqs620a_pwm 0 1000000>;
> > +                    max-brightness =3D <255>;
> > +            };
> > +    };
> > +
> > +  - |
> > +    /* Single inductive button with bipolar dock/tablet-mode switch. *=
/
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs620a@44 {
> > +                    compatible =3D "azoteq,iqs620a";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    firmware-name =3D "iqs620a_coil.bin";
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs620a-keys";
> > +
> > +                            linux,keycodes =3D <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <KEY_MUTE>;
> > +
> > +                            hall-switch-north {
> > +                                    linux,code =3D <SW_DOCK>;
> > +                            };
> > +
> > +                            hall-switch-south {
> > +                                    linux,code =3D <SW_TABLET_MODE>;
> > +                            };
> > +                    };
> > +            };
> > +    };
> > +
> > +  - |
> > +    /* Dual capacitive buttons with volume knob. */
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            iqs624@44 {
> > +                    compatible =3D "azoteq,iqs624";
> > +                    reg =3D <0x44>;
> > +                    interrupt-parent =3D <&gpio>;
> > +                    interrupts =3D <17 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                    keys {
> > +                            compatible =3D "azoteq,iqs624-keys";
> > +
> > +                            linux,keycodes =3D <BTN_0>,
> > +                                             <0>,
> > +                                             <BTN_1>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <0>,
> > +                                             <KEY_VOLUMEUP>,
> > +                                             <KEY_VOLUMEDOWN>;
> > +                    };
> > +            };
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> > new file mode 100644
> > index 0000000..6b7aaef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/iqs620a-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Azoteq IQS620A PWM Generator
> > +
> > +maintainers:
> > +  - Jeff LaBundy <jeff@labundy.com>
> > +
> > +description: |
> > +  The Azoteq IQS620A multi-function sensor generates a fixed-frequency=
 PWM
> > +  output represented by a "pwm" child node from the parent MFD driver.=
 See
> > +  Documentation/devicetree/bindings/mfd/iqs62x.yaml for further detail=
s as
> > +  well as an example.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - azoteq,iqs620a-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 2
> > +
> > +required:
> > +  - compatible
> > +  - "#pwm-cells"
>=20
> Add:=20
>=20
> additionalProperties: false
>=20

Sure thing, will do.

> > +
> > +...
> > --
> > 2.7.4
> >=20

[0] Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml

Kind regards,
Jeff LaBundy
