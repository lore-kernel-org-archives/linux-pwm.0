From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Date: Tue, 5 Nov 2019 22:15:18 -0600
Message-ID: <20191106041518.GC5294@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-5-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191031123040.26316-5-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Oct 31, 2019 at 01:30:40PM +0100, Benjamin Gaignard wrote:
> Convert the STM32 timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 91 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       | 73 -----------------
>  2 files changed, 91 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> new file mode 100644
> index 000000000000..3f0a65fb2bc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/st,stm32-timers.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Timers bindings
> +
> +description: |
> +  This hardware block provides 3 types of timer along with PWM functionality: \

Don't need the \

> +    - advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable \
> +      prescaler, break input feature, PWM outputs and complementary PWM ouputs channels. \
> +    - general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a \
> +      programmable prescaler and PWM outputs.\
> +    - basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
> +
> +maintainers:
> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> +
> +allOf:
> +  - $ref: "../pwm/st,stm32-pwm.yaml#"
> +  - $ref: "../iio/timer/st,stm32-timer-trigger.yaml#"
> +  - $ref: "../counter/st,stm32-timer-cnt.yaml#"

This works, but I prefer the child node names be listed under properties 
here with a ref:

counter:
  $ref: "../counter/st,stm32-timer-cnt.yaml#"

> +
> +properties:
> +  compatible:
> +    const: st,stm32-timers
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: int
> +
> +  reset:
> +    maxItems: 1
> +
> +  dmas: true

How many?

> +
> +  dma-names: true

What are the names?

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - "#address-cells"
> +  - "#size-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    timers2: timer@40000000 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      compatible = "st,stm32-timers";
> +      reg = <0x40000000 0x400>;
> +      clocks = <&rcc TIM2_K>;
> +      clock-names = "int";
> +      dmas = <&dmamux1 18 0x400 0x1>,
> +             <&dmamux1 19 0x400 0x1>,
> +             <&dmamux1 20 0x400 0x1>,
> +             <&dmamux1 21 0x400 0x1>,
> +             <&dmamux1 22 0x400 0x1>;
> +      dma-names = "ch1", "ch2", "ch3", "ch4", "up";
> +      pwm {
> +        compatible = "st,stm32-pwm";
> +        #pwm-cells = <3>;
> +        st,breakinput = <0 1 5>;
> +      };
> +      timer@0 {
> +        compatible = "st,stm32-timer-trigger";
> +        reg = <0>;
> +      };
> +      counter {
> +        compatible = "st,stm32-timer-counter";
> +      };
> +    };
> +
> +...
