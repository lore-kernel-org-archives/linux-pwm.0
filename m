From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Date: Mon, 18 May 2020 08:21:43 -0600
Message-ID: <20200518142143.GB3594@bogus>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:45278 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROVp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 10:21:45 -0400
Content-Disposition: inline
In-Reply-To: <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: vineetha.g.jaya.kumaran@intel.com
Cc: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com

On Sun, May 17, 2020 at 09:52:40PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>
> 
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
> 
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> ---
>  .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml

Use compatible string for filename: intel,keembay-pwn.yaml

> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> new file mode 100644
> index 0000000..00968d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
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
> +    description:
> +        phandle to the reference clock.

How many clocks? (maxItems: 1?)

You can drop the description.

> +
> +required:
> + - compatible
> + - reg
> + - clocks
> +
> +examples:
> +  - |
> +    pwm@203200a0 {
> +      compatible = "intel,keembay-pwm";
> +      reg = <0x0 0x203200a0 0x0 0xe8>;
> +      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
> +    };
> -- 
> 1.9.1
> 
