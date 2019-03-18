From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH V5 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Mon, 18 Mar 2019 09:18:46 +0100
Message-ID: <d1f8b006ad56e8ed4e9fb9137148d98b@agner.ch>
References: <1552894581-3391-1-git-send-email-Anson.Huang@nxp.com>
 <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552894581-3391-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux@armlinux.org.uk, otavio@ossystems.com.br, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, jan.tuerk@emtrion.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On 18.03.2019 08:41, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..d47b8fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm-pwm".
> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 2. See pwm.txt in this directory for a
> description of the cells format.

It seems that the driver supports polarity. Can we use 3 cells so we can
specify the polarity in the device tree?

Also use 3 cells in the base device tree to enable other boards making
use of the polarity (arch/arm/boot/dts/imx7ulp.dtsi).

--
Stefan

> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the pwm controller.
> +
> +Example:
> +
> +pwm0: tpm@40250000 {
> +	compatible = "fsl,imx-tpm-pwm";
> +	reg = <0x40250000 0x1000>;
> +	assigned-clocks = <&clks IMX7ULP_CLK_LPTPM4>;
> +	assigned-clock-parents = <&clks IMX7ULP_CLK_SOSC_BUS_CLK>;
> +	clocks = <&clks IMX7ULP_CLK_LPTPM4>;
> +	#pwm-cells = <2>;
> +};
