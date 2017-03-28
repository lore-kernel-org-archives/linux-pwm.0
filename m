From: Sylvain Lemieux <slemieux.tyco@gmail.com>
Subject: Re: [RESEND PATCH 1/3] dt: pwm: lpc32xx: add description of clocks
 and #pwm-cells properties
Date: Tue, 28 Mar 2017 13:24:01 -0400
Message-ID: <1490721841.24147.1.camel@gmail.com>
References: <20170216202749.20653-1-slemieux.tyco@gmail.com>
 <20170216202749.20653-2-slemieux.tyco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170216202749.20653-2-slemieux.tyco@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, vz@mleia.com
List-Id: linux-pwm@vger.kernel.org

ping

On Thu, 2017-02-16 at 15:27 -0500, slemieux.tyco@gmail.com wrote:
> From: Vladimir Zapolskiy <vz@mleia.com>
> 
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> Another added to the description property 'clocks' has a standard meaning
> of a controller supply clock, in the LPC32xx User's Manual the clock is
> denoted as PWM1_CLK or PWM2_CLK clock.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> index 74b5bc5dd19a..523d79662861 100644
> --- a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
> @@ -3,15 +3,22 @@ LPC32XX PWM controller
>  Required properties:
>  - compatible: should be "nxp,lpc3220-pwm"
>  - reg: physical base address and length of the controller's registers
> +- clocks: clock phandle and clock specifier pair
> +- #pwm-cells: should be 1, the cell is used to specify the period in
> +  nanoseconds.
>  
>  Examples:
>  
>  pwm@4005c000 {
>  	compatible = "nxp,lpc3220-pwm";
>  	reg = <0x4005c000 0x4>;
> +	clocks = <&clk LPC32XX_CLK_PWM1>;
> +	#pwm-cells = <1>;
>  };
>  
>  pwm@4005c004 {
>  	compatible = "nxp,lpc3220-pwm";
>  	reg = <0x4005c004 0x4>;
> +	clocks = <&clk LPC32XX_CLK_PWM2>;
> +	#pwm-cells = <1>;
>  };
