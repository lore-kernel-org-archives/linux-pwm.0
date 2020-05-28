From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/2] Add YAML schema for a new PWM driver
Date: Thu, 28 May 2020 17:31:59 -0600
Message-ID: <20200528233159.GA876777@bogus>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
 <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, songjun.Wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, cheol.yong.kim-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi-ming.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, May 22, 2020 at 03:41:58PM +0800, Rahul Tanwar wrote:
> Add DT bindings YAML schema for PWM controller driver of
> Lightning Mountain(LGM) SoC.

You need a better subject such as what h/w this is for. Bindings are for 
h/w blocks, not drivers.

> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     | 43 ++++++++++++++++++++++

Use the compatible string for filename.

>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> new file mode 100644
> index 000000000000..adb33265aa5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-intel-lgm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LGM SoC PWM controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - resets

additionalProperties: false

> +
> +examples:
> +  - |
> +    pwm: pwm@e0d00000 {
> +        compatible = "intel,lgm-pwm";
> +        reg = <0xe0d00000 0x30>;
> +        #pwm-cells = <2>;
> +        clocks = <&cgu0 126>;
> +        resets = <&rcu0 0x30 21>;
> +    };
> -- 
> 2.11.0
> 
