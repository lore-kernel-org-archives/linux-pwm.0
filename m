Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:20804
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbgAAVcs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Jan 2020 16:32:48 -0500
From: Jeff LaBundy <jeff@labundy.com>
Date: Wed, 1 Jan 2020 21:32:38 +0000
Message-ID: <20200101213228.GA14339@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
 <1575851866-18919-2-git-send-email-jeff@labundy.com>
 <20191218235252.GA19438@bogus> <20191220040042.GB2658@labundy.com>
 <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eXQKSExm+HU+3iY=zryj-KgfNbJ7sGd=OWQbQ3sn-yg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A89DA2269B1C349B527022C2F02D6BB@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
To: Rob Herring <robh@kernel.org>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>

Hi Rob,

On Tue, Dec 24, 2019 at 02:55:41PM -0700, Rob Herring wrote:
> On Thu, Dec 19, 2019 at 9:00 PM Jeff LaBundy <jeff@labundy.com> wrote:
> >
> > Hi Rob,
> >
> > Thank you for your prompt review and your kind words. A couple of quest=
ions
> > and comments for you below.
> >
> > On Wed, Dec 18, 2019 at 05:52:52PM -0600, Rob Herring wrote:
> > > On Mon, Dec 09, 2019 at 12:38:32AM +0000, Jeff LaBundy wrote:
> > > > This patch adds device tree bindings for the Azoteq IQS620A, IQS621=
,
> > > > IQS622, IQS624 and IQS625 multi-function sensors.
> > > >
> > > > A total of three bindings are presented (one MFD and two child node=
s);
> > > > they are submitted as a single patch because the child node binding=
s
> > > > have no meaning in the absence of the MFD binding.
> > > >
> > > > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Removed "prox" child node and moved "keys" and "pwm" child node=
s to their
> > > >     own bindings
> > > >   - Replaced linux,fw-file property with more common firmware-name =
property
> > > >   - Converted all bindings to YAML
> > >
> > > Good job for first go.
> > >
> > > >
> > > >  .../devicetree/bindings/input/iqs62x-keys.yaml     | 126 +++++++++=
++++++
> > > >  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 177 +++++++++=
++++++++++++
> > > >  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  30 ++++
> > > >  3 files changed, 333 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-=
keys.yaml
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.ya=
ml
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-p=
wm.yaml
> > >
> > > A couple of minor things below. With those fixed:
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/input/iqs62x-keys.ya=
ml b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > > new file mode 100644
> > > > index 0000000..e9b54e0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/input/iqs62x-keys.yaml
> > > > @@ -0,0 +1,126 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/input/iqs62x-keys.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Azoteq IQS620A/621/622/624/625 Keys and Switches
> > > > +
> > > > +maintainers:
> > > > +  - Jeff LaBundy <jeff@labundy.com>
> > > > +
> > > > +description: |
> > > > +  The Azoteq IQS620A, IQS621, IQS622, IQS624 and IQS625 multi-func=
tion sensors
> > > > +  feature a variety of self-capacitive, mutual-inductive and Hall-=
effect sens-
> > > > +  ing capabilities that can facilitate a variety of contactless ke=
y and switch
> > > > +  applications.
> > > > +
> > > > +  These functions are collectively represented by a "keys" child n=
ode from the
> > > > +  parent MFD driver. See Documentation/devicetree/bindings/mfd/iqs=
62x.yaml for
> > > > +  further details and examples. Sensor hardware configuration (sel=
f-capacitive
> > > > +  vs. mutual-inductive, etc.) is selected based on the device's fi=
rmware.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - azoteq,iqs620a-keys
> > > > +      - azoteq,iqs621-keys
> > > > +      - azoteq,iqs622-keys
> > > > +      - azoteq,iqs624-keys
> > > > +      - azoteq,iqs625-keys
> > > > +
> > > > +  linux,keycodes:
> > > > +    allOf:
> > > > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +      - minItems: 1
> > > > +        maxItems: 16
> > > > +    description: |
> > > > +      Specifies the numeric keycodes associated with each availabl=
e touch or
> > > > +      proximity event according to the following table. An 'x' ind=
icates the
> > > > +      event is supported for a given device. Specify 0 for unused =
events.
> > > > +
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | #  | Event              | IQS620A | IQS621 | IQS622 | IQS6=
24 | IQS625 |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 0  | CH0 Touch          |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Antenna 1 Touch*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 1  | CH0 Proximity      |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Antenna 1 Prox.*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 2  | CH1 Touch          |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      |    | Ant. 1 Deep Touch* |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 3  | CH1 Proximity      |    x    |    x   |    x   |    x=
   |    x   |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 4  | CH2 Touch          |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 5  | CH2 Proximity      |    x    |        |        |     =
   |        |
> > > > +      |    | Antenna 2 Prox.*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 6  | Metal (+) Touch**  |    x    |    x   |        |     =
   |        |
> > > > +      |    | Ant. 2 Deep Touch* |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 7  | Metal (+) Prox.**  |    x    |    x   |        |     =
   |        |
> > > > +      |    | Antenna 2 Touch*   |    x    |        |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 8  | Metal (-) Touch**  |    x    |    x   |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 9  | Metal (-) Prox.**  |    x    |    x   |        |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 10 | SAR Active***      |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 11 | SAR Quick Rel.***  |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 12 | SAR Movement***    |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 13 | SAR Filter Halt*** |    x    |        |    x   |     =
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 14 | Wheel Up           |         |        |        |    x=
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      | 15 | Wheel Down         |         |        |        |    x=
   |        |
> > > > +      ------------------------------------------------------------=
-------------
> > > > +      *   Two-channel SAR. Replaces CH0-2 plus metal touch and pro=
ximity events
> > > > +          if enabled via firmware.
> > > > +      **  "+" and "-" refer to the polarity of a channel's delta (=
LTA - counts),
> > > > +          where "LTA" is defined as the channel's long-term averag=
e.
> > > > +      *** One-channel SAR. Replaces CH0-2 touch and proximity even=
ts if enabled
> > > > +          via firmware.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - linux,keycodes
> > >
> > > Add:
> > >
> > > additionalProperties: false
> > >
> >
> > When I add this, the dt_binding_check step complains that the hall swit=
ch child nodes
> > used in the examples are unrecognized, e.g.:
> >
> > iqs620a@44: keys: 'hall-switch-south' does not match any of the regexes=
: 'pinctrl-[0-9]+'
> >
> > When I originally encountered this, I found that the mdio-mux child nod=
e in [0] seems
> > to be a similar example and omits additionalProperties, which is why I =
originally did
> > that here. Do you have any advice on how to proceed?
>=20
> That's because the properties are under an if/then. Your options are
> split the schema into 2 files to eliminate the if/then or just define
> "^hall-switch-(north|south)$" with just 'true' outside the if/then. A
> variation on the 2nd option is invert the if/then and make the schema
> false. Then the 'main' schema defines the full superset of properties
> and the if/then just filters out ones that don't apply in some cases.
>=20

Thank you for this detailed explanation; it all makes sense now. For v3
I've opted for the variant of option (2) because it allows for a single
binding as I originally intended, and prompts dt_binding_check to throw
an error if a dts author mistakenly defines the hall-switch-north/south
nodes within either of the two devices that don't support that feature.
I also find it simpler and more intuitive.

> >
> > > > +
> > > > +if:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        enum:
> > > > +          - azoteq,iqs620a-keys
> > > > +          - azoteq,iqs621-keys
> > > > +          - azoteq,iqs622-keys
> > > > +then:
> > > > +  patternProperties:
> > > > +    "^hall-switch-(north|south)$":
> > > > +      type: object
> > > > +      description:
> > > > +        Represents north/south-field Hall-effect sensor touch or p=
roximity
> > > > +        events. Note that north/south-field orientation is reverse=
d on the
> > > > +        IQS620AXzCSR device due to its flip-chip package.
> > > > +
> > > > +      properties:
> > > > +        linux,code:
> > > > +          $ref: /schemas/types.yaml#/definitions/uint32
> > > > +          description: Numeric switch code associated with the eve=
nt.
> > > > +
> > > > +        azoteq,use-prox:
> > > > +          $ref: /schemas/types.yaml#/definitions/flag
> > > > +          description:
> > > > +            If present, specifies that Hall-effect sensor reportin=
g should
> > > > +            use the device's wide-range proximity threshold instea=
d of its
> > > > +            close-range touch threshold (default).
> > > > +
> > > > +      required:
> > > > +        - linux,code
> > > > +
> >
> > Do you think I should specify additionalProperties: false within these =
child nodes?
>=20
> Yes.

Sure thing, will do.

FYI, since these additional changes are quite small and I believe I've
implemented them exactly as you've suggested, I plan on retaining your
Reviewed-by for v3 which I'll be sending out soon. However if you find
that I have misinterpreted anything, please let me know and I will fix
it promptly.

Wishing you a Happy New Year,
Jeff LaBundy
