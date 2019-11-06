From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to json-schema
Date: Wed, 6 Nov 2019 17:33:05 -0600
Message-ID: <CAL_Jsq+eFew_8ULDOwL5GXUDxLRB9e+b+ZsMdWLKUO8i9Lk7AQ@mail.gmail.com>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-5-benjamin.gaignard@st.com> <20191106041518.GC5294@bogus>
 <41c43d09-9371-8b23-a3dd-e43f5df5c5bc@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41c43d09-9371-8b23-a3dd-e43f5df5c5bc@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Fabrice GASNIER <fabrice.gasnier@st.com>, "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 6, 2019 at 1:57 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 11/6/19 5:15 AM, Rob Herring wrote:
> > On Thu, Oct 31, 2019 at 01:30:40PM +0100, Benjamin Gaignard wrote:
> >> Convert the STM32 timers binding to DT schema format using json-schema
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 91 ++++++++++++++++++++++
> >>   .../devicetree/bindings/mfd/stm32-timers.txt       | 73 -----------------
> >>   2 files changed, 91 insertions(+), 73 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> >>   delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> >> new file mode 100644
> >> index 000000000000..3f0a65fb2bc0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> >> @@ -0,0 +1,91 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: STMicroelectronics STM32 Timers bindings
> >> +
> >> +description: |
> >> +  This hardware block provides 3 types of timer along with PWM functionality: \
> > Don't need the \
> ok
> >
> >> +    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable \
> >> +      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels. \
> >> +    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a \
> >> +      programmable prescaler and PWM outputs.\
> >> +    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
> >> +
> >> +maintainers:
> >> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> >> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> >> +
> >> +allOf:
> >> +  - $ref: "../pwm/st,stm32-pwm.yaml#"
> >> +  - $ref: "../iio/timer/st,stm32-timer-trigger.yaml#"
> >> +  - $ref: "../counter/st,stm32-timer-cnt.yaml#"
> > This works, but I prefer the child node names be listed under properties
> > here with a ref:
> >
> > counter:
> >    $ref: "../counter/st,stm32-timer-cnt.yaml#"
> If I wrote everything in one file I guess what won't be needed anymore
> >
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: st,stm32-timers
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: int
> >> +
> >> +  reset:
> >> +    maxItems: 1
> >> +
> >> +  dmas: true
> > How many?
>
> from 0 up to 8, but I don't know the syntax for that. minItems = 0 isn't
> accepted.
>
> Any hints for me ?

0 is not accepted because the property is never 0 items. 0 is not
present. So just:

minItems: 1
maxItems: 8


> >> +
> >> +  dma-names: true
> > What are the names?
>
> it could be ch1 ... ch8, "trig" or "up" in any order.

Why does it need to be in any order? Normally we don't want to have that.

>
> Again I haven't be able to find a syntax that allow to list the names
> and use them in any orders.

dma-names:
  items:
    enum: [ ch1, ch2, ..., trig, up ]

Rob
