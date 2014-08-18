From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv3 3/3] pwm: documentation: Add 'big-endian' property for
 FTM PWM.
Date: Mon, 18 Aug 2014 10:59:40 +0100
Message-ID: <20140818095939.GE14559@leverpostej>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <1408332755-35102-4-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:44856 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754452AbaHRKAt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Aug 2014 06:00:49 -0400
Content-Disposition: inline
In-Reply-To: <1408332755-35102-4-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Mon, Aug 18, 2014 at 04:32:35AM +0100, Xiubo Li wrote:
> For the same FTM PWM device, which on different SoCs will in
> differrent endian mode, using the same linux device driver need
> one boolean properties to distingush this.
> 
> For now the FTM PWM is only applied to the ARM SoCs which are all
> in LE mode.
> 
> So the DT binding for FTM PWM device endian:
> SoC     |  FTM-PWM | 'big-endian' property is needed?
> --------|----------|---------------------------------
> Vybird  |    LE    |     No
> LS1     |    BE    |     Yes
> LS2     |    LE    |     No
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  .../devicetree/bindings/pwm/pwm-fsl-ftm.txt        | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> index 0bda229..67ed8d6 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-fsl-ftm.txt
> @@ -1,5 +1,23 @@
>  Freescale FlexTimer Module (FTM) PWM controller
>  
> +For the same FTM PWM device, which on different SoCs will in
> +differrent endian mode, using the same linux device driver need
> +one boolean properties to distingush this.

There is absolutely no need to mention Linux if this is truly a HW
property.

> +
> +For now the FTM PWM is only applied to the ARM SoCs which are all
> +in LE mode.
> +
> +So the DT binding for FTM PWM device endian:
> +SoC     |  FTM-PWM | 'big-endian' property is needed?
> +--------|----------|---------------------------------
> +Vybird  |    LE    |     No
> +LS1     |    BE    |     Yes
> +LS2     |    LE    |     No
> +
> +Please see "Documentation/devicetree/bindings/regmap/regmap.txt" for more
> +detail about the endianness.

Surely all we need is:

The FTM PWM device can be integrated as little-endian or big-endian.
This endianness differs per SoC:

SoC     | FTM-PWM endianness
--------+-------------------
Vybrid  | LE
LS1     | BE
LS2     | LE

> +
> +
>  Required properties:
>  - compatible: Should be "fsl,vf610-ftm-pwm".
>  - reg: Physical base address and length of the controller's registers
> @@ -16,7 +34,8 @@ Required properties:
>  - pinctrl-names: Must contain a "default" entry.
>  - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
>    See pinctrl/pinctrl-bindings.txt for details of the property values.
> -
> +- big-endian: One boolean property, for all the device registers, the BE mode
> +  will be in use if it's present, or the LE mode will be in use.

- big-endian: Boolean property, required if all the FTM_PWM registers
  are big-endian rather than little-endian.

Cheers,
Mark.

>  
>  Example:
>  
> @@ -32,4 +51,5 @@ pwm0: pwm@40038000 {
>  			<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pwm0_1>;
> +		big-endian;
>  };
> -- 
> 1.8.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
