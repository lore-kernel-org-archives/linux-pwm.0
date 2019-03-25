From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Date: Mon, 25 Mar 2019 15:41:37 -0500
Message-ID: <20190325204137.GA19824@bogus>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "stefan@agner.ch" <stefan@agner.ch>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, Leonard Crestez <leonard.crestez@nxp.com>, Robin Gong <yibin.gong@nxp.com>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger
List-Id: linux-pwm@vger.kernel.org

On Fri, Mar 22, 2019 at 01:48:05AM +0000, Anson Huang wrote:
> Add i.MX TPM(Low Power Timer/Pulse Width Modulation Module) PWM binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.

v9? I don't recall seeing any previous versions.

> ---
>  .../devicetree/bindings/pwm/imx-tpm-pwm.txt        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> new file mode 100644
> index 0000000..94f1ad5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
> @@ -0,0 +1,22 @@
> +Freescale i.MX TPM PWM controller
> +
> +Required properties:
> +- compatible : Should be "fsl,imx-tpm".

Needs to be SoC specific.

> +- reg: Physical base address and length of the controller's registers.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of the cells format.
> +- clocks : The clock provided by the SoC to drive the PWM.
> +- interrupts: The interrupt for the PWM controller.
> +
> +Note: The TPM counter and period counter are shared between multiple channels, so all channels
> +should use same period setting.
> +
> +Example:
> +
> +pwm0: tpm@40250000 {

pwm@...
