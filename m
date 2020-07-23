From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Date: Thu, 23 Jul 2020 11:47:01 -0600
Message-ID: <20200723174701.GA584130@bogus>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:34953 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRrF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 13:47:05 -0400
Content-Disposition: inline
In-Reply-To: <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vineetha.g.jaya.kumaran@intel.com
Cc: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com

On Sat, Jul 18, 2020 at 10:47:08PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,keembay-pwm.yaml | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> new file mode 100644
> index 00000000..e9388a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/intel,keembay-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Keem Bay PWM Device Tree Bindings
> +
> +maintainers:
> +  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - intel,keembay-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> + - compatible
> + - reg
> + - clocks
> + - '#pwm-cells'

Add:

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +examples:
> +  - |
> +    #define KEEM_BAY_A53_GPIO
> +
> +    pwm@203200a0 {
> +      compatible = "intel,keembay-pwm";
> +      reg = <0x203200a0 0xe8>;
> +      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
> +      #pwm-cells = <2>;
> +    };
> -- 
> 1.9.1
> 
