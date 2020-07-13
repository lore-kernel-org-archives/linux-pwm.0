From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Date: Mon, 13 Jul 2020 10:46:00 -0600
Message-ID: <20200713164600.GA359372@bogus>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
 <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:38476 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGMQqD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 12:46:03 -0400
Content-Disposition: inline
In-Reply-To: <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, andriy.shevchenko@intel.com, songjun.Wu@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com

On Tue, Jun 30, 2020 at 03:55:31PM +0800, Rahul Tanwar wrote:
> Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
> which is only used to control the fan attached to the system. This
> PWM controller does not have any other consumer other than fan.
> Add DT bindings documentation for this PWM fan controller.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> new file mode 100644
> index 000000000000..120bf3d85a24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LGM SoC PWM fan controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  intel,fan-wire:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: Specifies fan mode. Default when unspecified is 2.
> +
> +  intel,max-rpm:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Specifies maximum RPM of fan attached to the system.
> +      Default when unspecified is 4000.

These are properties of the fan, not the PWM. And probably if you 
need these properties then others would too, so they should be 
common. Look at the pwm-fan.txt binding.

Rob
