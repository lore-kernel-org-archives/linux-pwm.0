From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: Convert PWM bindings to json-schema
Date: Tue, 10 Sep 2019 10:43:49 +0200
Message-ID: <CAJKOXPf2b5QsNWq_7D0tyXuEcp93F_CsxEkAze_oV8Z07oNJXA@mail.gmail.com>
References: <20190909183436.9045-1-krzk@kernel.org> <CAL_JsqJpZ-64Y7p1w5ctMwbjdftQPLjeh3XRHkBeS6tfYY0a+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJpZ-64Y7p1w5ctMwbjdftQPLjeh3XRHkBeS6tfYY0a+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Linux PWM List <linux-pwm@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maciej Falkowski <m.falkowski@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, 10 Sep 2019 at 10:33, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Sep 9, 2019 at 7:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Convert generic PWM bindings to DT schema format using json-schema.  The
> > consumer bindings are split to separate file.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/clock/pwm-clock.txt   |  2 +-
> >  .../bindings/display/bridge/ti,sn65dsi86.txt  |  2 +-
> >  .../devicetree/bindings/display/ssd1307fb.txt |  2 +-
> >  .../bindings/leds/backlight/pwm-backlight.txt |  2 +-
> >  .../devicetree/bindings/leds/leds-pwm.txt     |  2 +-
> >  .../devicetree/bindings/mfd/max77693.txt      |  2 +-
> >  .../bindings/pwm/atmel-hlcdc-pwm.txt          |  2 +-
> >  .../devicetree/bindings/pwm/atmel-pwm.txt     |  2 +-
> >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt |  2 +-
> >  .../bindings/pwm/brcm,bcm7038-pwm.txt         |  2 +-
> >  .../bindings/pwm/brcm,iproc-pwm.txt           |  2 +-
> >  .../devicetree/bindings/pwm/brcm,kona-pwm.txt |  2 +-
> >  .../devicetree/bindings/pwm/img-pwm.txt       |  2 +-
> >  .../devicetree/bindings/pwm/imx-pwm.txt       |  2 +-
> >  .../devicetree/bindings/pwm/imx-tpm-pwm.txt   |  2 +-
> >  .../bindings/pwm/lpc1850-sct-pwm.txt          |  2 +-
> >  .../devicetree/bindings/pwm/mxs-pwm.txt       |  2 +-
> >  .../bindings/pwm/nvidia,tegra20-pwm.txt       |  2 +-
> >  .../bindings/pwm/nxp,pca9685-pwm.txt          |  2 +-
> >  .../devicetree/bindings/pwm/pwm-bcm2835.txt   |  2 +-
> >  .../devicetree/bindings/pwm/pwm-berlin.txt    |  2 +-
> >  .../bindings/pwm/pwm-consumers.yaml           | 76 +++++++++++++++++++
> >  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt   |  2 +-
> >  .../devicetree/bindings/pwm/pwm-hibvt.txt     |  2 +-
> >  .../devicetree/bindings/pwm/pwm-lp3943.txt    |  2 +-
> >  .../devicetree/bindings/pwm/pwm-mediatek.txt  |  2 +-
> >  .../devicetree/bindings/pwm/pwm-meson.txt     |  2 +-
> >  .../devicetree/bindings/pwm/pwm-mtk-disp.txt  |  2 +-
> >  .../bindings/pwm/pwm-omap-dmtimer.txt         |  2 +-
> >  .../devicetree/bindings/pwm/pwm-rockchip.txt  |  2 +-
> >  .../devicetree/bindings/pwm/pwm-sifive.txt    |  2 +-
> >  .../devicetree/bindings/pwm/pwm-stm32-lp.txt  |  2 +-
> >  .../devicetree/bindings/pwm/pwm-stm32.txt     |  2 +-
> >  .../devicetree/bindings/pwm/pwm-tiecap.txt    |  2 +-
> >  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt  |  2 +-
> >  .../devicetree/bindings/pwm/pwm-zx.txt        |  2 +-
> >  Documentation/devicetree/bindings/pwm/pwm.txt | 69 -----------------
> >  .../devicetree/bindings/pwm/pwm.yaml          | 30 ++++++++
> >  .../bindings/pwm/renesas,pwm-rcar.txt         |  2 +-
> >  .../bindings/pwm/renesas,tpu-pwm.txt          |  4 +-
> >  .../devicetree/bindings/pwm/spear-pwm.txt     |  2 +-
> >  .../devicetree/bindings/pwm/st,stmpe-pwm.txt  |  2 +-
> >  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  2 +-
> >  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  2 +-
> >  .../devicetree/bindings/pwm/vt8500-pwm.txt    |  2 +-
> >  .../bindings/regulator/pwm-regulator.txt      |  2 +-
> >  .../devicetree/bindings/timer/ingenic,tcu.txt |  2 +-
>
> We've been leaving the .txt file with a reference to the schema file
> to avoid doing all the updates. But as you've done it already, that's
> good.
>
> >  47 files changed, 151 insertions(+), 114 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm.txt
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm.yaml
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
> > new file mode 100644
> > index 000000000000..39c844fe6338
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-consumers.yaml
>
> We already have a PWM consumer schema in dt-schema repository. It
> doesn't have the descriptions because we need permission to relicense.
> My aim is to have all common schema in the dt-schema repo, but we have
> a mixture because of needing to relicense.

I forgot to check it. In such case the pwm-consumers here do not offer
much more, except some description and examples. I guess it can be
just dropped then?

> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm-consumers.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Specifying PWM information for devices
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +
> > +description: |
> > +  PWM properties should be named "pwms". The exact meaning of each pwms
> > +  property must be documented in the device tree binding for each device.
> > +  An optional property "pwm-names" may contain a list of strings to label
> > +  each of the PWM devices listed in the "pwms" property. If no "pwm-names"
> > +  property is given, the name of the user node will be used as fallback.
> > +
> > +  Drivers for devices that use more than a single PWM device can use the
> > +  "pwm-names" property to map the name of the PWM device requested by the
> > +  pwm_get() call to an index into the list given by the "pwms" property.
> > +
> > +properties:
> > +  pwms:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: |
> > +      Phandle to PWM controller node and pwm-specifier (controller specific).
> > +      pwm-specifier typically encodes the chip-relative PWM number and the PWM
> > +      period in nanoseconds.
> > +      Optionally, the pwm-specifier can encode a number of flags (defined in
> > +      <dt-bindings/pwm/pwm.h>) in a third cell:
> > +        - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > +
> > +  pwm-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description:
> > +      A list of strings to label each of the PWM devices listed in the "pwms"
> > +      property. If no "pwm-names" property is given, the name of the user node
> > +      will be used as fallback.
> > +
> > +required:
> > +  - pwms
>
> Doing this means every consumer has to include this file where as I do
> 'select: true' some every occurrence of these properties is checked.
> We're generally only including other schema on the provider side.
>
> > +
> > +dependencies:
> > +  pwm-names: [ pwms ]
> > +
> > +examples:
> > +  - |
> > +    // The following example could be used to describe a PWM-based
> > +    // backlight device:
> > +
> > +    pwm: pwm {
> > +      #pwm-cells = <2>;
> > +    };
> > +
> > +    bl: backlight {
> > +      pwms = <&pwm 0 5000000>;
> > +      pwm-names = "backlight";
> > +    };
> > +
> > +    // Note that in the example above, specifying the "pwm-names" is redundant
> > +    // because the name "backlight" would be used as fallback anyway.
> > +
> > +  - |
> > +    // Example with optional PWM specifier for inverse polarity
> > +
> > +    #include <dt-bindings/pwm/pwm.h>
> > +
> > +    pwm2: pwm {
> > +      #pwm-cells = <3>;
> > +    };
> > +
> > +    backlight {
> > +      pwms = <&pwm2 0 5000000 PWM_POLARITY_INVERTED>;
> > +      pwm-names = "backlight";
> > +    };
>
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > new file mode 100644
> > index 000000000000..5d8029f11ccc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PWM controllers (providers)
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^pwm(@.*)?$"
>
> Copy the pattern for spi. We allow for 'pwm-[0-9]' for cases like GPIO PWMs.

Sure

>
> > +
> > +  "#pwm-cells":
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> You don't actually need to define the type as we already have for '#.*-cells'

OK.

Best regards,
Krzysztof
