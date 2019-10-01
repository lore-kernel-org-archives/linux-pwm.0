From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: sram: Convert SRAM bindings to
 json-schema
Date: Tue, 1 Oct 2019 09:00:03 -0500
Message-ID: <20191001140003.GA31344@bogus>
References: <20190918173141.4314-1-krzk@kernel.org>
 <20190918173141.4314-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190918173141.4314-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 07:31:35PM +0200, Krzysztof Kozlowski wrote:
> Convert generic mmio-sram bindings to DT schema format using
> json-schema.

I've been slow getting to this because I started on the same thing...

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Indent example with four spaces (more readable).
> ---
>  .../devicetree/bindings/sram/sram.txt         |  80 ----------
>  .../devicetree/bindings/sram/sram.yaml        | 138 ++++++++++++++++++
>  2 files changed, 138 insertions(+), 80 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/sram.txt
>  create mode 100644 Documentation/devicetree/bindings/sram/sram.yaml

> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> new file mode 100644
> index 000000000000..8d9d6ce494b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/sram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic on-chip SRAM
> +
> +maintainers:
> +  - FIXME <who@should.it.be>

You can put me.

> +
> +description: |+
> +  Simple IO memory regions to be managed by the genalloc API.
> +
> +  Each child of the sram node specifies a region of reserved memory. Each
> +  child node should use a 'reg' property to specify a specific range of
> +  reserved memory.
> +
> +  Following the generic-names recommended practice, node names should
> +  reflect the purpose of the node. Unit address (@<address>) should be
> +  appended to the name.
> +
> +properties:
> +  $nodename:
> +    pattern: "^sram(@.*)?"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - mmio-sram
> +          - atmel,sama5d2-securam

I was trying to go down the path of putting all the compatibles for 
various SRAM bindings here, but I ran into some issues. I need to 
revisit as I've forgotten the exact issue.

This would need to be a 'contains' if this is going to work for others.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    description: Should use the same values as the root node.
> +
> +  "#size-cells":
> +    description: Should use the same values as the root node.

I defined both of these to be 1 as 4GB of SRAM should be enough for a 
while. We can debate 1 or 2 cells vs. 1, but there's no reason it has to 
be the same as the root (unless we're failing to do address 
translation).

> +
> +  ranges:
> +    description:
> +      Should translate from local addresses within the sram to bus addresses.
> +
> +  no-memory-wc:
> +    description:
> +      The flag indicating, that SRAM memory region has not to be remapped
> +      as write combining. WC is used by default.
> +    type: boolean
> +
> +  # TODO: additionalProperties: false
> +
> +patternProperties:
> +  "^([a-z]*-)?sram@[a-f0-9]$":
> +    type: object
> +    description:
> +      Each child of the sram node specifies a region of reserved memory.
> +    properties:
> +      reg:
> +        description:
> +          IO mem address range, relative to the SRAM range.

maxItems: 1

> +
> +      compatible:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          Should contain a vendor specific string in the form
> +          <vendor>,[<device>-]<usage>
> +
> +      pool:
> +        description:
> +          Indicates that the particular reserved SRAM area is addressable
> +          and in use by another device or devices.
> +        type: boolean
> +
> +      export:
> +        description:
> +          Indicates that the reserved SRAM area may be accessed outside
> +          of the kernel, e.g. by bootloader or userspace.
> +        type: boolean
> +
> +      protect-exec:
> +        description: |
> +          Same as 'pool' above but with the additional constraint that code
> +          will be run from the region and that the memory is maintained as
> +          read-only, executable during code execution. NOTE: This region must
> +          be page aligned on start and end in order to properly allow
> +          manipulation of the page attributes.
> +        type: boolean
> +
> +      label:
> +        $ref: /schemas/types.yaml#/definitions/string

Already has a type definition.

> +        description:
> +          The name for the reserved partition, if omitted, the label is taken
> +          from the node name excluding the unit address.
> +
> +      clocks:
> +        description:
> +          A list of phandle and clock specifier pair that controls the
> +          single SRAM clock.
> +
> +      # TODO: additionalProperties: false
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +examples:
> +  - |
> +    sram: sram@5c000000 {
> +        compatible = "mmio-sram";
> +        reg = <0x5c000000 0x40000>; /* 256 KiB SRAM at address 0x5c000000 */
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0 0x5c000000 0x40000>;
> +
> +        smp-sram@100 {
> +            compatible = "socvendor,smp-sram";
> +            reg = <0x100 0x50>;
> +        };
> +
> +        device-sram@1000 {
> +            reg = <0x1000 0x1000>;
> +            pool;
> +        };
> +
> +        exported@20000 {
> +            reg = <0x20000 0x20000>;
> +            export;
> +        };
> +    };
> -- 
> 2.17.1
> 
