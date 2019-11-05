From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Date: Tue, 5 Nov 2019 15:33:19 -0600
Message-ID: <20191105213319.GA30538@bogus>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-2-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191105131456.32400-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 'Uwe =?iso-8859-1?Q?Kleine-K=F6nig'?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 05, 2019 at 02:14:50PM +0100, Clément Péron wrote:
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
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..9fc32c1d94b4 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,50 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>  
>    reg:
>      maxItems: 1
>  
>    clocks:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Bus Clock
> +      - description: Module Clock

The order here doesn't match the if/then or the example.

> +
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clock-names: true

blank line here.

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
> +        minItems: 2
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
>  required:
>    - "#pwm-cells"
>    - compatible
> @@ -54,4 +91,14 @@ examples:
>          #pwm-cells = <3>;
>      };
>  
> +  - |
> +    pwm@300a000 {
> +      compatible = "allwinner,sun50i-h6-pwm";
> +      reg = <0x0300a000 0x400>;
> +      clocks = <&osc24M>, <&ccu CLK_BUS_PWM>;
> +      clock-names = "mod", "bus";
> +      resets = <&ccu RST_BUS_PWM>;
> +      #pwm-cells = <3>;
> +    };
> +
>  ...
> -- 
> 2.20.1
> 
