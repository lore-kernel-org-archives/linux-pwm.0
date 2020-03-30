From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 04/18] dt-bindings: mfd: Add bindings for sl28cpld
Date: Mon, 30 Mar 2020 16:35:35 -0600
Message-ID: <20200330223535.GA31402@bogus>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-5-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200317205017.28280-5-michael@walle.cc>
Sender: linux-hwmon-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 17, 2020 at 09:50:03PM +0100, Michael Walle wrote:
> This adds device tree bindings for the board management controller found
> on the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/mfd/kontron,sl28cpld.yaml        | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> new file mode 100644
> index 000000000000..3b9cca49d2d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kontron's sl28cpld board management controller
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  The board management controller may contain different IP blocks like
> +  watchdog, fan monitoring, PWM controller, interrupt controller and a
> +  GPIO controller.
> +
> +properties:
> +  compatible:
> +    const: kontron,sl28cpld
> +
> +  reg:
> +    description:
> +      I2C device address.
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +patternProperties:
> +  "^gp(io|i|o)(@[0-9]+)?$":

Just 'gpio'. We don't need that level of distinguishing in node names.

> +    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
> +
> +  "^hwmon(@[0-9]+)?$":
> +    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
> +
> +  "^pwm(@[0-9]+)?$":
> +    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
> +
> +  "^watchdog(@[0-9]+)?$":
> +    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml

The patches for these files need to come first or validating this file 
fails. Really, you can just make all five files 1 patch.

> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +oneOf:
> +  - required:
> +    - interrupts
> +  - required:
> +    - interrupts-extended

Don't need to do this. Just make 'interrupts' required and you'll get 
interrupts-extended for free.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sl28cpld@4a {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "kontron,sl28cpld";
> +            reg = <0x4a>;
> +            interrupts-extended = <&gpio2 6 IRQ_TYPE_EDGE_FALLING>;
> +
> +            #interrupt-cells = <2>;
> +            interrupt-controller;
> +
> +            gpio@0 {
> +                compatible = "kontron,sl28cpld-gpio";
> +                reg = <0>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +
> +            gpio@1 {
> +                compatible = "kontron,sl28cpld-gpio";
> +                reg = <1>;
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +
> +            gpo {
> +                compatible = "kontron,sl28cpld-gpo";
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +                gpio-line-names = "a", "b", "c";
> +            };
> +
> +            gpi {
> +                compatible = "kontron,sl28cpld-gpi";
> +
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +            };
> +
> +            hwmon {
> +                compatible = "kontron,sl28cpld-fan";
> +            };
> +
> +            pwm@0 {

You already used the '0' address. You can't have 2 things at the 
same address. There's only one number space at a given level. 

All these child devices don't have any DT resources, so you don't really 
need them. The parent node could be a gpio and pwm provider and that's 
all you need in DT. Aside from DT resources, the only other reason 
to have all these child nodes are if the child blocks are going to get 
assembled in different combinations across a variety of h/w.

Rob
