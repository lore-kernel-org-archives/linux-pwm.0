From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Date: Mon, 4 Nov 2019 09:03:59 +0100
Message-ID: <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191103203334.10539-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Sun, Nov 03, 2019 at 09:33:28PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
> 
> Expand Allwinner PWM binding with H6 PWM specifics.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..bf36ea509f31 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,46 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>  
>    reg:
>      maxItems: 1
>  
> -  clocks:
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clocks: true
> +  clock-names: true
> +  resets:
>      maxItems: 1
>  
> +  if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: allwinner,sun50i-h6-pwm
> +
> +  then:
> +    properties:
> +      clocks:
> +        items:
> +          - description: Module Clock
> +          - description: Bus Clock
> +
> +      clock-names:
> +        items:
> +          - const: mod
> +          - const: bus
> +
> +    required:
> +      - clock-names
> +      - resets
> +
> +  else:
> +    properties:
> +      clocks:
> +        maxItems: 1
> +

I guess this hunk says "If this is a allwinner,sun50i-h6-pwm, a mod and
bus clock is required.", right?

I wonder if it is sensible to require a clock-names property in the else
branch, too. This would make it obvious if the clock there corresponds
to the "mod" or the "bus" clock on H6. (I guess it's "mod".)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
