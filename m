From: "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
Subject: RE: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Date: Wed, 20 May 2020 10:52:29 +0000
Message-ID: <SN6PR11MB25752EA2FF75768D84C14360F6B60@SN6PR11MB2575.namprd11.prod.outlook.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200518142143.GB3594@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:18851 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKwd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 May 2020 06:52:33 -0400
In-Reply-To: <20200518142143.GB3594@bogus>
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Wan Mohamad, Wan Ahmad Zainie" <wan.ahmad.zainie.wan.mohamad@intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, May 18, 2020 10:22 PM
> To: G Jaya Kumaran, Vineetha <vineetha.g.jaya.kumaran@intel.com>
> Cc: thierry.reding@gmail.com; u.kleine-koenig@pengutronix.de; linux-
> pwm@vger.kernel.org; devicetree@vger.kernel.org; Wan Mohamad, Wan
> Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Shevchenko,
> Andriy <andriy.shevchenko@intel.com>
> Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Inte=
l
> Keem Bay PWM
>=20
> On Sun, May 17, 2020 at 09:52:40PM +0800,
> vineetha.g.jaya.kumaran@intel.com wrote:
> > From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> >
> > Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> >
> > Signed-off-by: Vineetha G. Jaya Kumaran
> > <vineetha.g.jaya.kumaran@intel.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39
> ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
>=20
> Use compatible string for filename: intel,keembay-pwn.yaml
>=20

Will fix the filename in v2.

> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > new file mode 100644
> > index 0000000..00968d7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: GPL-2.0
>=20
> Dual license new bindings:
>=20
> (GPL-2.0-only OR BSD-2-Clause)
>=20

OK, will update the licensing info.

> > +# Copyright (C) 2020 Intel Corporation %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel Keem Bay PWM Device Tree Bindings
> > +
> > +maintainers:
> > +  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - intel,keembay-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +        phandle to the reference clock.
>=20
> How many clocks? (maxItems: 1?)
>=20
> You can drop the description.
>=20

1 clock is needed for this case, will add in maxItems and drop the descript=
ion.

> > +
> > +required:
> > + - compatible
> > + - reg
> > + - clocks
> > +
> > +examples:
> > +  - |
> > +    pwm@203200a0 {
> > +      compatible =3D "intel,keembay-pwm";
> > +      reg =3D <0x0 0x203200a0 0x0 0xe8>;
> > +      clocks =3D <&scmi_clk KEEM_BAY_A53_GPIO>;
> > +    };
> > --
> > 1.9.1
> >
