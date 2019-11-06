From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
Date: Tue, 5 Nov 2019 22:06:57 -0600
Message-ID: <20191106040657.GA5294@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com>
 <20191103110841.3ad3ecfb@archlinux>
 <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Alexandre Torgue <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-iio@vger.kernel.org, u.kleine-koenig@pengutronix.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 11:07:16AM +0100, Benjamin Gaignard wrote:
> Le dim. 3 nov. 2019 à 12:08, Jonathan Cameron <jic23@kernel.org> a écrit :
> >
> > On Thu, 31 Oct 2019 13:30:38 +0100
> > Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> >
> > > Convert the STM32 IIO trigger binding to DT schema format using json-schema
> > >
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > I'm far from great on these as still haven't taken the time I should to learn
> > the yaml syntax properly.  A few comments inline however based mostly on this
> > doesn't quite look like other ones I've seen recently.
> >
> > Thanks,
> >
> > Jonathan
> >
> > > ---
> > >  .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++++++++++++++
> > >  .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ------------
> > >  2 files changed, 44 insertions(+), 25 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > > new file mode 100644
> > > index 000000000000..1c8c8b55e8cd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-trigger.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: STMicroelectronics STM32 Timers IIO timer bindings
> > > +
> > > +maintainers:
> > > +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> > > +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> > > +
> > > +properties:
> > > +  $nodemane:
> >
> > nodename?
> 
> That will be in v2

No, $nodename is correct. The '$' signifies something we generate and 
add in. IOW, not a real property. I guess we could have used 'name' here 
and stuck with traditional OpenFirmware.

> 
> >
> > > +    pattern: "^timer@[0-9]+$"
> > > +    type: object
> > > +
> > > +    description:
> > > +      must be a sub-node of an STM32 Timer device tree node
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        oneOf:
> >
> > enum is I think preferred for these.
> 
> as you like it will be in v2
> 
> >
> > > +          - const: st,stm32-timer-trigger
> > > +          - const: st,stm32h7-timer-trigger
> > > +
> > > +      reg: true
> >
> > Normally some info for what the reg value is..
> I can't put "description" on this field because the syntax doesn't allow it.
> I will add a comment in v2 to explain what reg is.

items:
  - maximum: <max timer number>

Rob
