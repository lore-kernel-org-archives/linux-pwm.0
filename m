From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 4/4] pwm: sunxi: Add H3 support
Date: Thu, 1 Sep 2016 12:39:18 +0200
Message-ID: <20160901103918.dphgrha7ega3752o@piout.net>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-5-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38808 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932588AbcIAKja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2016 06:39:30 -0400
Content-Disposition: inline
In-Reply-To: <20160831082520.25962-5-woogyom.kim@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 31/08/2016 at 17:25:20 +0900, Milo Kim wrote :
> H3 PWM controller has same register layout as sun4i driver, so it works
> by adding H3 specific data.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-pwm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 1 +
>  drivers/pwm/pwm-sun4i.c                             | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> index cf6068b..f1cbeef 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
> @@ -6,6 +6,7 @@ Required properties:
>      - "allwinner,sun5i-a10s-pwm"
>      - "allwinner,sun5i-a13-pwm"
>      - "allwinner,sun7i-a20-pwm"
> +    - "allwinner,sun8i-h3-pwm"
>    - reg: physical base address and length of the controller's registers
>    - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>      the cells format.
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..b0803f6 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -284,6 +284,12 @@ static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {
>  	.npwm = 2,
>  };
>  
> +static const struct sun4i_pwm_data sun4i_pwm_data_h3 = {
> +	.has_prescaler_bypass = true,
> +	.has_rdy = true,
> +	.npwm = 1,
> +};
> +
>  static const struct of_device_id sun4i_pwm_dt_ids[] = {
>  	{
>  		.compatible = "allwinner,sun4i-a10-pwm",
> @@ -298,6 +304,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] = {
>  		.compatible = "allwinner,sun7i-a20-pwm",
>  		.data = &sun4i_pwm_data_a20,
>  	}, {
> +		.compatible = "allwinner,sun8i-h3-pwm",
> +		.data = &sun4i_pwm_data_h3,
> +	}, {
>  		/* sentinel */
>  	},
>  };
> -- 
> 2.9.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
